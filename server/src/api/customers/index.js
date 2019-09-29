const Router = require('koa-router');
const customersCtrl = require('./customers.ctrl');

const router = new Router();

router.post('/', customersCtrl.createCustomer);
router.get('/', customersCtrl.searchCustomer);
router.put('/', customersCtrl.updateCustomer);

module.exports = router;
