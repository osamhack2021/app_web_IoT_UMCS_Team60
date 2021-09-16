const express = require('express');
const router = express.Router();

var dbConn = require('../database')();
var connection = dbConn.init();

dbConn.db_open(connection);

router.get('/tables', (req, res) => {
    var sql = 'show tables';

    connection.query(sql, function (error, rows, fields) {
        if (error) {
            console.log('error : ' + error);
        } 
        else {
            res.json({rows: rows});
        }
    });
});

module.exports = router;