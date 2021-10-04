const router = require('express').Router();
const managerAuth = require(`../../controllers/managerAuth`);

const dbModule = require(`../../database`)();
const dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

const dbPromiseConnection = require(`../../databasePromise`);

router.get('/', async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "SELECT a.*, b.outside_facility_id, b.doom_id, b.doomroom_id, b.doomfacility_id "
        sql += "FROM access_record a, beacon b "
        sql += "WHERE a.beacon_id=b.id AND a.out_time IS NULL";
        var [results] = await dbPromiseConnection.query(sql);
        
        if(!results.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });
        
        for(var record of results) {
            // 비콘이 설치된 시설id key만 남기고 나머지 null key는 객체에서 지움
            Object.keys(record).forEach((k) => record[k] == null && delete record[k]);

            var table = record.outside_facility_id ? 'outside_facility' : record.doomfacility_id ? 'doomfacility' :
                record.outside_doom_id ? 'doom' : 'doomroom'; 

            // 생활관건물 호실이나 공공시설이라면 생활관건물 id도 알아야 하므로 column에 추가
            var column = 'name' + (table !== ('outside_facility' || 'doom') ? ', doom_id' : '');
            
            sql = `SELECT ${column} FROM ${table} WHERE beacon_id=${record.beacon_id}`;
            console.log(sql)
            var [facilityinfo] = await dbPromiseConnection.query(sql);
            record.name = facilityinfo[0].name;

            if(facilityinfo[0].doom_id) {
                sql = `SELECT name FROM doom WHERE id=${facilityinfo[0].doom_id}`;
                var [doominfo] = await dbPromiseConnection.query(sql);
                record.doom_id = facilityinfo[0].doom_id;
                record.fullname = doominfo[0].name + " " + record.name;
            }
        }

        return res.status(200).json({
            code: 1,
            msg: "success",
            total: results.length,
            data: results
        });

    } catch(err) {
        console.log(err)
        return res.status(400).json({
            code: 4,
            msg: msg[4],
            err
        });
    }
});


router.get('/search', async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "SELECT a.*, b.outside_facility_id, b.doom_id, b.doomroom_id, b.doomfacility_id "
        sql += "FROM access_record a, beacon b "
        sql += "WHERE a.beacon_id=b.id AND a.out_time IS NULL";
        if(Object.keys(req.query).length) 
            for(key in req.query) {
                if(key === 'doom_id' || key === 'outside_facility_id' || key === 'doomfacility_id' || key === 'doomroom_id') {
                    let [beaconinfo] = await dbPromiseConnection.query(`SELECT id FROM beacon WHERE ${key}=${req.query[key]}`);
                    req.query[key] = beaconinfo[0].id;
                    key = 'beacon_id';
                }
                sql += ` AND ${key} = ?`;
            }

        var [results] = await dbPromiseConnection.query(sql, Object.values(req.query));
        
        if(!results.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });
        
        for(var record of results) {
            // 비콘이 설치된 시설id key만 남기고 나머지 null key는 객체에서 지움
            Object.keys(record).forEach((k) => record[k] == null && delete record[k]);

            let table = record.outside_facility_id ? 'outside_facility' : record.doomfacility_id ? 'doomfacility' :
                record.outside_doom_id ? 'doom' : 'doomroom'; 

            // 생활관건물 호실이나 공공시설이라면 생활관건물 id도 알아야 하므로 column에 추가
            let column = 'name' + (table !== ('outside_facility' || 'doom') ? ', doom_id' : '');
            
            sql = `SELECT ${column} FROM ${table} WHERE beacon_id=${record.beacon_id}`;
            let [facilityinfo] = await dbPromiseConnection.query(sql);
            console.log(facilityinfo)
            record.name = facilityinfo[0].name;

            if(facilityinfo[0].doom_id) {
                sql = `SELECT name FROM doom WHERE id=${facilityinfo[0].doom_id}`;
                let [doominfo] = await dbPromiseConnection.query(sql);
                record.doom_id = facilityinfo[0].doom_id;
                record.fullname = doominfo[0].name + " " + record.name;
            }
        }

        return res.status(200).json({
            code: 1,
            msg: "success",
            total: results.length,
            data: results
        });

    } catch(err) {
        console.log(err)
        return res.status(400).json({
            code: 4,
            msg: msg[4],
            err
        });
    }
});


router.get('/:id', async (req, res) => {
    var msg = {2:'not_found', 4: 'db_error'};
    try {
        var sql = "SELECT a.*, b.outside_facility_id, b.doom_id, b.doomroom_id, b.doomfacility_id "
        sql += "FROM access_record a, beacon b "
        sql += "WHERE a.beacon_id=b.id AND a.out_time IS NULL AND a.id=?";
        var [results] = await dbPromiseConnection.query(sql, req.params.id);
        
        if(!results.length)
            return res.status(200).json({
                code: 2,
                msg: msg[2]
            });
        
        for(var record of results) {
            // 비콘이 설치된 시설id key만 남기고 나머지 null key는 객체에서 지움
            Object.keys(record).forEach((k) => record[k] == null && delete record[k]);

            var table = record.outside_facility_id ? 'outside_facility' : record.doomfacility_id ? 'doomfacility' :
                record.outside_doom_id ? 'doom' : 'doomroom'; 

            // 생활관건물 호실이나 공공시설이라면 생활관건물 id도 알아야 하므로 column에 추가
            var column = 'name' + (table !== ('outside_facility' || 'doom') ? ', doom_id' : '');
            
            sql = `SELECT ${column} FROM ${table} WHERE beacon_id=${record.beacon_id}`;
            var [facilityinfo] = await dbPromiseConnection.query(sql);
            console.log(facilityinfo)
            record.name = facilityinfo[0].name;

            if(facilityinfo[0].doom_id) {
                sql = `SELECT name FROM doom WHERE id=${facilityinfo[0].doom_id}`;
                var [doominfo] = await dbPromiseConnection.query(sql);
                record.doom_id = facilityinfo[0].doom_id;
                record.fullname = doominfo[0].name + " " + record.name;
            }
        }
 
        return res.status(200).json({
            code: 1,
            msg: "success",
            data: results[0]
        });

    } catch(err) {
        console.log(err)
        return res.status(400).json({
            code: 4,
            msg: msg[4],
            err
        });
    }
});

module.exports = router;