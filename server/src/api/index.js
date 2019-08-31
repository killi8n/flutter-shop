const Router = require('koa-router');
const customers = require('./customers');

const router = new Router();

router.use('/customers', customers.routes());

module.exports = router;
