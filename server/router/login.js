const Router = require("koa-router")
const login = new Router()
const bodyparser = require('koa-bodyparser')
const { query } = require('../utils/db.js')
const {sign} = require('jsonwebtoken')
const {compareSync} = require('bcryptjs')
const {secretOrKey} = require('../utils/key.js')
const {isNotEmpty}=require('../utils/valueCheck.js')

login.use(bodyparser());


/**
 * @route post /login
 * @desc 学生/教职工登录接口
 * @access 接口公开
 */
login.post('/', async ctx => {
	let {account,password,type} = ctx.request.body;
	
	if (isNotEmpty(account) && isNotEmpty(password)) {
		let sql = `select account,name,password from tb_student where account=${account}`;
		switch(type){
			case 2:
			sql=`select account,name,password from tb_teacher where account=${account} and type='教职工'`;
			break;
			case 3:
			sql=`select account,name,password from tb_teacher where account=${account} and type='辅导员'`;
			break;
			default:
			break;
		}

		let result = await query(sql)
		if (result.length > 0) {
			let check = await compareSync(password, result[0].password);
			if (check) {
				const token = sign({
					account: result[0].account,
					name: result[0].name,
					type: "admin"
				}, secretOrKey, {
					expiresIn: '18000s'
				});
				ctx.body = {
					code: 200,
					msg: "登录成功",
					data: { "token": 'Bearer '+token }
				};

			} else {
				ctx.body = {
					code: 400,
					msg: "账号或密码错误"
				};
			}
		} else {
			ctx.body = {
				code: 200,
				msg: "用户不存在"
			}
		}
	} else {
		ctx.body = {
			code: 400,
			msg: "传参错误"
		}
	}

})

/**
 * @route post /login/admin
 * @desc 管理员登录接口
 * @access 接口公开
 */
login.post('/admin', async (ctx, next) => {
	let { account, password } = ctx.request.body;

	if (isNotEmpty(account) && isNotEmpty(password)) {

		let sql = `select account,name,password,jurisdiction from tb_admin where account=${account}`;
		let result = await query(sql)

		if (result.length > 0) {
			let checkJurisdiction = result[0].jurisdiction;

			if (checkJurisdiction == 1) {
				let check = await compareSync(password, result[0].password);
				if (check) {
					const token = sign({
						account: result[0].account,
						name: result[0].name,
						admin: "admin",
						jurisdiction: result[0].jurisdiction
					}, secretOrKey, {
						expiresIn: '18000s'
					});
					ctx.body = {
						code: 200,
						msg: "登录成功",
						data: { "token": 'Bearer '+token }
					};

				} else {
					ctx.body = {
						code: 400,
						msg: "账号或密码错误"
					};
				}
			} else if (checkJurisdiction == 2) {
				ctx.body = {
					code: 400,
					msg: "该管理员已禁用"
				};
			} else {
				ctx.body = {
					code: 400,
					msg: "登录失败"
				};
			}


		} else {
			ctx.body = {
				code: 200,
				msg: "管理员不存在"
			}
		}

	} else {
		ctx.body = {
			code: 400,
			msg: "传参错误"
		}
	}

})


module.exports = login;
