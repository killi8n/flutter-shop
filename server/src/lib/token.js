require('dotenv').config();
const jwt = require('jsonwebtoken');

const { JWT_SECRET: secret } = process.env;

exports.generateToken = payload => {
    return new Promise((resolve, reject) => {
        if (!payload) reject();
        const token = jwt.sign(payload, secret, {
            expiresIn: '7d',
        });
        resolve(token);
    });
};

const decodeToken = token => {
    return new Promise((resolve, reject) => {
        if (!token) reject();
        const decoded = jwt.decode(token);
        resolve(decoded);
    });
};

exports.jwtMiddleware = async (ctx, next) => {
    const token = ctx.cookies.get('access_token');
    if (!token) return next();

    try {
        const decoded = await decodeToken(token);

        if (Date.now() / 1000 - decoded.iat > 60 * 60 * 24) {
            const freshToken = await generateToken(decoded);
            ctx.cookies.set('access_token', freshToken, {
                maxAge: 1000 * 60 * 60 * 24 * 7,
                httpOnly: true,
            });
        }
        ctx.request.user = decoded;
    } catch (e) {
        console.log(e);
        ctx.request.user = null;
    }
    return next();
};
