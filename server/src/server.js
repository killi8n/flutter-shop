require('dotenv').config();

const Koa = require('koa');
const Router = require('koa-router');
const bodyParser = require('koa-bodyparser');
const { jwtMiddleware } = require('./lib/token');
const api = require('./api');

const { SERVER_PORT: port } = process.env;

const app = new Koa();

const router = new Router();

router.use('/api', api.routes());

app.use(router.routes()).use(router.allowedMethods());
app.use(bodyParser());
app.use(jwtMiddleware);

app.listen(port, () => {
    console.log('server is running on port', port);
});
