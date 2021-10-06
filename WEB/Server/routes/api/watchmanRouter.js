const router = require('express').Router();
const managerAuth = require(`../../controllers/managerAuth`);

const dbModule = require(`../../database`)();
const dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

function nowDate() {
    let krDate = new Date();
    krDate.setHours(krDate.getHours()+9);
    return krDate.toISOString().slice(0, 10).replace('T', ' ');
}

router.post('/', managerAuth.checkLogin, (req, res) => {
    var msg = {4: 'db_error'};

    var sql = "INSERT INTO watchman VALUES (NULL, ?, ?, ?, NULL)";
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
        for(key in req.query)
            sql += ` ${key} = ? AND`;
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