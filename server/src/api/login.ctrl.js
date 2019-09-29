const Joi = require('joi');
const { query } = require('../lib/mysql');
const { checkPassword } = require('../lib/password');
const { generateToken } = require('../lib/token');

exports.login = async ctx => {
    const schema = Joi.object().keys({
        type: Joi.string().required(),
        loginId: Joi.string()
            .email()
            .required(),
        password: Joi.string()
            .min(6)
            .max(16)
            .alphanum()
            .required(),
    });

    const validation = Joi.validate(ctx.request.body, schema);

    if (validation.error) {
        ctx.status = 400;
        ctx.body = {
            message: validation.error.details[0].message,
        };
        return;
    }

    const { loginId, password } = ctx.request.body;

    try {
        const existing = await query('SELECT * FROM USER WHERE email = ?', [
            loginId,
        ]);

        if (!existing || existing.length === 0) {
            ctx.status = 404;
            ctx.body = {
                message: '없는 이메일 주소 입니다.',
            };
            return;
        }

        const { password: encrypted, id, email } = existing[0];
        if (!checkPassword(password, encrypted)) {
            ctx.status = 401;
            ctx.body = {
                message: '비밀번호가 일치하지 않습니다.',
            };
            return;
        }

        const token = await generateToken({ id, email });

        ctx.status = 200;
        ctx.body = {
            items: [
                {
                    token,
                    id,
                    user_type: '',
                    role: '',
                },
            ],
        };
    } catch (e) {
        console.log(e);
        ctx.status = 500;
    }
};
