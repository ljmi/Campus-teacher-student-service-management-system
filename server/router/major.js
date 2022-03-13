const Router = require("koa-router")
const major = new Router()
const bodyparser = require('koa-bodyparser')
const {
	query
} = require('../utils/db.js')
const {
	format
} = require('silly-datetime')
const {
	secretOrKey
} = require('../utils/key.js')
const {
	checkAdmin
} = require('../utils/check.js')
const koajwt = require('koa-jwt')
const {isEmpty} = require('../utils/valueCheck.js')

major.use(bodyparser());

/**
 * @route post /major/getInfoByAcademyId
 * @desc 专业信息接口
 * @access 接口私有 只能管理员使用
 */
major.post('/getInfoByAcademyId', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;
	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {
		let {
			academyId
		} = ctx.request.body;
		let sql = `SELECT majorId,name  from tb_major where academyId='${academyId}';`
		let result = await query(sql)
		let list = []
		result.forEach(item => {
			list.push({
				key: item.majorId,
				display_name: item.name
			})
		})
		ctx.body = {
			code: 200,
			data: list
		}

	} else {
		ctx.body = returnDat.msg;
	}
})


/**
 * @route post /major/page
 * @desc 学生分页查寻信息接口
 * @access 接口私有 只能管理员使用
 */
major.post('/page', koajwt({
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

		let sql =`select a.majorId,a.specialtyCode,a.name,a.academyId,b.name as academyName,(SELECT COUNT(*) from tb_major)as count from tb_major a,tb_academy b where a.academyId=b.academyId limit ${page},${pageSize};`
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
 * @route post /major/searchunion
 * @desc 专业搜索分页接口
 * @access 接口私有 只能管理员使用
 */
major.post('/searchunion', koajwt({
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
			searchValue,
			academyKey
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
			let symbolcheck = /[\u4e00-\u9fa5]+/g;

			let sql =`select a.majorId,a.specialtyCode,a.name,a.academyId,b.name as academyName,(SELECT COUNT(*) from tb_major where specialtyCode LIKE '%${ searchValue }%' and academyId='${academyKey}')as count from tb_major a,tb_academy b where a.academyId=b.academyId and a.specialtyCode LIKE '%${ searchValue }%' and b.academyId='${academyKey}' limit ${page},${pageSize};`
			if (symbolcheck.test(searchValue)) {
				sql =`select a.majorId,a.specialtyCode,a.name,a.academyId,b.name as academyName,(SELECT COUNT(*) from tb_major where name LIKE '%${ searchValue }%' and academyId='${academyKey}')as count from tb_major a,tb_academy b where a.academyId=b.academyId and a.name LIKE '%${ searchValue }%' and b.academyId='${academyKey}' limit ${page},${pageSize};`
			}

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
 * @route post /major/search
 * @desc 学生搜索分页接口
 * @access 接口私有 只能管理员使用
 */
major.post('/search', koajwt({
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
			let symbolcheck = /[\u4e00-\u9fa5]+/g;

			let sql =`select a.majorId,a.specialtyCode,a.name,a.academyId,b.name as academyName,(SELECT COUNT(*) from tb_major where specialtyCode LIKE '%${ searchValue }%')as count from tb_major a,tb_academy b where a.academyId=b.academyId and a.specialtyCode LIKE '%${ searchValue }%' limit ${page},${pageSize};`

			if (symbolcheck.test(searchValue)) {
				sql =`select a.majorId,a.specialtyCode,a.name,a.academyId,b.name as academyName,(SELECT COUNT(*) from tb_major where name LIKE '%${ searchValue }%')as count from tb_major a,tb_academy b where a.academyId=b.academyId and a.name LIKE '%${ searchValue }%' limit ${page},${pageSize};`
			}

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
 * @route post /major/getLastMajorByAcademy
 * @desc 根据学院查最后一个专业接口
 * @access 接口私有 只能管理员使用
 */
major.post('/getLastMajorByAcademy', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		academyId
	} = ctx.request.body;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {

		let sql =` select majorId from tb_major WHERE academyId='${academyId}' order by majorId DESC limit 1;`
		let myarr = await query(sql)

		if (myarr.length > 0) {
			let value = "2" + myarr[0].majorId
			value = Number(value) + 1
			value = "'" + value + "'"
			let num = value.substr(2, 4)

			ctx.body = {
				code: 200,
				data: num
			};

		} else {
			let acc = academyId + "01"
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
 * @route post /major/getAcademyByMajorSeach
 * @desc 根据学院搜索学生分页接口
 * @access 接口私有 只能管理员使用
 */
major.post('/getAcademyByMajorSeach', koajwt({
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
			academyKey
		} = ctx.request.body;

		//判断页码
		if (!page || isNaN(Number(page))) {
			page = 1
		} else {
			page = Number(page)
		}
		page = (page - 1) * pageSize

		if (isEmpty(academyKey)) {
			ctx.body = {
				code: 400,
				msg: "参数错误"
			}

		} else {
			let sql =`select a.majorId,a.specialtyCode,a.name,a.academyId,b.name as academyName,(SELECT COUNT(*) from tb_major where academyId='${ academyKey }') as count from tb_major a,tb_academy b where a.academyId=b.academyId and a.academyId='${ academyKey }' limit ${page},${pageSize};`

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
 * @route post /major/updata
 * @desc 单个学生添加接口
 * @access 接口私有 只能管理员使用
 */
major.post('/updata', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		academyId,
		name,
		specialtyCode,
		majorId
	} = ctx.request.body;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {
		let sql =`UPDATE tb_major set academyId='${academyId}',specialtyCode='${specialtyCode}',name='${name}' where majorId='${majorId}'`;

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
 * @route post /major/singleAdd
 * @desc 单个专业添加接口
 * @access 接口私有 只能管理员使用
 */
major.post('/singleAdd', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		academyId,
		majorId,
		name,
		specialtyCode
	} = ctx.request.body;
	let createTime = format(new Date(), 'YYYY-MM-DD HH:mm:ss');

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {

			let sql =`insert into tb_major(academyId,majorId,name,specialtyCode) value('${academyId}','${majorId}','${name}','${specialtyCode}');`;
			let result = await query(sql)
			if (result.affectedRows > 0) {
				ctx.body = {
					code: 200,
					msg: "添加成功"
				};
			} else {
				ctx.body = {
					code: 400,
					msg: '专业已存在'
				};
			}
		

	} else {
		ctx.body = returnDat.msg;
	}
})


/**
 * @route post /major/singleDel
 * @desc 单个学生删除接口
 * @access 接口私有 只能管理员使用
 */
major.post('/singleDel', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		majorId
	} = ctx.request.body;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {
		
			let sql =`DELETE from tb_major where majorId='${majorId}';`
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





module.exports = major;
