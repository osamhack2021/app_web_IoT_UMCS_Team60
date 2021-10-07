const router = require('express').Router();
const dbPromiseConnection = require(`../databasePromise`);
const userAuth = require(`../controllers/userAuth`);

function nowDateTime() {
    let krDate = new Date();
    krDate.setHours(krDate.getHours()+9);
    return krDate.toISOString().slice(0, 19).replace('T', ' ');
}

function gaussianRandom() {
    var v1, v2, s;
  
    do {
      v1 = 2 * Math.random() - 1;  
      v2 = 2 * Math.random() - 1;   
      s = v1 * v1 + v2 * v2;
    } while (s >= 1 || s == 0);
  
    s = Math.sqrt( (-2 * Math.log(s)) / s );
  
    return v1 * s;
  }

function temperatureGen() {
    return 36.5 + gaussianRandom();
}

function timeGen() {
    return "21:"+(20+Math.floor(Math.random()*20))+":"+Math.floor(Math.random()*60);
}

router.get('/makeAnomaly/:date', async (req, res) => {
    let sql = "DELETE FROM anomaly WHERE DATE(reported_time)=?"; 
    await dbPromiseConnection.query(sql, [req.params.date]);

    sql = "SELECT * FROM user";
    let [users] = await dbPromiseConnection.query(sql);

    for(let user of users) {
        let temperature = temperatureGen().toFixed(2);
        let details = null;
        if(temperature >= 38) details="고열, 기침";
        if(temperature < 34.2) details="식은땀";
         
        sql = "INSERT INTO anomaly value (NULL, ?, ?, ?, ?)";
        var [results] = await dbPromiseConnection.query(sql, [user.tag, temperature, details, req.params.date+ " " + timeGen()]);        
    }
});


router.post('/userLogin', (req, res, next)=>{req.body.password = '12345'; next()}, userAuth.login, (req, res) => {
    console.log(req.body);
    res.cookie('jwt', req.token);
    console.log(req.token);
    res.redirect('/socketUser');
});

router.get('/deleteWatchman/:date', async (req, res) => {
    let sql = "DELETE from watchman where responsible_date=?";
    await dbPromiseConnection.query(sql, [req.params.date]);
});

module.exports = router;