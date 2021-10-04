const router = require('express').Router();
const userAuth = require(`../../controllers/userAuth`);

const dbPromiseConnection = require("../../databasePromise");

router.post('/register', userAuth.register, (req, res) => {
    if(req.code) 
        res.status(400).json({
            code: req.code,
            msg: req.msg,
            data: {
                tag: req.data.tag,
            }
        });
    else 
        res.status(200).json({
            code: 1,
            msg: "success",
            data: req.data,
        });
});


router.post('/login', userAuth.login, (req, res) => {
    if(req.code) 
        res.status(400).json({
            code: req.code,
            msg: req.msg,
            data: {
                tag: req.body.tag
            }
        });
    else
        res.setHeader('Authorization', 'Bearer '+ req.token).status(200).json({
            code: 1,
            msg: "success",
            data : req.data
        });
});

router.get('/check', userAuth.jwtLogin, (req, res) => {
    res.json(req.data);
});


router.get('/', async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "SELECT tag, name, `rank`, doom_id, room_id FROM user";
        const [users] = await dbPromiseConnection.query(sql);

        if(!users.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });
        
        return res.status(200).json({
            code: 1,
            msg: "success",
            total: users.length,
            data: users
        });

    } catch(err) {
        console.log(err);
        return res.status(400).json({
            code: 4,
            msg: msg[4],
            err : err
        });
    }
});


router.get('/search', async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "SELECT tag, name, `rank`, doom_id, room_id FROM user";
        if(Object.keys(req.query).length) {
            sql += " WHERE";
            for(key in req.query)  // rank는 mysql 예약어이므로 `rank` 로 sql문 보내야 함
                sql += ` \`${key}\` = ? AND`;
            sql = sql.substr(0, sql.length - 3);
        }
        
        const [users] = await dbPromiseConnection.query(sql, Object.values(req.query));

        if(!users.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });
        
        return res.status(200).json({
            code: 1,
            msg: "success",
            total: users.length,
            data: users
        });

    } catch(err) {
        console.log(err);
        return res.status(400).json({
            code: 4,
            msg: msg[4],
            err : err
        });
    }
});


router.get('/:id', async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "SELECT tag, name, `rank`, doom_id, room_id FROM user WHERE tag=?";
        const [users] = await dbPromiseConnection.query(sql, [req.params.id]);

        if(!users.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });
        
        return res.status(200).json({
            code: 1,
            msg: "success",
            data: users[0]
        });

    } catch(err) {
        console.log(err);
        return res.status(400).json({
            code: 4,
            msg: msg[4],
            err : err
        });
    }
});


module.exports = router;