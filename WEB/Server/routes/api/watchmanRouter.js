const router = require('express').Router();
const managerAuth = require(`../../controllers/managerAuth`);

const dbModule = require(`../../database`)();
const dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

const dbPromiseConnection = require(`../../databasePromise`);

function nowDate() {
    let krDate = new Date();
    krDate.setHours(krDate.getHours()+9);
    return krDate.toISOString().slice(0, 10).replace('T', ' ');
}

router.post('/', managerAuth.checkLogin, async (req, res) => {
    var msg = {4: 'db_error', 5: 'duplicate'};

    var sql = "SELECT * FROM watchman WHERE manager_tags=? AND responsible_date=? AND charge_doom=? and shift IS NULL";
    let [isDuplicate] = await dbPromiseConnection.query(sql, [req.body.manager_tags, req.body.responsible_date, req.body.charge_doom]);
    
    if(isDuplicate.length) 
        return res.status(409).json({
            code: 5,
            msg: msg[5],
        });
    
    sql = "INSERT INTO watchman VALUES (NULL, ?, ?, ?, NULL)";
    dbConnection.query(sql, [req.body.manager_tags, req.body.charge_doom, req.body.responsible_date], (err, result) => {
        if(err)
            return res.status(400).json({
                code: 4,
                msg: msg[4],
                err
            });
        
        return res.status(201).json({
            code: 1,
            msg: "success",
            insertId: result.insertId,
            data: req.body,
        });
    });
});

router.get('/', (req, res) => {
    var msg = {4: 'db_error'};

    var sql = "SELECT * FROM watchman";
    dbConnection.query(sql, (err, rows) => {
        if(err)
            return res.status(400).json({
                code: 4,
                msg: msg[4],
                err
            });
        if(!rows.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });

        return res.status(200).json({
            code: 1,
            msg: "success",
            total: rows.length,
            data: rows
        });
    });
});


router.get('/search', (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};

    var sql = "SELECT * FROM watchman";

    if(Object.keys(req.query).length) {
        sql += " WHERE";
        for(key in req.query) {
            if(key === 'year') sql +=  ' year(responsible_date) = ? AND';
            else if(key === 'month') sql +=  ' month(responsible_date) = ? AND';  
            else sql += ` ${key} = ? AND`;
        }
        sql = sql.substr(0, sql.length - 3);
    }
    console.log(sql);
    dbConnection.query(sql, Object.values(req.query), (err, rows) => {
        if(err)
            return res.status(400).json({
                code: 4,
                msg: msg[4],
                err
            });
        if(!rows.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2],
            });

        return res.status(200).json({
            code: 1,
            msg: "success",
            total: rows.length,
            data: rows
        });
    });
});

router.get('/myCharge', managerAuth.checkLogin, (req, res) => {
    var msg = {2:'off_today.', 4: 'db_error'};
    var sql = "SELECT * FROM watchman WHERE manager_tags=? AND responsible_date=?";

    dbConnection.query(sql, [req.user.tag, nowDate()], (err, rows) => {
        if(err)
            return res.status(400).json({
                code: 4,
                msg: msg[4],
                err
            });
        if(!rows.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2],
            });

        return res.status(200).json({
            code: 1,
            msg: "success",
            data: rows[0]
        });
    });
});

router.get('/myCharge/details', managerAuth.checkLogin, async (req, res) => {
    var msg = {2:'off_today.', 4: 'db_error'};
    try {
        let sql = "SELECT * FROM watchman WHERE manager_tags=? AND responsible_date=?";
        let [chargeDooms] = await dbPromiseConnection.query(sql, [req.user.tag, nowDate()]);

        if(!chargeDooms.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2],
            });
        
        let results = [];
        
        for(let chargeDoom of chargeDooms){
            let doomResults = [];
            sql ="SELECT name FROM doom WHERE id=?";
            let [doomname] = await dbPromiseConnection.query(sql, [chargeDoom.charge_doom]);

            sql ="SELECT * FROM doomroom WHERE doom_id=? ORDER BY floor";
            let [doomrooms] = await dbPromiseConnection.query(sql, [chargeDoom.charge_doom]);
            for(let doomroom of doomrooms) {
                let found = doomResults.find(d => d.floor === doomroom.floor);
                doomroom.doomroom_id = doomroom.id;
                delete doomroom.id;

                sql ="SELECT * FROM room_picker WHERE beacon_id=?";
                let [roompickerInfo] = await dbPromiseConnection.query(sql, [doomroom.beacon_id]);
                if(roompickerInfo[0]) doomroom.room_picker = roompickerInfo[0];
                
                if(!found) 
                    doomResults.push({floor: doomroom.floor, name: doomroom.floor+"층", items: [{...doomroom}]});
                else 
                    found.items.push({...doomroom});
            }

            sql ="SELECT * FROM doomfacility WHERE doom_id=? ORDER BY floor";
            let [doomfacilities] = await dbPromiseConnection.query(sql, [chargeDoom.charge_doom]);
            for(let doomfacility of doomfacilities) {
                let found = doomResults.find(d => d.floor === doomfacility.floor);
                doomfacility.doomfacility_id = doomfacility.id;
                delete doomfacility.id;

                sql ="SELECT * FROM room_picker WHERE beacon_id=?";
                let [roompickerInfo] = await dbPromiseConnection.query(sql, [doomfacility.beacon_id]);
                if(roompickerInfo[0]) doomfacility.room_picker = roompickerInfo[0];

                if(!found) 
                    doomResults.push({floor: doomfacility.floor, name: doomfacility.floor+"층", items: [{...doomfacility}]});
                else 
                    found.items.push({...doomfacility});
            }

            results.push({doom_id: chargeDoom.charge_doom, doom_name: doomname[0].name, items:[...doomResults]});
        }

        return res.status(200).json({
            code: 1,
            msg: "success",
            total: results.length,
            data: results
        });
    }
    catch(err) {
        console.log(err)
        return res.status(400).json({
            code: 4,
            msg: msg[4],
            err: err
        });
    }
});


