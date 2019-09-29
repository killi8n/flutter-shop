const Joi = require('joi');
const { query } = require('../../lib/mysql');
const { encryptPassword } = require('../../lib/password');
const { decodeToken } = require('../../lib/token');

exports.createCustomer = async ctx => {
    let schema = Joi.object().keys({
        values: Joi.string().required(),
    });

    let validation = Joi.validate(ctx.request.body, schema);

    if (validation.error) {
        ctx.status = 400;
        ctx.body = {
            message: validation.error.details[0].message,
        };
        return;
    }

    schema = Joi.object().keys({
        email: Joi.string()
            .email()
            .required(),
        name: Joi.string().required(),
        address: Joi.string().required(),
        password: Joi.string()
            .min(6)
            .max(16)
            .alphanum()
            .required(),
    });

    validation = Joi.validate(JSON.parse(ctx.request.body.values), schema);

    if (validation.error) {
        ctx.status = 400;
        ctx.body = {
            message: validation.error.details[0].message,
        };
        return;
    }

    const { email, name, address, password } = JSON.parse(
        ctx.request.body.values
    );

    try {
        const existing = await query('SELECT * FROM USER WHERE email = ?', [
            email,
        ]);
        if (existing && existing.length > 0) {
            ctx.status = 409;
            ctx.body = {
                message: '이미 존재하는 이메일 입니다.',
            };
            return;
        }
        const encrypted = encryptPassword(password);

        const user = await query(
            'INSERT INTO USER (email, name, address, password) VALUES (?, ?, ?, ?)',
            [email, name, address, encrypted]
        );

        if (user && user.affectedRows === 1) {
            ctx.status = 200;
            return;
        }
        ctx.status = 500;
        ctx.body = {
            message: '회원가입이 완료되지 않았습니다. 다시 시도해주세요',
        };
    } catch (e) {
        console.log(e);
        ctx.status = 500;
        ctx.body = {
            message: '알수없는 오류 발생. 다시 시도해주세요.',
        };
    }
};

exports.searchCustomer = async ctx => {
    const { authorization: token } = ctx.request.headers;
    try {
        const decoded = await decodeToken(token);
        if (!decoded) {
            ctx.status = 401;
            ctx.body = {
                message: 'invalid token',
            };
            return;
        }
        const { id } = decoded;
        let user = await query('SELECT * FROM USER WHERE id = ?', [id]);
        if (user.length === 0) {
            ctx.status = 404;
            ctx.body = {
                message: 'cannot find such user',
            };
            return;
        }
        user = user[0];
        if (!user) {
            ctx.status = 404;
            ctx.body = {
                message: 'cannot find such user',
            };
            return;
        }

        ctx.status = 200;

        ctx.body = {
            message: '',
            items: [
                {
                    id: user.id,
                    email: user.email,
                    name: user.name,
                    address: user.address,
                    phoneNumber: '010-1234-1234',
                    createAt: new Date(),
                    updateAt: new Date(),
                },
            ],
        };
    } catch (e) {
        console.log(e);
    }
};

exports.updateCustomer = async ctx => {
    console.log('updateCustomer');
    let schema = Joi.object().keys({
        values: Joi.string().required(),
    });
    let validation = Joi.validate(ctx.request.body, schema);
    if (validation.error) {
        console.log('error:', validation.error);
        ctx.status = 400;
        ctx.body = {
            message: '잘못된 정보를 전달하였습니다',
        };
        return;
    }

    let { values } = ctx.request.body;
    values = JSON.parse(values);

    schema = Joi.object().keys({
        email: Joi.string()
            .email()
            .required(),
        address: Joi.string().required(),
        phoneNumber: Joi.string().required(),
    });

    validation = Joi.validate(values, schema);

    if (validation.error) {
        console.log('error:', validation.error);
        ctx.status = 400;
        ctx.body = {
            message: '잘못된 정보를 전달하였습니다',
        };
        return;
    }

    const { email, address, phoneNumber } = values;
    const { authorization: token } = ctx.request.headers;
    try {
        const decoded = await decodeToken(token);
        const { id } = decoded;

        const user = await query('SELECT * FROM USER WHERE id = ?', [id]);
        // console.log(user);
        if (!user || user.length === 0) {
            ctx.status = 404;
            ctx.body = {
                message: '존재하지 않는 계정입니다',
            };
            return;
        }

        await query(
            'UPDATE USER email = ?, address = ?, phoneNumber = ? WHERE id = ?',
            [email, address, phoneNumber, id]
        );

        ctx.status = 200;
        ctx.body = {
            success: true,
        };
    } catch (e) {
        console.log(e);
        ctx.status = 500;
        ctx.body = {
            message: '500',
        };
    }
};
