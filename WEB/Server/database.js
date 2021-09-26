const mysql = require('mysql2');
const dotenv = require('dotenv');
dotenv.config();

module.exports = () => {
  return {
    init: () => {
      return mysql.createConnection({
        host: 'localhost',
        port: '3307',
        user: 'root',
        password: process.env.DB_PASSWORD,
        database: 'UMCS'
      })
    },

    db_open: (con) => {
      con.connect((err) => {
        if (err) {
          console.error('mysql connection error :' + err);
        } else {
          console.info('mysql is connected successfully.');
        }
      })
    }
  }
};