module.exports = (pw) => {
    var crypto = require('crypto');
    var salt, pwEncrypted;

    salt = crypto.randomBytes(64).toString('hex');
    pwEncrypted = crypto.pbkdf2Sync(pw, salt, 100000, 64, 'sha512').toString('hex');
    
    return {salt, pwEncrypted};
}


