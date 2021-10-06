const router = require('express').Router();
const managerAuth = require(`../../controllers/managerAuth`);
const userAuth = require(`../../controllers/userAuth`);
const dbPromiseConnection = require(`../../databasePromise`);

function nowDateTime() {
    let krDate = new Date();
    krDate.setHours(krDate.getHours()+9);
    return krDate.toISOString().slice(0, 19).replace('T', ' ');
}

router.post('/', userAuth.checkJWTValid, async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "INSERT INTO anomaly VALUE (NULL, ?, ?, ?, ?)";
        var [results] = await dbPromiseConnection.query(sql, [req.user.tag, req.body.temperature, req.body.anomaly, nowDateTime()]);
        
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
        var sql = "SELECT a.*, u.rank, u.name FROM anomaly a, user u WHERE a.user_tag=u.tag";
        var [results] = await dbPromiseConnection.query(sql);
        
        if(!results.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });
            
        for(let result of results) 
            if(!result.details) result.details = '';    
        
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
        var sql = "SELECT a.*, u.rank, u.name FROM anomaly a, user u WHERE a.user_tag=u.tag";
        for(key in req.query) {
            if(key === 'reported_date') key = 'DATE(reported_time)';
            sql += ` AND ${key} = ?`;
        }
        
        var [results] = await dbPromiseConnection.query(sql, Object.values(req.query));
        
        if(!results.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });
        
        for(let result of results) 
            if(!result.details) result.details = '';  

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
        var sql = "SELECT a.*, u.rank, u.name FROM anomaly a, user u WHERE a.user_tag=u.tag AND id=?";
        var [results] = await dbPromiseConnection.query(sql, [req.params.id]);
        
        if(!results.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });

        for(let result of results) 
            if(!result.details) result.details = '';  

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