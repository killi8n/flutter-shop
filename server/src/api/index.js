const Router = require('koa-router');
const customers = require('./customers');
const items = require('./items');
const loginCtrl = require('./login.ctrl');

const router = new Router();

router.use('/customers', customers.routes());
router.use('/items', items.routes());
router.post('/login', loginCtrl.login);

module.exports = router;
