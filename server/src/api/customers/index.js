const Router = require('koa-router');
const customersCtrl = require('./customers.ctrl');

const router = new Router();

router.post('/', customersCtrl.createCustomer);
router.get('/:id', customersCtrl.searchCustomer);
router.put('/:id', customersCtrl.updateCustomer);

module.exports = router;
