const Joi = require('joi');
const { query } = require('../../lib/mysql');
const { encryptPassword, checkPassword } = require('../../lib/password');

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
    const { id } = ctx.params;
    if (!id) {
        ctx.body = {
            message: 'need id',
        };
        ctx.status = 400;
        return;
    }
    try {
        const user = await query('SELECT * FROM USER WHERE id = ?', [id]);
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
                    phone_number: '010-1234-1234',
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
    try {
        ctx.status = 200;
        ctx.body = {
            success: true,
        };
    } catch (e) {
        console.log(e);
    }
};
