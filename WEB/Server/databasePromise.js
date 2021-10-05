const mysql = require('mysql2');

const pool = mysql.createPool({
  host: '10.0.1.174',
  port: '3306',
  user: 'root',
  password: process.env.DB_PASSWORD,
  database: 'UMCS'
});

module.exports = pool.promise();
