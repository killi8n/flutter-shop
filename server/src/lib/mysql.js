require('dotenv').config();
const mysql = require('mysql');

const {
    MYSQL_HOST: host = 'localhost',
    MYSQL_USER: user,
    MYSQL_PASSWORD: password,
    MYSQL_DATABASE: database,
} = process.env;

const pool = mysql.createPool({
    connectionLimit: 10,
    host,
    user,
    password,
    database,
});

exports.query = (query, params) => {
    return new Promise((resolve, reject) => {
        if (!pool) reject();

        pool.getConnection((err, conn) => {
            if (err) reject(err);
            conn.query(query, params, (err, results) => {
                if (err) reject(err);
                conn.release();
                resolve(results);
            });
        });
    });
};
