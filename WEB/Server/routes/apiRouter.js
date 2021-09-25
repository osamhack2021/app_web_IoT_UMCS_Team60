const router = require('express').Router();

var dbModule = require('../database')();
var dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

router.get('/tables', (req, res) => {
    var sql = 'show tables';

    dbConnection.query(sql, function (error, rows, fields) {
        if (error) {
            console.log('error : ' + error);
        } 
        else {
            res.json({rows: rows});
        }
    });
});

module.exports = router;