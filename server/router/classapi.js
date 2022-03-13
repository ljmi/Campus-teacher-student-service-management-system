const Router = require("koa-router")
const classapi = new Router()
const bodyparser = require('koa-bodyparser')
const {query} = require('../utils/db.js')
const {secretOrKey} = require('../utils/key.js')
const {checkAdmin} = require('../utils/check.js')
const koajwt = require('koa-jwt')
const {isEmpty} = require('../utils/valueCheck.js')

classapi.use(bodyparser());

/**
 * @route post /classapi/getInfoByMajorId
 * @desc 根据专业给班级信息接口
 * @access 接口私有 只能管理员使用
 */
classapi.post('/getInfoByMajorId', koajwt({secret: secretOrKey}), async ctx => {
	let {admin,jurisdiction} = ctx.state.user;
	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {
		//查询所有学院信息
		let {majorId} = ctx.request.body;
		let sql = `SELECT classId,name  from tb_class where majorId='${majorId}';`
		let result = await query(sql)
		let list = [];
		result.forEach(item => {
			let obj = {
				key: item.classId,
				display_name: item.name
			}
			list.push(obj);
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
 * @route post /classapi/page
 * @desc 班级分页查寻信息接口
 * @access 接口私有 只能管理员使用
 */
classapi.post('/page', koajwt({secret: secretOrKey}), async ctx => {
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

		let sql =`SELECT a.classId,a.name,a.majorId,b.name as majorName,a.academyId,c.name as academyName,(SELECT COUNT(*) from tb_class)as count FROM tb_class a,tb_major b,tb_academy c WHERE a.majorId=b.majorId and a.academyId=c.academyId limit ${page},${pageSize};`
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
 * @route post /classapi/searchunion
 * @desc 班级搜索分页接口
 * @access 接口私有 只能管理员使用
 */
classapi.post('/searchunion', koajwt({
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

		if (isEmpty(page)) {
			ctx.body = {
				code: 400,
				msg: "参数错误"
			};

		} else {
			let symbolcheck = /[\u4e00-\u9fa5]+/g;

			let sql =`SELECT a.classId,a.name,a.majorId,b.name as majorName,a.academyId,c.name as academyName,(SELECT COUNT(*) from tb_class where classId LIKE '%${ searchValue }%' and academyId='${academyKey}')as count FROM tb_class a,tb_major b,tb_academy c WHERE a.majorId=b.majorId and a.academyId=c.academyId and a.classId LIKE '%${ searchValue }%' and c.academyId='${academyKey}' limit ${page},${pageSize};`;

			if (symbolcheck.test(searchValue)) {
				sql =`SELECT a.classId,a.name,a.majorId,b.name as majorName,a.academyId,c.name as academyName,(SELECT COUNT(*) from tb_class where name LIKE '%${ searchValue }%' and academyId='${academyKey}')as count FROM tb_class a,tb_major b,tb_academy c WHERE a.majorId=b.majorId and a.academyId=c.academyId and a.name LIKE '%${ searchValue }%' and c.academyId='${academyKey}' limit ${page},${pageSize};`
			}

			let result = await query(sql)
			let count;
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
 * @route post /classapi/search
 * @desc 班级搜索分页接口
 * @access 接口私有 只能管理员使用
 */
classapi.post('/search', koajwt({
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

		if (isEmpty(page)) {
			ctx.body = {
				code: 400,
				msg: "参数错误"
			};

		} else {
			
			let symbolcheck = /[\u4e00-\u9fa5]+/g;

			let sql =`SELECT a.classId,a.name,a.majorId,b.name as majorName,a.academyId,c.name as academyName ,(SELECT COUNT(*) from tb_class where classId LIKE '%${ searchValue }%')as count FROM tb_class a,tb_major b,tb_academy c WHERE a.majorId=b.majorId and a.academyId=c.academyId and a.classId LIKE '%${ searchValue }%' limit ${page},${pageSize};`;

			if (symbolcheck.test(searchValue)) {
				sql =`SELECT a.classId,a.name,a.majorId,b.name as majorName,a.academyId,c.name as academyName ,(SELECT COUNT(*) from tb_class where name LIKE '%${ searchValue }%')as count FROM tb_class a,tb_major b,tb_academy c WHERE a.majorId=b.majorId and a.academyId=c.academyId and a.name LIKE '%${ searchValue }%' limit ${page},${pageSize};`
			}

			let result = await query(sql)
			let count;
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
 * @route post /classapi/getAcademyByClassSeach
 * @desc 根据学院搜索学生分页接口
 * @access 接口私有 只能管理员使用
 */
classapi.post('/getAcademyByClassSeach', koajwt({
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

		if (isEmpty(page)) {

			ctx.body = {
				code: 400,
				msg: "参数错误"
			};

		} else {

			let sql =`SELECT a.classId,a.name,a.majorId,b.name as majorName,a.academyId,c.name as academyName ,(SELECT COUNT(*) from tb_class where academyId='${ academyKey }')as count FROM tb_class a,tb_major b,tb_academy c WHERE a.majorId=b.majorId and a.academyId=c.academyId and a.academyId='${ academyKey }' limit ${page},${pageSize};`

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
 * @route post /classapi/getLastClassByMajorId
 * @desc 根据专业查最后一个班级接口
 * @access 接口私有 只能管理员使用
 */
classapi.post('/getLastClassByMajorId', koajwt({
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

		let year = new Date();

		majorId = year.getFullYear() + majorId;

		let sql =` select classId from tb_class WHERE majorId='${majorId}' and classId like '${majorId}%' order by classId DESC limit 1;`;
		let result = await query(sql)

		if (result.length > 0) {
			let num = Number(result[0].classId) + 1
			ctx.body = {
				code: 200,
				data: num
			};

		} else {
			let acc = majorId + "01";
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
 * @route post /classapi/singleAdd
 * @desc 单个班级添加接口
 * @access 接口私有 只能管理员使用
 */
classapi.post('/singleAdd', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		classId,
		name,
		majorId,
		academyId
	} = ctx.request.body;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {

		let sql =`insert into tb_class(academyId,classId,majorId,name) value('${academyId}','${classId}','${majorId}','${name}');`;
		let result = await query(sql)
		if (result.affectedRows > 0) {
			ctx.body = {
				code: 200,
				msg: "添加成功"
			};
		} else {
			ctx.body = {
				code: 400,
				msg: '班级已存在'
			};
		}

	} else {
		ctx.body = returnDat.msg;
	}
})


/**
 * @route post /classapi/updata
 * @desc 单个班级修改接口
 * @access 接口私有 只能管理员使用
 */
classapi.post('/updata', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		classId,
		name,
		majorId,
		academyId
	} = ctx.request.body;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {
		let sql =`UPDATE tb_class set classId='${classId}',academyId='${academyId}',majorId='${majorId}',name='${name}' where classId='${classId}'`;

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
 * @route post /classapi/singleDel
 * @desc 单个班级删除接口
 * @access 接口私有 只能管理员使用
 */
classapi.post('/singleDel', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		classId
	} = ctx.request.body;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {

			let sql =`DELETE from tb_class where classId='${classId}';`;
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





module.exports = classapi;