router.get('/today', (req, res) => {
    var msg = {2:'no_watchman', 4: 'db_error'};
    var sql = "SELECT * FROM watchman WHERE responsible_date=? AND shift IS NULL";
    if(req.query.doom_id) 
        sql += ' AND charge_doom=?';

    dbConnection.query(sql, [nowDate(), req.query.doom_id], (err, rows) => {
        if(err)
            return res.status(400).json({
                code: 4,
                msg: msg[4],
                err
            });
        if(!rows.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2],
            });

        return res.status(200).json({
            code: 1,
            msg: "success",
            total: rows.length,
            data: rows
        });
    });
});


router.post('/shift/:id', managerAuth.checkLogin, (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};

    var sql = "SELECT * FROM watchman WHERE id=?";
    dbConnection.query(sql,[req.params.id], (err, rows) => {
        if(err)
            return res.status(400).json({
                code: 4,
                msg: msg[4],
                err
            });
        if(!rows.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });
        
            
        sql = "UPDATE watchman SET shift=? WHERE id=?";
        dbConnection.query(sql, [req.body.shift_reason, req.params.id], (err, reslut) => {
            if(err)
                return res.status(400).json({
                    code: 4,
                    msg: msg[4],
                    err
                });
            
            sql = "INSERT INTO watchman VALUES (NULL, ?, ?, ?, NULL)";
            dbConnection.query(sql, [req.body.substitute_tag, rows[0].charge_doom, rows[0].responsible_date], (err, result) => {
                if(err)
                    return res.status(400).json({
                        code: 4,
                        msg: msg[4],
                        err
                    });
                return res.status(201).json({
                    code: 1,
                    msg: "success",
                    insertId: result.insertId,
                    data: req.body,
                });
            });
        });
    });
});


router.get('/:id', (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};

    var sql = "SELECT * FROM watchman WHERE id=?";
    dbConnection.query(sql,[req.params.id], (err, rows) => {
        if(err)
            return res.status(400).json({
                code: 4,
                msg: msg[4],
                err
            });
        if(!rows.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });

        return res.status(200).json({
            code: 1,
            msg: "success",
            data: rows[0]
        });
    });
});


router.put('/:id', managerAuth.checkLogin, (req, res) => {
    var msg = {4: 'db_error'};

    var sql = "UPDATE watchman SET ";
    for(key in req.body)
        sql += ` ${key} = ?, `;
    sql = sql.substr(0, sql.length - 2);
    sql += " WHERE id=? "

    dbConnection.query(sql, [...Object.values(req.body), req.params.id], (err, rows) => {
        if(err)
            return res.status(400).json({
                code: 4,
                msg: msg[4],
                err
            });
        if(!rows.affectedRows)
            return res.status(200).json({
                code: 2,
                msg: msg[2],
            });

        return res.status(200).json({
            code: 1,
            msg: "success",
            data: req.body,
        });
    });
});

router.delete('/:id', managerAuth.checkLogin, (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};

    var sql = "DELETE FROM watchman WHERE id=?";
    dbConnection.query(sql, [req.params.id], (err, rows) => {
        if(err)
            return res.status(400).json({
                code: 4,
                msg: msg[4],
                err
            });
        if(!rows.affectedRows)
            return res.status(200).json({
                code: 2,
                msg: msg[2],
            });

        return res.status(200).json({
            code: 1,
            msg: "success",
        });
    });
});



module.exports = router;