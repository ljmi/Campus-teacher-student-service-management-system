const Koa=require("koa")
const router=require("./router")
const errorHandler = require('./utils/errorHandler.js')
const cors=require('koa-cors')
const {scheduleCronstyle}=require('./utils/schedule.js')

const app=new Koa()

//允许跨域
// 这里cors中间件一定要写在路由之前
// app.use(cors());
app.use(cors())




// scheduleCronstyle();


// 配置路由
/*
router.routes():启动路由
router.allowedMethods():允许任何请求（get、post、put）
*/
app.use(router.routes()).use(router.allowedMethods())

errorHandler(app)

const port =process.env.PORT||3000;

app.listen(port,()=>{
	console.log(`server started on ${port}!`);
})