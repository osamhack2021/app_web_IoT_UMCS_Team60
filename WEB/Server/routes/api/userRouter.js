const router = require('express').Router();
const userAuth = require(`${process.env.PWD}/controllers/userAuth`);

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

router.get('/check', userAuth.jwtLogin, (req, res) => {
    res.json(req.data);
});


module.exports = router;