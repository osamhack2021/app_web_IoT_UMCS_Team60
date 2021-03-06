const router = require('express').Router();
const managerAuth = require(`../../controllers/managerAuth`);
const userAuth = require(`../../controllers/userAuth`);
const dbPromiseConnection = require(`../../databasePromise`);

router.post('/', async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "INSERT INTO beacon VALUE (?, NULL, NULL, NULL, NULL)";
        var [results] = await dbPromiseConnection.query(sql, [req.body.id]);
        
        return res.status(201).json({
            code: 1,
            msg: "success",
            insertId: results.insertId,
            data: req.body,
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


router.get('/', managerAuth.checkLogin, async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "SELECT * FROM beacon";
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

    } catch(err) {
        console.log(err)
        return res.status(400).json({
            code: 4,
            msg: msg[4],
            err
        });
    }
});


router.get('/search', managerAuth.checkLogin, async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "SELECT * FROM beacon";
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

router.get('/:id', managerAuth.checkLogin, async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "SELECT * FROM beacon WHERE id=?";
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

module.exports = router;