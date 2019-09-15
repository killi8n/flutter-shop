require('dotenv').config();
const crypto = require('crypto');

const { PASSWORD_SECRET: secret } = process.env;

const encryptPassword = password => {
    const encrypted = crypto
        .createHmac('sha256', secret)
        .update(password)
        .digest('base64');

    return encrypted;
};

const checkPassword = (password, encrypted) => {
    return encryptPassword(password) === encrypted;
};

module.exports = { encryptPassword, checkPassword };
