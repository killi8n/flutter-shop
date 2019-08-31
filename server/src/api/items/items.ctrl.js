exports.getAllItems = async ctx => {
    try {
        ctx.status = 200;
        ctx.body = {
            success: true,
        };
    } catch (e) {
        console.log(e);
        ctx.status = 500;
    }
};

exports.searchItems = async ctx => {
    try {
        ctx.status = 200;
        ctx.body = {
            success: true,
        };
    } catch (e) {
        console.log(e);
        ctx.status = 500;
    }
};
