const Router = require('koa-router');
const itemsCtrl = require('./items.ctrl');

const router = new Router();

router.get('/', itemsCtrl.getAllItems);
router.get('/:id', itemsCtrl.searchItems);

module.exports = router;
