require('dotenv').config();
const mysql = require('mysql');

const {
    MYSQL_HOST: host = 'localhost',
    MYSQL_USER: user,
    MYSQL_PASSWORD: password,
    MYSQL_DATABASE: database,
} = process.env;

const connect = () => {
    return new Promise((resolve, reject) => {
        if (!host || !user || !password || !database) {
            reject();
        }
        const connection = mysql.createConnection({
            host,
            user,
            password,
            database,
        });

        connection.connect();

        resolve(connection);
    });
};

exports.query = async (query, params) => {
    try {
        const conn = await connect();
        const 
        const res = conn.query(query);
        return res;
    } catch (e) {
        console.log(e);
    }
};
