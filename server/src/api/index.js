const Router = require('koa-router');
const customers = require('./customers');
const items = require('./items');
const customerHasItems = require('./customer-has-items');

const router = new Router();

router.use('/customers', customers.routes());
router.use('/items', items.routes());
router.use('/customer-has-items', customerHasItems.routes());

module.exports = router;
