const router = require('express').Router();

const dbModule = require(`../../database`)();
const dbConnection = dbModule.init();
dbModule.db_open(dbConnection);



router.post('/responsible_date', (req, res) => {
    var msg = {4: 'db_error'};

    var sql = "INSERT INTO watchman VALUES (NULL, ?, ?, ?, NULL)";
    dbConnection.query(sql, [req.body.manager_tags, req.body.charge_doom, req.body.responsible_date], (err, rows) => {
        if(err)
            res.status(400).json({
                code: 4,
                msg: msg[4],
                data: {
                    tag: req.data.tag,
                }
            });
        
        res.status(200).json({
            code: 1,
            msg: "success",
            data: req.body,
        });
    });
});

router.get('/', (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};

    var sql = "SELECT * FROM watchman";


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
                data: err
            });
        if(!rows)
            return res.status(200).json({
                code: 2,
                msg: msg[2],
            });

        return res.status(200).json({
            code: 1,
            msg: "success",
            total: rows.length(),
            data: rows
        });
    });


    console.log(sql);
});


module.exports = router;