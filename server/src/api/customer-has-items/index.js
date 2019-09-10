const Router = require('koa-router');
const customerHasItemsCtrl = require('./customer-has-items.ctrl');

const router = new Router();

router.post('/', customerHasItemsCtrl.create);
router.get('/', customerHasItemsCtrl.getAll);
router.get('/:id', customerHasItemsCtrl.getById);
router.put('/:id', customerHasItemsCtrl.updateById);
router.post('/pay', customerHasItemsCtrl.pay);

module.exports = router;
