var crypto = require('crypto');
var salt = '';
var pw = '';
crypto.randomBytes(64, (err, buf) => {
    if (err) throw err;
    salt = buf.toString('hex');

    crypto.pbkdf2("1234", salt, 100000, 64, 'sha512', (err, derivedKey) => {
        if (err) throw err;
        pw = derivedKey.toString('hex');
        console.log(salt);
        console.log(pw);
    });
});

