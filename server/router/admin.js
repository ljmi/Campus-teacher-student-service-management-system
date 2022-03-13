const Router = require("koa-router")
const admin = new Router()
const bodyparser = require('koa-bodyparser')
const {query} = require('../utils/db.js')
const {format} = require('silly-datetime')
const {enbcrypt} = require('../utils/tool.js')
const {secretOrKey} = require('../utils/key.js')
const {checkAdmin} = require('../utils/check.js')
const koajwt = require('koa-jwt')
const {isNotEmpty} = require('../utils/valueCheck.js')

admin.use(bodyparser());



/**
 * @route post /admin/singleAdd
 * @desc 单个管理员添加接口
 * @access 接口私有
 */
admin.post('/singleAdd', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {
		let {
			account,
			name,
			headImg,
			mail,
			address,
			sex,
			phone
		} = ctx.request.body;

		var password = '123456';
		let jurisdiction1 = ctx.request.body.jurisdiction;
		let createTime = format(new Date(), 'YYYY-MM-DD HH:mm:ss');

		password = enbcrypt(password);
		let sql =
			`insert into tb_admin(account,password,name,headImg,mail,address,sex,phone,jurisdiction,createTime) value('${account}','${password}','${name}','${headImg}','${mail}','${address}','${sex}','${phone}','${jurisdiction1}','${createTime}');`;
		let result = await query(sql)
		if (result.affectedRows > 0) {
			ctx.body = {
				code: 200,
				msg: "添加成功"
			};
		} else {
			ctx.body = {
				code: 400,
				msg: '管理员已存在'
			};
		}


	} else {
		ctx.body = returnDat.msg;
	}



})

/**
 * @route get /admin/info
 * @desc 管理员信息接口
 * @access 接口私有
 */
admin.post('/info', koajwt({
	secret: secretOrKey
}), async ctx => {

	let {
		account
	} = ctx.state.user;

	let sql = `select headImg,name from tb_admin where account='${account}'`;
	let result = await query(sql)
	ctx.body = {
		"code": 200,
		"data": {
			"roles": ["admin"],
			"avatar": result[0].headImg,
			"name": result[0].name
		}
	};

})


/**
 * @route post /admin/adminList
 * @desc 所有管理员信息接口
 * @access 接口私有
 */
admin.post('/adminList', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {

		let sql = `SELECT adminId,account,name,sex,phone,jurisdiction from tb_admin;`;
		let result = await query(sql)
		let list = [];
		result.forEach(item => {
			let obj = {
				adminId: item.adminId,
				account: item.account,
				name: item.name,
				sex: item.sex,
				phone: item.phone,
				jurisdiction: item.jurisdiction,
				delivery: true
			}
			if (item.jurisdiction == 1) {
				obj.delivery=true
			} else {
				obj.delivery=false
			}
			list.push(obj)
		})
		ctx.body = {
			code: 200,
			data: list
		};

	} else {
		ctx.body = returnDat.msg;
	}

})

/**
 * @route post /admin/updataJurisdiction
 * @desc 所有管理员信息接口
 * @access 接口私有
 */
admin.post('/updataJurisdiction', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {admin,jurisdiction} = ctx.state.user;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {
		let {
			delivery,
			adminId
		} = ctx.request.body;
		let jurisdiction1 = 1
		if (delivery) {
			jurisdiction1 = 2
		} else {
			jurisdiction1 = 1
		}

		let sql = `UPDATE tb_admin set jurisdiction='${jurisdiction1}' where adminId='${adminId}';`;
		let result = await query(sql)
		ctx.body = {
			code: 200,
			data: result
		};

	} else {
		ctx.body = returnDat.msg;
	}

})


/**
 * @route post /admin/getLastAdminId
 * @desc 查管理员接口
 * @access 接口私有 只能管理员使用
 */
admin.post('/getLastAdminId', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {
		let sql =` select adminId from tb_admin order by adminId DESC limit 1;`;
		let result = await query(sql)

		if (result.length > 0) {
			let num = Number(result[0].adminId) + 1
			ctx.body = {
				code: 200,
				data: num
			};

		} else {
			let acc = 1;
			ctx.body = {
				code: 200,
				data: acc
			};
		}
	} else {
		ctx.body = returnDat.msg;
	}
})


/**
 * @route post /admin/updata
 * @desc 单个管理员修改接口
 * @access 接口私有 只能管理员使用
 */
admin.post('/updata', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		account,
		adminId,
		name,
		sex,
		address,
		mail,
		phone,
		delivery,
		headImg,
		password
	} = ctx.request.body;
	let jurisdiction1 = ctx.request.body.jurisdiction;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {
		let sql =`UPDATE tb_admin set account='${account}',name='${name}',sex='${sex}',address='${address}',mail='${mail}',phone='${phone}',jurisdiction='${jurisdiction1}',headImg='${headImg}' where adminId='${adminId}'`;

		if (isNotEmpty(password)) {
			password = enbcrypt(password);
			sql =`UPDATE tb_admin set account='${account}',name='${name}',sex='${sex}',address='${address}',mail='${mail}',phone='${phone}',jurisdiction='${jurisdiction1}',headImg='${headImg}',password='${password}' where adminId='${adminId}'`;
		}

		let result = await query(sql)
		if(result.affectedRows>0){
			ctx.body = {
						code: 200,
						msg: "修改成功"
					};
		}  else {
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
 * @route post /admin/singleDel
 * @desc 单个管理员删除接口
 * @access 接口私有 只能管理员使用
 */
admin.post('/singleDel', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		adminId
	} = ctx.request.body;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {
			let sql =`DELETE from tb_admin where adminId='${adminId}';`;
			let result = await query(sql)
		if(result.affectedRows>0){
			ctx.body = {
						code: 200,
						msg: "删除成功"
					};
		}  else {
		ctx.body = {
			code: 400,
			msg: '删除失败'
		};
		}

	} else {
		ctx.body = returnDat.msg;
	}
})




module.exports = admin;
