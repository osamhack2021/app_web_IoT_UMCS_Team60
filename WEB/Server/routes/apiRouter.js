const router = require('express').Router();
const managerRouter = require('./api/managerRouter');
const userRouter = require('./api/userRouter')
const watchmanRouter = require('./api/watchmanRouter')
const doomRouter = require('./api/doomRouter')

const dbModule = require(`../database`)();
const dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

router.use('/manager', managerRouter); // /api/manager
router.use('/user', userRouter); // /api/user
router.use('/watchman', watchmanRouter); // /api/user
router.use('/doom', doomRouter); // /api/user

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