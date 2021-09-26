const jwt = require('jsonwebtoken');
const crypto = require('crypto');

// 토큰이 유효한지 판별
exports.verifyToken = (req, res, next) => {
    try {
        const token = req.headers.authorization.split('Bearer ')[1];
        req.decoded = jwt.verify(token, process.env.JWT_SECRET);
        
        next();
    } catch (err) {
        if (err.name == 'TokenExpiredError') {
            // return res.status(419).json({success: false, message : "token 만료"});
            req.tokenMessage = "token 만료";
        }
        else { 
            req.tokenMessage = "유효하지 않은 token";
            // return res.status(401).json({success: false, message : "token이 유효하지 않습니다."});
        }
        
        next();
    }
}

// pw 암호화
exports.pw2enc = (pw) => {
    var salt = crypto.randomBytes(64).toString('hex');
    var pwEncrypted = crypto.pbkdf2Sync(pw, salt, 100000, 64, 'sha512').toString('hex');

    return {salt, pwEncrypted};
}
