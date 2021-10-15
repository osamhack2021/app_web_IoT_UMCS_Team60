const express = require('express');
const app = express();
const server = require('http').createServer(app);
const path = require('path');
const morgan = require('morgan');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');
const session = require('express-session');
const cors = require('cors');
const passport = require('passport');
const flash = require('connect-flash');
const FileStore = require("session-file-store")(session);
require('dotenv').config();

app.set('port', process.env.PORT);

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
    key: 'express.sid',
    secret: process.env.COOKIE_SECRET,
    saveUninitialized: true,
    resave: true,
    cookie: {
        httpOnly: false,
        secure: false
    },
    store: new FileStore({logFn: function(){}}),
}));
app.use(passport.initialize());
app.use(passport.session());
app.use(flash());

// socket connection
const io = require('./socket')(server, session); 


// passport
const userPassportConfig = require('./config/userPassport');
const managerPassportConfig = require('./config/managerPassport');

userPassportConfig();
managerPassportConfig();


// router
const apiRouter = require('./routes/apiRouter');
const uploadRouter = require('./routes/uploadRouter');
const devRouter = require('./routes/devRouter');

app.use('/api', apiRouter);
app.use('/upload', uploadRouter);
app.use('/dev', devRouter);

//setting cors 
app.all('/*', (req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "X-Requested-With");
    next(); 
}); 


// test page router
const testManagerRouter = require('./routes/testManagerRouter');
const testUserRouter = require('./routes/testUserRouter')
app.use('/manager', testManagerRouter);
app.use('/user', testUserRouter); 

app.get('/', (req, res) => {
    res.render(`index`);
})


app.get('/admin_page', (req, res) => {
    res.sendFile(path.resolve(__dirname+'/public/index_build.html'));
})

app.get('/socketUser', (req, res) => {
    res.sendFile(__dirname+'/socketUser.html');
})

app.get('/socketManager', (req, res) => {
    res.sendFile(__dirname+'/socketManager.html');
})


server.listen(app.get('port'), ()=>{
    console.log(`server port: ${app.get('port')}`)
});