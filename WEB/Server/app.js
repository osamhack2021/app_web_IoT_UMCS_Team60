const express = require('express');
const path = require('path');
const morgan = require('morgan');
const cookieParser = require('cookie-parser');
const bodyParser = require( 'body-parser' );
const session = require('express-session');
const nunjucks = require('nunjucks');
const dotenv = require('dotenv');
const app = express();
const server = require('http').createServer(app);
const router = express.Router();
const cors = require('cors');
const io = require('./socket')(server); 
const crypto = require('crypto');
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

dotenv.config();
app.set('port', process.env.PORT || 3003);
app.set('view engine', 'ejs');
app.set('views', './views');

app.use(morgan('dev'));
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser(process.env.COOKIE_SECRET));
app.use(bodyParser.urlencoded({ extended: true }) );
app.use(session({
    resave: false,
    saveUninitialized: false,
    secret: process.env.COOKIE_SECRET,
    cookie: {
        httpOnly: true,
        secure: false
    }
}));
app.use(passport.initialize());
app.use(passport.session());

// db connection
var dbModule = require('./database')();
var dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

const apiRouter = require('./routes/apiRouter')(app, dbConnection);
const managerRouter = require('./routes/managerRouter')(app, dbConnection, passport);

app.use('/api', apiRouter);
app.use('/manager', managerRouter);


// passport setting
passport.use(new LocalStrategy(
    function(username, password, done) {
        var sql = 'SELECT * FROM manager WHERE tag=?';
        dbConnection.query(sql, [username], function(err, results){
            if(err)
                return done(err);
            if(!results[0])
                return done('please check your id.');

            var userInfo = results[0];
            pwEncrypted = crypto.pbkdf2Sync(password, userInfo.salt, 100000, 64, 'sha512').toString('hex');

            if(pwEncrypted.toString('hex') === userInfo.pw)
                return done(null, userInfo);
            else 
                return done('please check your password.');

        });
    }
));

passport.serializeUser(function(user, done) {
    done(null, user.tag);
});
passport.deserializeUser(function(tag, done) {
    var sql = 'SELECT * FROM manager WHERE tag=?';
    dbConnection.query(sql, [tag], function(err, results){
        if(err)
            return done(err, false);
        if(!results[0])
            return done(err, false);

        return done(null, results[0]);
    });
});



//setting cors 
app.all('/*', function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "X-Requested-With");
    next(); 
}); 

//socketTest page route
app.get('/', (req, res) => {
    res.render(`index`);
})

//socketTest page route
app.get('/socketChat', (req, res) => {
    res.sendFile(__dirname+'/chatTest.html');
})


server.listen(app.get('port'), ()=>{
    console.log(`server port: ${app.get('port')}`)
});


// app.use((req, res, next) => {
//     const error = new Error(`${req.method} ${req.url} 라우터가 없습니다.`);
//     error.status = 404;
//     next(error);
// });

// app.use((err, req, res, next) => {
//     res.locals.message = err.message;
//     res.locals.error = process.env.NODE_ENV !== 'production' ? err : {};
//     res.status(err.status || 500);
//     res.json({page:'error'});
// });