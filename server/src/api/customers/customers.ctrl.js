const { query } = require('../../lib/mysql');

exports.createCustomer = async ctx => {
    try {
        const createdUser = await query('INSERT INTO');

        ctx.status = 200;
        ctx.body = {
            success: true,
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
    try {
        ctx.status = 200;
        ctx.body = {
            success: true,
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
