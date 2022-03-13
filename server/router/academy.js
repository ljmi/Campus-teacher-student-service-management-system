const Router = require("koa-router")
const academy = new Router()
const bodyparser = require('koa-bodyparser')
const {
	query
} = require('../utils/db.js')
const {
	secretOrKey
} = require('../utils/key.js')
const {
	checkAdmin
} = require('../utils/check.js')
const koajwt = require('koa-jwt')


academy.use(bodyparser())

/**
 * @route post /academy/info
 * @desc 学院信息接口
 * @access 接口私有 只能管理员使用
 */
academy.post('/info', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user
	let returnDat = checkAdmin(admin, jurisdiction)

	if (returnDat.state) {
		//查询所有学院信息
		let sql = `SELECT academyId,name from tb_academy;`
		let result = await query(sql)
		let list = []
		result.forEach(item => {
			let obj = {
				key: item.academyId,
				display_name: item.name
			}
			list.push(obj)
		})

		ctx.body = {
			code: 200,
			data: list
		}

	} else {
		ctx.body = returnDat.msg
	}
})


/**
 * @route post /academy/all
 * @desc 学院信息接口
 * @access 接口私有 只能管理员使用
 */
academy.post('/all', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user
	let returnDat = checkAdmin(admin, jurisdiction)

	if (returnDat.state) {
		//查询所有学院信息
		let sql = `SELECT *  from tb_academy;`
		let result = await query(sql)

		ctx.body = {
			code: 200,
			data: result
		}

	} else {
		ctx.body = returnDat.msg
	}
})

/**
 * @route post /academy/getLastAcademyId
 * @desc 查最后一个学院接口
 * @access 接口私有 只能管理员使用
 */
academy.post('/getLastAcademyId', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user

	let returnDat = checkAdmin(admin, jurisdiction)

	if (returnDat.state) {
		let sql = ` select academyId from tb_academy order by academyId DESC limit 1;`
		let result = await query(sql)

		if (result.length > 0) {
			let num = Number(result[0].academyId) + 1
			ctx.body = {
				code: 200,
				data: num
			};

		} else {
			let acc = "01"
			ctx.body = {
				code: 200,
				data: acc
			};
		}
	} else {
		ctx.body = returnDat.msg
	}
})



/**
 * @route post /academy/cascade
 * @desc 学院信息接口
 * @access 接口私有
 */
academy.post('/cascade', koajwt({
	secret: secretOrKey
}), async ctx => {
	//查询所有学院信息
	let sql = `SELECT academyId,name  from tb_academy;`
	let result = await query(sql)

	//查询所有专业信息
	let sql1 = `SELECT majorId,name  from tb_major;`
	let result1 = await query(sql1)

	//查询所有班级信息
	let sql2 = `SELECT classId,name  from tb_class;`
	let result2 = await query(sql2)

	var list = []

	for (var i = 0; i < result.length; i++) {
		let obj = {
			value: result[i].academyId,
			label: result[i].name,
			children: []
		}
		list.push(obj)

	}

	for (var u = 0; u < list.length; u++) {
		for (var j = 0; j < result1.length; j++) {
			if (list[u].value == result1[j].academyId) {
				let obj = {
					value: result1[j].majorId,
					label: result1[j].name,
					children: []
				}
				list[u].children.push(obj)
			}
		}
	}

	for (var l = 0; l < list.length; l++) {
		for (var k = 0; k < list[l].children.length; k++) {
			for (var m = 0; m < result2.length; m++) {
				if (result2[m].academyId == list[l].value && result2[m].majorId == list[l].children[k]
					.value) {
					let obj = {
						value: result2[m].classId,
						label: result2[m].name,
					}
					list[l].children[k].children.push(obj)
				}
			}
		}
	}

	ctx.body = {
		code: 200,
		data: list
	}

	// let sql = `SELECT a.academyId,a.name as academyName,b.majorId,b.name as majorName,c.classId,c.name as className  from tb_academy a, tb_major b,tb_class c WHERE a.academyId=b.academyId  and  b.majorId=c.majorId;`
	// let result = await query(sql)
	// ctx.body = {
	// 	code: 200,
	// 	data: list
	// }
	// var list
	// const makeTree(arr,type){
	// 	if(typeof type==='undefined' ){
	// 		arr.forEach(i =>{

	// 		})
	// 	}
	// }

	// console.log(result)

})


