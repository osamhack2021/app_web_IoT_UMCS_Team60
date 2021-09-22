module.exports = (app, dbConnection) => {
    const router = require('express').Router();

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

    return router;
}