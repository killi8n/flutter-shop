const Router = require('koa-router');
const customersCtrl = require('./customers.ctrl');
const { checkToken } = require('../../lib/token');

const router = new Router();

router.post('/', customersCtrl.createCustomer);
router.get('/', checkToken, customersCtrl.searchCustomer);
router.put('/', checkToken, customersCtrl.updateCustomer);

module.exports = router;
