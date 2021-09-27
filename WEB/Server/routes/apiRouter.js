const router = require('express').Router();

var dbModule = require(`${process.env.PWD}/database`)();
var dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

const managerRouter = require('./api/managerRouter');
const userRouter = require('./api/userRouter')

router.use('/manager', managerRouter);
router.use('/user', userRouter); 

router.get('/tables', (req, res) => {
    var sql = 'show tables';

    dbConnection.query(sql, (error, rows, fields) => {
        if (error) {
            console.log('error : ' + error);
        } 
        else {
            res.json({rows: rows});
        }
    });
});

module.exports = router;