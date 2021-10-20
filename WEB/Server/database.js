const mysql = require('mysql2');
const dotenv = require('dotenv');
dotenv.config();

module.exports = () => {
  return {
    init: () => {
      return mysql.createConnection({
        host: process.env.DB_HOST,
        port: process.env.DB_PORT,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME
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