const passportSocketIo = require("passport.socketio");
const { decodeToken } = require(`${process.env.PWD}/middleware/auth`);

const dbModule = require(`${process.env.PWD}/database`)();
const dbConnection = dbModule.init();
dbModule.db_open(dbConnection);
    
module.exports = (server, session) => {
    const io = require('socket.io')(server); 
    const FileStore = require("session-file-store")(session);
    
    io.use(passportSocketIo.authorize({
        cookieParser: require('cookie-parser'),     
        key: 'express.sid',
        secret: process.env.COOKIE_SECRET, 
        store: new FileStore(),
        success: onAuthorizeSuccess,
        fail: onAuthorizeFail,
    }));

    function onAuthorizeSuccess(data, accept){
        accept(null, true);
    }
       
    function onAuthorizeFail(data, message, error, accept){
        accept(null, false);
    }

    function nowDateTime() {
        return new Date().toISOString().slice(0, 19).replace('T', ' ');
    }
    
    var userio = io.of('/user'),
        managerio = io.of('/manager');

    userio.on('connection', (socket) => {
        // 인증 과정
        try { // jwt가 header로 왔는지 확인하여 user인지 판별
            user = decodeToken(socket.handshake.headers.authorization.split('Bearer ')[1]);
            console.log('user login', user);
        }
        catch {  // 인증 실패
            socket.disconnect(0);
        }

        // 사용자 이동 요청
        socket.on('move_request', (req) => {
            //req.outside_id
            console.log(req);
            
            var sql = "INSERT INTO outside_request VALUES (NULL, ?, ?, ?, ?, ?) ";
            dbConnection.query(sql, [user.tag, parseInt(req.outside_id), nowDateTime(), null, null], (err, rows) => {
                if(err) { 
                    console.log(err);
                }
            });
            
            managerio.emit('user2manager', {event: 'move_request', user, ...req});
        });

        // 사용자 위치 보고
        socket.on('location_report', (req) => {
            //req.beacon_id, req.time
            console.log(req);
            managerio.emit('user2manager', {event: 'location_report', user, ...req});
        });

        // 사용자 현상태 보고
        socket.on('my_status', (req) => {
            //req.beacon_id, req.time, req.is_moving,
            console.log(req)
            managerio.emit('user2manager', {event: 'my_status', user, ...req});
        });

        // 사용자 소집 불가 알림
        socket.on('cannot_assemble', (req) => {
            //req.description
            console.log(req)
            managerio.emit('user2manager', {event: 'cannot_assemble', user, ...req});
        });
    });


    managerio.on('connection', (socket) => {
        // 인증 과정
        if(socket.request.user.logged_in) { // session login(관리자 로그인) 성공 시
            var { salt, enc_pwd, ...manager } = socket.request.user;
            console.log('manager login', manager);
        }
        else {  // 인증 실패
            socket.disconnect(0);
        }
    });

    
    
    return io;
};