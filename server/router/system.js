const Router = require("koa-router")
const system = new Router()
const bodyparser = require('koa-bodyparser')
const {query} = require('../utils/db.js')
const {secretOrKey} = require('../utils/key.js')
const {checkAdmin} = require('../utils/check.js')
const koajwt = require('koa-jwt')
const {isEmpty} = require('../utils/valueCheck.js')

system.use(bodyparser());

/**
 * @route post /system/all
 * @desc 系统设置分页查寻信息接口
 * @access 接口私有
 */
system.post('/all', async ctx => {

	let sql =`select systemId,title,createTime,content from tb_settings;`
	let result = await query(sql)

	ctx.body = {
		code: 200,
		data: {
			items: result
		}
	}
})

/**
 * @route post /system/page
 * @desc 系统设置分页查寻信息接口
 * @access 接口私有 只能管理员使用
 */
system.post('/page', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;
	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {

		let {
			page,
			pageSize
		} = ctx.request.body;

		//判断页码
		if (!page || isNaN(Number(page))) {
			page = 1
		} else {
			page = Number(page)
		}
		page = (page - 1) * pageSize

		let sql =`select settingsId,switch,ruleName,(SELECT COUNT(*) from tb_settings)as count from tb_settings limit ${page},${pageSize};`;
		let result = await query(sql)

		let count
		if (result.length == 0) {
			count = 0
		} else {
			count = result[0].count
		}
		ctx.body = {
			code: 200,
			data: {
				total: count,
				items: result
			}
		}
	} else {
		ctx.body = returnDat.msg;
	}
})

/**
 * @route post /system/updata
 * @desc 单个系统设置修改接口
 * @access 接口私有 只能管理员使用
 */
system.post('/updata', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		settingsId,
		ruleName
	} = ctx.request.body;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {
		let sql =`UPDATE tb_settings set ruleName='${ruleName}' where settingsId='${settingsId}';`

		let result = await query(sql)
		if (result.affectedRows > 0) {
			ctx.body = {
				code: 200,
				msg: "修改成功"
			};
		} else {
			ctx.body = {
				code: 400,
				msg: '修改失败'
			};
		}

	} else {
		ctx.body = returnDat.msg;
	}
})

/**
 * @route post /system/singleAdd
 * @desc 单个系统设置添加接口
 * @access 接口私有 只能管理员使用
 */
system.post('/singleAdd', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		ruleName,
		switchValue
	} = ctx.request.body;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {

		let sql =`insert into tb_settings(ruleName,switch) value('${ruleName}','${switchValue}');`
		let result = await query(sql)
		if (result.affectedRows > 0) {
			ctx.body = {
				code: 200,
				msg: "添加成功"
			};
		} else {
			ctx.body = {
				code: 400,
				msg: '添加失败'
			};
		}


	} else {
		ctx.body = returnDat.msg;
	}
})

/**
 * @route post /system/singleDel
 * @desc 单个系统设置删除接口
 * @access 接口私有 只能管理员使用
 */
system.post('/singleDel', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		settingsId
	} = ctx.request.body;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {

		let sql =`DELETE from tb_settings where settingsId='${settingsId}';`
		let result = await query(sql)
		if (result.affectedRows > 0) {
			ctx.body = {
				code: 200,
				msg: "删除成功"
			};
		} else {
			ctx.body = {
				code: 400,
				msg: '删除失败'
			};
		}

	} else {
		ctx.body = returnDat.msg;
	}
})

/**
 * @route post /system/search
 * @desc 系统设置搜索分页接口
 * @access 接口私有 只能管理员使用
 */
system.post('/search', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;
	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {
		let {
			page,
			pageSize,
			searchValue
		} = ctx.request.body;

		//判断页码
		if (!page || isNaN(Number(page))) {
			page = 1
		} else {
			page = Number(page)
		}
		page = (page - 1) * pageSize

		if (isEmpty(searchValue)) {
			ctx.body = {
				code: 400,
				msg: "参数错误"
			}

		} else {

			let sql =`select settingsId,ruleName,switch,(SELECT COUNT(*) from tb_settings where ruleName LIKE '%${ searchValue }%')as count from tb_settings where ruleName LIKE '%${ searchValue }%' limit ${page},${pageSize};`

			let result = await query(sql)
			let count
			if (result.length == 0) {
				count = 0
			} else {
				count = result[0].count
			}
			ctx.body = {
				code: 200,
				data: {
					total: count,
					items: result
				}
			}

		}

	} else {
		ctx.body = returnDat.msg;
	}
})

/**
 * @route post /system/updataJurisdiction
 * @desc 所有管理员信息接口
 * @access 接口私有
 */
system.post('/updataJurisdiction', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {
		let {value,settingsId}=ctx.request.body;
		let switchc=1
		if(value){
			switchc=0
		}

		let sql = `UPDATE tb_settings set switch='${switchc}' where settingsId='${settingsId}';`;
		let result = await query(sql)
		if (result.affectedRows > 0) {
			ctx.body = {
				code: 200,
				msg: "修改成功"
			};
		} else {
			ctx.body = {
				code: 400,
				msg: '修改失败'
			};
		}

	} else {
		ctx.body = returnDat.msg;
	}

})

module.exports = system;
