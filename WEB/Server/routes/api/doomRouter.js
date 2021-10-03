const router = require('express').Router();
const managerAuth = require(`../../controllers/managerAuth`);

const dbModule = require(`../../database`)();
const dbConnection = dbModule.init();
dbModule.db_open(dbConnection);


router.post('/', managerAuth.checkLogin, (req, res) => {
    var msg = {4: 'db_error'};

    var sql = "INSERT INTO doom VALUES (NULL, ?, ?)";
    dbConnection.query(sql, [req.body.name, req.body.beacon_id], (err, result) => {
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
    var msg = {2:'not_found', 4: 'db_error'};

    var sql = "SELECT * FROM doom";
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

    var sql = "SELECT * FROM doom";

    if(Object.keys(req.query).length) {
        sql += " WHERE";
        for(key in req.query)
            sql += ` ${key} = ? AND`;
        sql = sql.substr(0, sql.length - 3);
    }
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


router.get('/:id', (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};

    var sql = "SELECT * FROM doom WHERE id=?";
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
    var msg = {2:'not_found', 4: 'db_error'};

    var sql = "UPDATE doom SET ";
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

    var sql = "DELETE FROM doom WHERE id=?";
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