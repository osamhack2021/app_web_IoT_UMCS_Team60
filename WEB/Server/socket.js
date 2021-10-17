const passportSocketIo = require("passport.socketio");
const { decodeToken } = require(`./middleware/auth`);
const axios = require('axios');
const request = require('request');

const dbModule = require(`./database`)();
const dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

const dbPromiseConnection = require(`./databasePromise`);

function newkrDate() {
    let krDate = new Date();
    krDate.setHours(krDate.getHours()+9);
    return krDate;
}

module.exports = (server, session) => {
    const io = require('socket.io')(server); 
    const FileStore = require("session-file-store")(session);
    
    io.use(passportSocketIo.authorize({
        cookieParser: require('cookie-parser'),     
        key: 'express.sid',
        secret: process.env.COOKIE_SECRET, 
        store: new FileStore({logFn: function(){}}),
        success: onAuthorizeSuccess,
        fail: onAuthorizeFail,
    }));

    function onAuthorizeSuccess(data, accept){
        accept(null, true);
    }
       
    function onAuthorizeFail(data, message, error, accept){
        accept(null, false);
    }

    function nowDateTime() {return newkrDate().toISOString().slice(0, 19).replace('T', ' ');}

    function nowDate() {return newkrDate().toISOString().slice(0, 10).replace('T', ' ')}
    
    var userio = io.of('/user'),
        managerio = io.of('/manager');

    userio.on('connection', (socket) => {
        try { // jwt가 header로 왔는지 확인하여 user 인증
            var user = decodeToken(socket.handshake.headers.authorization.split('Bearer ')[1]);
            if(!user) user = decodeToken(socket.handshake.query.jwt);
            
            socket.join(user.doom_id);
            user.socket_id = socket.id;
            userio.emit('my_info', user);
            console.log('user connected to socket:', user);
        }
        catch {  // 인증 실패
            socket.disconnect(0);
        }

        async function get_out(data) {
            try {
                if(!data?.beacon_id) {
                    let sql = "SELECT a.*, b.outside_facility_id, b.doom_id, b.doomroom_id, b.doomfacility_id, u.name as user_name, u.rank as user_rank, u.doom_id as user_doom_id, u.room_id as user_room_id "
                    sql += "FROM access_record a, beacon b, user u "
                    sql += "WHERE a.user_tag=? AND a.beacon_id=b.id AND a.user_tag=u.tag AND a.out_time IS NULL ORDER BY id DESC LIMIT 1";
                    var [results] = await dbPromiseConnection.query(sql, user.tag);
                    data.beacon_id = results[0].beacon_id;
                }
                
                let sql = "SELECT id FROM access_record WHERE user_tag=? AND beacon_id=? AND out_time IS NULL ORDER BY id DESC LIMIT 1";
                let [target] = await dbPromiseConnection.query(sql, [user.tag, data.beacon_id]);
                
                target = target[0];

                sql = "UPDATE access_record SET out_time=? WHERE id=?";
                await dbPromiseConnection.query(sql, [nowDateTime(), target.id]);

                sql = "SELECT * FROM beacon WHERE id=?";
                let [beaconInfo] = await dbPromiseConnection.query(sql, [data.beacon_id]);
                beaconInfo = beaconInfo[0];
                
                Object.keys(beaconInfo).forEach((k) => beaconInfo[k] == null && delete beaconInfo[k]);

                let table = beaconInfo.outside_facility_id ? 'outside_facility' : beaconInfo.doomfacility_id ? 'doomfacility' :
                    beaconInfo.doomroom_id ? 'doomroom' : 'doom'; 

                // 현 인원 감소
                sql = `UPDATE ${table} SET current_count=current_count-1 WHERE beacon_id=?`;
                await dbPromiseConnection.query(sql, [data.beacon_id]);

                // 생활관건물 호실이나 공공시설이라면 생활관건물 정보도 알아야 하므로 column에 추가
                let column = 'id, name, current_count' + ((table === 'outside_facility' || table === 'doom') ? '': ', doom_id');
                sql = `SELECT ${column} FROM ${table} WHERE beacon_id=?`;

                let [facilityInfo] = await dbPromiseConnection.query(sql, [data.beacon_id]);
                facilityInfo = facilityInfo[0];

                if(facilityInfo?.doom_id) {
                    sql = `SELECT name FROM doom WHERE id=?`;
                    let [doomInfo] = await dbPromiseConnection.query(sql, [facilityInfo.doom_id]);
                    facilityInfo.doom_name = doomInfo[0].name;
                }
                
                managerio.to(user.doom_id).emit(`${table}_get_out`, {
                    user_tag: user.tag,
                    out_time: nowDateTime(),
                    ...facilityInfo
                });
            }
            catch(err) {
                console.log(err);
            }
        }

        // 비콘 영역에서 나옴
        socket.on('get_out', async(data)=>await get_out(data));

        // 비콘 영역에 들어감
        socket.on('get_in', async (data) => {
            try {
                // 이전에 비콘 오류로 인해 나가는 것을 감지 못했을 경우
                let sql = "SELECT id, beacon_id FROM access_record WHERE user_tag=? AND out_time IS NULL";
                let [checks] = await dbPromiseConnection.query(sql, [user.tag]);
                if(checks.length) 
                    for(let check of checks) await get_out(check);
                
                sql = "INSERT INTO access_record VALUE (NULL, ?, ?, ?, NULL)";
                await dbPromiseConnection.query(sql, [user.tag, data.beacon_id, nowDateTime()]);

                sql = "SELECT * FROM beacon WHERE id=?";
                let [beaconInfo] = await dbPromiseConnection.query(sql, [data.beacon_id]);
                beaconInfo = beaconInfo[0];
                
                Object.keys(beaconInfo).forEach((k) => beaconInfo[k] == null && delete beaconInfo[k]);

                let table = beaconInfo.outside_facility_id ? 'outside_facility' : beaconInfo.doomfacility_id ? 'doomfacility' :
                    beaconInfo.doomroom_id ? 'doomroom' : 'doom'; 

                // 현 인원 증가
                sql = `UPDATE ${table} SET current_count=current_count+1 WHERE beacon_id=?`;
                await dbPromiseConnection.query(sql, [data.beacon_id]);

                // 생활관건물 호실이나 공공시설이라면 생활관건물 정보도 알아야 하므로 column에 추가
                let column = 'id, name, current_count' + ((table === 'outside_facility' || table === 'doom') ? '': ', doom_id');
                sql = `SELECT ${column} FROM ${table} WHERE beacon_id=?`;
                let [facilityInfo] = await dbPromiseConnection.query(sql, [data.beacon_id]);
                facilityInfo = facilityInfo[0];

                if(facilityInfo?.doom_id) {
                    sql = `SELECT name FROM doom WHERE id=?`;
                    let [doomInfo] = await dbPromiseConnection.query(sql, [facilityInfo.doom_id]);
                    facilityInfo.doom_name = doomInfo[0].name;
                }
                
                managerio.to(user.doom_id).emit(`${table}_get_in`, {
                    user_tag: user.tag,
                    in_time: nowDateTime(),
                    ...facilityInfo
                });

                // 타 호실원과 접촉이 생겼는지 확인
                sql = "SELECT * FROM cohort_status ORDER BY id DESC LIMIT 1";
                let [cohortStatus] = await dbPromiseConnection.query(sql);
                if(cohortStatus[0].isCohort && (table === 'doomfacility' || table === 'doomroom')) {
                    sql = 'SELECT a.beacon_id, u.tag, u.name, u.rank, u.doom_id, u.room_id FROM access_record a, user u WHERE a.user_tag=u.tag AND a.out_time IS NULL;'
                    let [currentPositions] = await dbPromiseConnection.query(sql);
                    
                    let isContact = false;
                    for(let currentPosition of currentPositions) 
                        if(currentPosition.beacon_id == data.beacon_id) // 동일한 위치에 있고
                            if(currentPosition.doom_id != user.doom_id || currentPosition.room_id != user.room_id) // 다른 호실이라면
                                isContact = true;
                    
                    if(isContact) {
                        managerio.to(user.doom_id).emit(`${table}_contact`, {
                            contact_time: nowDateTime(),
                            contact_users: [
                                ...currentPositions
                            ],
                            ...facilityInfo
                        });
                        userio.to(user.socket_id).emit(`contact_alert`);
                    }
                }
            }
            catch(err) {
                console.log(err);
            }
        });

        // 긴급 소집 지시 불응
        socket.on('cannot_assemble', (data) =>{
            managerio.to(user.doom_id).emit('cannot_assemble', {
                user_tag: user.tag,
                description: data.description,
                send_time: newkrDate()
            });
        });

        // 외부시설 이동요청
        socket.on('move_request', async (data) => {
            try {
                let sql = "INSERT INTO outside_request VALUE (NULL, ?, ?, ?, NULL, ?, NULL, ?)";
                let [result] = await dbPromiseConnection.query(sql, [user.tag, data.outside_id, nowDateTime(), data.description, user.socket_id]);
                
                managerio.to(user.doom_id).emit('move_request', {
                    id: result.insertId,
                    user_tag: user.tag,
                    request_time: nowDateTime(),
                    ...data
                });
            }
            catch(err) {
                console.log(err);
            }
        });

        // 공공시설 이동요청
        socket.on('facility_request', async (data) => {
            try {
                let sql = "INSERT INTO facility_request VALUE (NULL, ?, ?, ?, ?, NULL, NULL, ?, ?)";
                let [result] = await dbPromiseConnection.query(sql, [user.tag, data.facility_id, nowDateTime(), data.desired_time, data.description, user.socket_id]);
                // 금일 생활관 근무자에게만 보내기 위해 중간 과정을 거침
                managerio.to(user.doom_id).emit('facility_request', {
                    id: result.insertId,
                    user_tag: user.tag,
                    request_time: nowDateTime(),
                    ...data
                });
            }
            catch(err) {
                console.log(err);
            }
        });
    });


    /////////////////////////////////////////////////////////////////////////////////


    managerio.on('connection', async (socket) => {
        try { // 연결 요청 시 관리자 인증 과정
            var { salt, enc_pwd, ...manager } = socket.request.user;

            // 금일 근무가 있는지 확인
            var sql = "SELECT * FROM watchman WHERE manager_tags=? AND responsible_date=?";
            let [results] = await dbPromiseConnection.query(sql, [manager.tag, nowDate()]);
            if(results.length) { // 금일 근무가 있을 시에만 담당 생활관 room에 참여
                manager.charge_doom = [];
                for(let result of results) {
                    manager.charge_doom.push(result.charge_doom);
                    socket.join(result.charge_doom);
                }
            }
            
            managerio.emit('my_info', manager);
            console.log('manager connected to socket:', manager);
        }
        catch (err){  // 관리자 인증 실패
            console.log(err);
            socket.disconnect(0);
        }

        socket.on('disconnect', async() => {
            console.log('disconnected');
        });

        // 평시->코호트 전환
        socket.on('to_cohort', async () =>{
            let sql = "INSERT INTO cohort_status VALUE (NULL, true, ?)";
            let [result] = await dbPromiseConnection.query(sql, [nowDateTime()]);
            userio.emit('to_cohort');
        });

        // 코호트->평시 전환
        socket.on('to_normal', async () =>{
            let sql = "INSERT INTO cohort_status VALUE (NULL, false, ?)";
            let [result] = await dbPromiseConnection.query(sql, [nowDateTime()]);
            console.log("to_normal");
            userio.emit('to_normal');
        });

        // 긴급 소집 지시
        socket.on('assemble_command', (data) =>{
            userio.to(data.doom_id).emit('assemble_command', {send_time: newkrDate()});
        });

        // 외부시설 이동요청 결재 완료
        socket.on('move_approval', async (data) =>{
            try {
                let sql = "UPDATE outside_request SET permission=?, manager_tag=? WHERE id=?";
                await dbPromiseConnection.query(sql, [data.permission, manager.tag, data.id]);
                
                sql = "SELECT outside_id, request_time, permission, socket_id FROM outside_request WHERE id=?";
                let [results] = await dbPromiseConnection.query(sql, [data.id]);

                userio.to(results[0].socket_id).emit('move_approval', {id: data.id, ...results[0]});
            } 
            catch(err) {
                console.log(err);
            }
        });

        // 공공시설 사용요청 결재 완료
        socket.on('facility_approval', async (data) =>{
            try {
                let sql = "UPDATE facility_request SET permission=?, manager_tag=? WHERE id=?";
                await dbPromiseConnection.query(sql, [data.permission, manager.tag, data.id]);
                
                sql = "SELECT facility_id, request_time, permission, socket_id FROM facility_request WHERE id=?";
                let [results] = await dbPromiseConnection.query(sql, [data.id]);

                userio.to(results[0].socket_id).emit('facility_approval', {id: data.id, ...results[0]});
            } 
            catch(err) {
                console.log(err);
            }
        });
       
        
        // for dev
        async function get_out(data, user) {
            try {
                let sql = "SELECT id FROM access_record WHERE user_tag=? AND beacon_id=? AND out_time IS NULL ORDER BY id DESC LIMIT 1";
                let [target] = await dbPromiseConnection.query(sql, [user.tag, data.beacon_id]);
                target = target[0];

                sql = "UPDATE access_record SET out_time=? WHERE id=?";
                await dbPromiseConnection.query(sql, [nowDateTime(), target?.id]);

                sql = "SELECT * FROM beacon WHERE id=?";
                let [beaconInfo] = await dbPromiseConnection.query(sql, [data.beacon_id]);
                beaconInfo = beaconInfo[0];
                
                Object.keys(beaconInfo).forEach((k) => beaconInfo[k] == null && delete beaconInfo[k]);

                let table = beaconInfo.outside_facility_id ? 'outside_facility' : beaconInfo.doomfacility_id ? 'doomfacility' :
                    beaconInfo.doomroom_id ? 'doomroom' : 'doom'; 

                // 현 인원 감소
                sql = `UPDATE ${table} SET current_count=current_count-1 WHERE beacon_id=?`;
                await dbPromiseConnection.query(sql, [data.beacon_id]);

                // 생활관건물 호실이나 공공시설이라면 생활관건물 정보도 알아야 하므로 column에 추가
                let column = 'id, name, current_count' + ((table === 'outside_facility' || table === 'doom') ? '': ', doom_id');
                sql = `SELECT ${column} FROM ${table} WHERE beacon_id=?`;

                let [facilityInfo] = await dbPromiseConnection.query(sql, [data.beacon_id]);
                facilityInfo = facilityInfo[0];

                if(facilityInfo?.doom_id) {
                    sql = `SELECT name FROM doom WHERE id=?`;
                    let [doomInfo] = await dbPromiseConnection.query(sql, [facilityInfo.doom_id]);
                    facilityInfo.doom_name = doomInfo[0].name;
                }
                
                managerio.to(user.doom_id).emit(`${table}_get_out`, {
                    user_tag: user.tag,
                    out_time: nowDateTime(),
                    ...facilityInfo
                });
            }
            catch(err) {
                console.log(err);
            }
        }
        socket.on('get_in_all', async (data) => {
            try {
                sql = "SELECT u.*, d.beacon_id FROM user u, doomroom d where u.room_id=d.id";
                let [users] = await dbPromiseConnection.query(sql);

                for(data of users) {
                    let user =data;
                    // 이전에 비콘 오류로 인해 나가는 것을 감지 못했을 경우
                    let sql = "SELECT id, beacon_id FROM access_record WHERE user_tag=? AND out_time IS NULL";
                    let [checks] = await dbPromiseConnection.query(sql, [user.tag]);
                    if(checks.length) 
                        for(let check of checks) await get_out(check, user);
                    
                    sql = "INSERT INTO access_record VALUE (NULL, ?, ?, ?, NULL)";
                    await dbPromiseConnection.query(sql, [user.tag, data.beacon_id, nowDateTime()]);

                    sql = "SELECT * FROM beacon WHERE id=?";
                    let [beaconInfo] = await dbPromiseConnection.query(sql, [data.beacon_id]);
                    beaconInfo = beaconInfo[0];
                    
                    Object.keys(beaconInfo).forEach((k) => beaconInfo[k] == null && delete beaconInfo[k]);

                    let table = beaconInfo.outside_facility_id ? 'outside_facility' : beaconInfo.doomfacility_id ? 'doomfacility' :
                        beaconInfo.doomroom_id ? 'doomroom' : 'doom'; 

                    // 현 인원 증가
                    sql = `UPDATE ${table} SET current_count=current_count+1 WHERE beacon_id=?`;
                    await dbPromiseConnection.query(sql, [data.beacon_id]);

                    // 생활관건물 호실이나 공공시설이라면 생활관건물 정보도 알아야 하므로 column에 추가
                    let column = 'id, name, current_count' + ((table === 'outside_facility' || table === 'doom') ? '': ', doom_id');
                    sql = `SELECT ${column} FROM ${table} WHERE beacon_id=?`;
                    let [facilityInfo] = await dbPromiseConnection.query(sql, [data.beacon_id]);
                    facilityInfo = facilityInfo[0];

                    if(facilityInfo?.doom_id) {
                        sql = `SELECT name FROM doom WHERE id=?`;
                        let [doomInfo] = await dbPromiseConnection.query(sql, [facilityInfo.doom_id]);
                        facilityInfo.doom_name = doomInfo[0].name;
                    }
                    
                    managerio.to(user.doom_id).emit(`${table}_get_in`, {
                        user_tag: user.tag,
                        in_time: nowDateTime(),
                        ...facilityInfo
                    });

                    // 타 호실원과 접촉이 생겼는지 확인
                    sql = "SELECT * FROM cohort_status ORDER BY id DESC LIMIT 1";
                    let [cohortStatus] = await dbPromiseConnection.query(sql);
                    if(cohortStatus[0].isCohort && (table === 'doomfacility' || table === 'doomroom')) {
                        sql = 'SELECT a.beacon_id, u.tag, u.name, u.rank, u.doom_id, u.room_id FROM access_record a, user u WHERE a.user_tag=u.tag AND a.out_time IS NULL;'
                        let [currentPositions] = await dbPromiseConnection.query(sql);
                        
                        let isContact = false;
                        for(let currentPosition of currentPositions) 
                            if(currentPosition.beacon_id == data.beacon_id) // 동일한 위치에 있고
                                if(currentPosition.doom_id != user.doom_id || currentPosition.room_id != user.room_id) // 다른 호실이라면
                                    isContact = true;
                        
                        if(isContact) {
                            managerio.to(user.doom_id).emit(`${table}_contact`, {
                                contact_time: nowDateTime(),
                                contact_users: [
                                    ...currentPositions
                                ],
                                ...facilityInfo
                            });
                            userio.to(user.socket_id).emit(`contact_alert`);
                        }
                    }
                }
            } 
            catch(err) {
                console.log(err);
            }
        });
    });
    return io;
};

