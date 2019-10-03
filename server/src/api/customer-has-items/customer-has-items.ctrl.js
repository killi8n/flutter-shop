const Joi = require('joi');
const { decodeToken } = require('../../lib/token');
const { query } = require('../../lib/mysql');

exports.create = async ctx => {
    const { authorization: token } = ctx.request.headers;

    let schema = Joi.object().keys({
        values: Joi.string().required(),
    });

    let validate = Joi.validate(ctx.request.body, schema);

    if (validate.error) {
        console.log(validate.error);
        ctx.status = 400;
        ctx.body = {
            message: 'invalid body',
        };
        return;
    }

    const { values } = ctx.request.body;

    schema = Joi.object().keys({
        itemId: Joi.number().required(),
        count: Joi.number().required(),
    });

    validate = Joi.validate(JSON.parse(values), schema);

    if (validate.error) {
        console.log(validate.error);
        ctx.status = 400;
        ctx.body = {
            message: 'invalid body',
        };
        return;
    }

    const { itemId, count } = JSON.parse(values);

    try {
        const decoded = await decodeToken(token);
        const { id: userId } = decoded;

        const existing = await query('SELECT * FROM CART WHERE userId = ?', [
            userId,
        ]);

        if (existing.length === 1) {
            const existingItems = JSON.parse(existing[0].items);
            const newItem = {
                itemId,
                count,
            };
            const newItems = [...existingItems, newItem];
            await query('UPDATE CART SET items = ? WHERE userId = ?', [
                JSON.stringify(newItems),
                userId,
            ]);
        } else {
            await query(`INSERT INTO CART (userId, items) VALUES (?, ?)`, [
                userId,
                JSON.stringify([{ itemId, count }]),
            ]);
        }

        ctx.status = 200;
    } catch (e) {
        console.log(e);
        ctx.status = 500;
    }
};

//       _ItemInfo(0, Image.network('http://thumbnail.10x10.co.kr/webimage/image/basic600/137/B001377515.jpg'    ), '뼈다귀 모양 베개'  , 10000, 1),
//       _ItemInfo(1, Image.network('https://mi6.rightinthebox.com/images/384x384/201704/pqf1493005948537.jpg'   ), '빨간 스웨터'       ,  8000, 2),
//       _ItemInfo(2, Image.network('https://seoul-p-studio.bunjang.net/product/81561624_3_1520763876_w640.jpg'  ), '강아지 용 백팩'    , 18000, 3),
//       _ItemInfo(3, Image.network('https://mi7.rightinthebox.com/images/384x384/201307/khabye1372647520194.jpg'), '귀여운 강아지 신발', 12000, 1),
exports.getAll = async ctx => {
    const { authorization: token } = ctx.request.headers;

    try {
        const decoded = await decodeToken(token);
        const { id } = decoded;
        const existing = await query('SELECT * FROM CART WHERE userId = ?', [
            id,
        ]);

        if (!existing || existing.length === 0) {
            ctx.status = 200;
            ctx.body = {
                items: [],
            };
            return;
        }
        const { items: carts } = existing[0];

        const items = await Promise.all(
            JSON.parse(carts)
                .map(async cart => {
                    try {
                        const item = await query(
                            'SELECT * FROM ITEM WHERE id = ?',
                            [cart.itemId]
                        );
                        return {
                            ...item[0],
                            count: cart.count,
                        };
                    } catch (e) {
                        console.log(e);
                        ctx.status = 500;
                        ctx.body = {
                            message: 'internal server error',
                        };
                        return;
                    }
                })
                .reverse()
        );

        ctx.body = {
            message: '',
            items,
        };
        ctx.status = 200;
    } catch (e) {
        console.log(e);
        ctx.status = 500;
        ctx.body = {
            message: 'internal server error',
        };
    }
};

exports.getById = async ctx => {
    try {
        ctx.body = {
            success: true,
        };
        ctx.status = 200;
    } catch (e) {
        console.log(e);
        ctx.status = 500;
    }
};

exports.updateById = async ctx => {
    try {
        ctx.body = {
            success: true,
        };
        ctx.status = 200;
    } catch (e) {
        console.log(e);
        ctx.status = 500;
    }
};

exports.pay = async ctx => {
    try {
        ctx.body = {
            success: true,
        };
        ctx.status = 200;
    } catch (e) {
        console.log(e);
        ctx.status = 500;
    }
};
