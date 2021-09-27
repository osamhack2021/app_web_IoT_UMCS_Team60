const router = require('express').Router();
const passport = require('passport');
const { pw2enc } = require(`${process.env.PWD}/middleware/auth`);
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
    else 
        res.status(200).json({
            state: "success",
            data: {
                tag: req.user.tag,
                name: req.user.name
            }
        });
});

router.post('/register',  managerAuth.register, (req, res) => {
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

module.exports = router;