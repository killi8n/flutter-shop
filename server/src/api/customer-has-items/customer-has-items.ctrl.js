exports.create = async ctx => {
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

exports.getAll = async ctx => {
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
