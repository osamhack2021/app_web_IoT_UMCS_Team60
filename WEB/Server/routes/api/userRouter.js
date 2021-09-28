const router = require('express').Router();
const userAuth = require(`${process.env.PWD}/controllers/userAuth`);
const { verifyToken, pw2enc } = require(`${process.env.PWD}/middleware/auth`);
const passport = require('passport');

const request = require('request-promise-native')

var dbModule = require(`${process.env.PWD}/database`)();
var dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

router.get('/', (req, res) => {
    var token = req.cookies["token"];
    var userInfo = req.cookies["userInfo"];
    var message = req.flash('message');
    res.clearCookie("token");
    res.clearCookie("userInfo");
    res.render(`${baseUrl}/index`, {token, message, userInfo});
});


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


router.post('/setHeader', (req, res) => {
    request({
        headers: {
            'Authorization': `Bearer ${req.body.token}`
        },
        url: 'http://127.0.0.1:3003/user/check',
        method: 'GET',
        json: true
    }).then((response) =>{
        res.cookie('userInfo', response);
        res.redirect(`.`); 
    })
});

router.get('/check', verifyToken, userAuth.check);

router.get('/test',  passport.authenticate("jwt", { session: false }), (req, res) => {
    res.json(req.user);
});

module.exports = router;