const router = require('express').Router();
const managerAuth = require(`../../controllers/managerAuth`);

router.get('/logout', (req, res) => {
    req.logout();
    res.status(200).json({
        code: 1,
        msg: "success",
    });
});

router.post('/login', managerAuth.login, (req, res) => {
    if(req.code) 
        res.status(400).json({
            code: req.code,
            msg: req.msg,
            data: {
                tag: req.body.tag
            }
        });
    else {
        res.status(200).json({
            code: 1,
            msg: "success",
            data: req.data,
        });
    }
});

router.post('/register', managerAuth.register, (req, res) => {
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

// login 되어있는지 확인
router.get('/check', (req, res) => {
    if (req.isAuthenticated() && req.user) {
        var { salt, enc_pwd, ...data } = req.user;
        res.status(200).json({
            code: 1,
            msg: "success",
            data
        });
    }
    else
        res.status(200).json({
            code: 2,
            msg: 'not_login',
        });
});

module.exports = router;