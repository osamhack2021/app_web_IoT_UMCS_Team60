const router = require('express').Router();
const managerAuth = require(`../../controllers/managerAuth`);
const dbPromiseConnection = require(`../../databasePromise`);

function nowDateTime() {
    let krDate = new Date();
    krDate.setHours(krDate.getHours()+9);
    return krDate.toISOString().slice(0, 19).replace('T', ' ');
}

router.post('/', managerAuth.checkLogin, async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "INSERT INTO room_picker VALUE (NULL, ?, ?, ?, NULL, ?)";
        var [result] = await dbPromiseConnection.query(sql, [req.body.x, req.body.y, req.body.size, req.body.beacon_id]);
        
        return res.status(201).json({
            code: 1,
            msg: "success",
            insertId: result.insertId,
            data: req.body,
        });
    } 
    catch(err) {
        console.log(err)
        return res.status(400).json({
            code: 4,
            msg: msg[4],
            err
        });
    }
});


router.get('/', async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "SELECT * FROM room_picker";
        var [results] = await dbPromiseConnection.query(sql);
        
        if(!results.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });

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
            err
        });
    }
});


router.get('/search', async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "SELECT * FROM room_picker"
        if(Object.keys(req.query).length) {
            sql += " WHERE";
            for(key in req.query)
                sql += ` ${key} = ? AND`;
            sql = sql.substr(0, sql.length - 3);
        }
        var [results] = await dbPromiseConnection.query(sql, Object.values(req.query));
        
        if(!results.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });

        return res.status(200).json({
            code: 1,
            msg: "success",
            total: results.length,
            data: results
        });
    } catch(err) {
        console.log(err)
        return res.status(400).json({
            code: 4,
            msg: msg[4],
            err
        });
    }
});

router.get('/:id', async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "SELECT * FROM room_picker WHERE id=?"
        var [results] = await dbPromiseConnection.query(sql, [req.params.id]);
        
        if(!results.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });

        return res.status(200).json({
            code: 1,
            msg: "success",
            data: results[0]
        });
    } catch(err) {
        console.log(err)
        return res.status(400).json({
            code: 4,
            msg: msg[4],
            err
        });
    }
});

router.put('/:id', managerAuth.checkLogin, (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};

    var sql = "UPDATE room_picker SET ";
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

router.delete('/:id', managerAuth.checkLogin, async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "DELETE FROM room_picker WHERE id=?";
        var [results] = await dbPromiseConnection.query(sql, [req.params.id]);

        if(!results.affectedRows)
            return res.status(200).json({
                code: 2,
                msg: msg[2],
            });

        return res.status(200).json({
            code: 1,
            msg: "success",
        });

    } catch(err) {
        console.log(err)
        return res.status(400).json({
            code: 4,
            msg: msg[4],
            err
        });
    }
});
  


module.exports = router;