const Router = require('koa-router');
const customerHasItemsCtrl = require('./customer-has-items.ctrl');

const router = new Router();

router.get('/', customerHasItemsCtrl.getCustomerHasItems);
router.get('/:id', customerHasItemsCtrl.getCustomerHasItemById);
router.post('/', customerHasItemsCtrl.createCustomerHasItem);
router.post('/pay', customerHasItemsCtrl.pay);
router.put('/:id', customerHasItemsCtrl.updateCustomerHasItemById);

module.exports = router;
