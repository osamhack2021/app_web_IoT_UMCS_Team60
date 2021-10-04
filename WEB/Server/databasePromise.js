const mysql = require('mysql2');

const pool = mysql.createPool({
  host: 'localhost',
  port: '3307',
  user: 'root',
  password: process.env.DB_PASSWORD,
  database: 'UMCS'
});

module.exports = pool.promise();
