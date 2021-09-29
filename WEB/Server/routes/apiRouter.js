const router = require('express').Router();
const managerRouter = require('./api/managerRouter');
const userRouter = require('./api/userRouter')

const dbModule = require(`${process.env.PWD}/database`)();
const dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

router.use('/manager', managerRouter); // /api/manager
router.use('/user', userRouter); // /api/user

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