/**
 * @route post /academy/cascade
 * @desc 学院信息接口
 * @access 接口私有 只能管理员使用
 */
academy.post('/cascadeMajorAndAcademy', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user
	let returnDat = checkAdmin(admin, jurisdiction)

	if (returnDat.state) {
		//查询所有学院信息
		let sql = `SELECT academyId,name  from tb_academy;`
		let result = await query(sql)

		//查询所有专业信息
		let sql1 = `SELECT majorId,name  from tb_major;`
		let result1 = await query(sql1)

		var list = []

		for (var i = 0; i < result.length; i++) {
			let obj = {
				value: result[i].academyId,
				label: result[i].name,
				children: []
			}
			list.push(obj)

		}

		for (var u = 0; u < list.length; u++) {
			for (var j = 0; j < result1.length; j++) {
				if (list[u].value == result1[j].academyId) {
					let obj = {
						value: result1[j].majorId,
						label: result1[j].name
					}
					list[u].children.push(obj)
				}
			}
		}

		ctx.body = {
			code: 200,
			data: list
		}

	} else {
		ctx.body = returnDat.msg
	}
})

/**
 * @route post /academy/singleAdd
 * @desc 单个学院添加接口
 * @access 接口私有 只能管理员使用
 */
academy.post('/singleAdd', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user

	let {
		academyId,
		name
	} = ctx.request.body

	let returnDat = checkAdmin(admin, jurisdiction)

	if (returnDat.state) {
		let sql = `insert into tb_academy(academyId,name) value('${academyId}','${name}');`
		let result = await query(sql)

		if (result.affectedRows > 0) {
			ctx.body = {
				code: 200,
				msg: "添加成功"
			}
		} else {
			ctx.body = {
				code: 400,
				msg: '该学院已存在'
			}
		}

	} else {
		ctx.body = returnDat.msg
	}
})

/**
 * @route post /academy/cascade
 * @desc 学院信息接口
 * @access 接口私有 只能管理员使用
 */
academy.post('/cascade', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user
	let returnDat = checkAdmin(admin, jurisdiction)

	if (returnDat.state) {
		//查询所有学院信息
		let sql = `SELECT academyId,name  from tb_academy;`
		let result = await query(sql)

		let list = []
		result.forEach(i => {
			let obj = {
				value: i.academyId,
				label: i.name
			}
			list.push(obj)
		})


		ctx.body = {
			code: 200,
			data: list
		}

	} else {
		ctx.body = returnDat.msg
	}
})

/**
 * @route post /academy/updata
 * @desc 单个学生添加接口
 * @access 接口私有 只能管理员使用
 */
academy.post('/updata', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user

	let {
		academyId,
		name
	} = ctx.request.body

	let returnDat = checkAdmin(admin, jurisdiction)

	if (returnDat.state) {
		let sql = `UPDATE tb_academy set name='${name}' where academyId='${academyId}';`

		let result = await query(sql)
		if (result.affectedRows > 0) {
			ctx.body = {
				code: 200,
				msg: "修改成功"
			}
		} else {
			ctx.body = {
				code: 400,
				msg: '修改失败'
			}
		}

	} else {
		ctx.body = returnDat.msg
	}
})

/**
 * @route post /academy/singleDel
 * @desc 单个教职工删除接口
 * @access 接口私有 只能管理员使用
 */
academy.post('/singleDel', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user

	let {
		academyId
	} = ctx.request.body

	let returnDat = checkAdmin(admin, jurisdiction)

	if (returnDat.state) {
		let sql = `DELETE from tb_academy where academyId='${academyId}';`
		let result = await query(sql)
		if (result.affectedRows > 0) {
			ctx.body = {
				code: 200,
				msg: "删除成功"
			}
		} else {
			ctx.body = {
				code: 400,
				msg: '删除失败'
			}
		}

	} else {
		ctx.body = returnDat.msg
	}
})




module.exports = academy
