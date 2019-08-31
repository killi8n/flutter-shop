exports.createCustomer = async ctx => {
    try {
        ctx.status = 200;
        ctx.body = {
            success: true,
        };
    } catch (e) {
        console.log(e);
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
