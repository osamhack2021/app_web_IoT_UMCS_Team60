const router = require('express').Router();
const managerAuth = require(`${process.env.PWD}/controllers/managerAuth`);

router.get('/logout', (req, res) => {
    req.logout();
    res.status(200).json({
        state: "success",
    });
});

router.post('/login', managerAuth.login, (req, res) => {
    if(req.message) 
        res.status(400).json({
            state: "fail",
            message: req.message
        });
    else {
        res.status(200).json({
            state: "success",
            data: {
                tag: req.user.tag,
                name: req.user.name
            }
        });
    }
});

router.post('/register', managerAuth.register, (req, res) => {
    if(req.message) 
        res.status(400).json({
            state: "fail",
            message: req.message
        });
    else 
        res.status(200).json({
            state: "success",
            data: {
            }
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