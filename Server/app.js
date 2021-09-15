const express = require('express');
const path = require('path');
const morgan = require('morgan');
const cookieParser = require('cookie-parser');
const session = require('express-session');
const nunjucks = require('nunjucks');
const dotenv = require('dotenv');
const app = express();
const server = require('http').createServer(app);
const io = require('socket.io')(server,{ origins: '*'}); 
const cors = require('cors');

dotenv.config();

const indexRouter = require('./routes');

app.set('port', process.env.PORT || 3001);
app.set('view engine', 'ejs');
app.set('views',  __dirname + '/views'); 


app.use(morgan('dev'));
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser(process.env.COOKIE_SECRET));
app.use(session({
    resave: false,
    saveUninitialized: false,
    secret: process.env.COOKIE_SECRET,
    cookie: {
        httpOnly: true,
        secure: false
    }
}));

//setting cors 
app.all('/*', function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "X-Requested-With");
    next(); 
}); 
    
app.get('/', (req, res) => {
    res.sendFile(__dirname+'/index.html');
})

io.on('connection', (socket) => { 
    console.log('a user connected');
    socket.on('chat message', (msg) => {
      
        io.emit('chat message', msg); 
    });
    socket.on('disconnect', () => {
        console.log('user disconnected');
    });
});

server.listen(3002)

//app.use('/', indexRouter);

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