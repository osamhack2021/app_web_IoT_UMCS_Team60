const router = require('express').Router();
const userAuthController = require('../controllers/userAuth');
const { verifyToken } = require('../middleware/auth');

router.post('/login', userAuthController.login);
router.get('/check', verifyToken, userAuthController.check);

module.exports = router;