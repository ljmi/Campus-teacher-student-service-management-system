const Router = require("koa-router")
const student = new Router()
const bodyparser = require('koa-bodyparser')
const { query } = require('../utils/db.js')
const {format} = require('silly-datetime')
const {secretOrKey} = require('../utils/key.js')
const {checkAdmin} = require('../utils/check.js')
const koajwt = require('koa-jwt')
const {enbcrypt} = require('../utils/tool.js')
const {isEmpty,isNotEmpty} = require('../utils/valueCheck.js')

student.use(bodyparser());


/**
 * @route post /student/singleAdd
 * @desc 单个学生添加接口
 * @access 接口私有 只能管理员使用
 */
student.post('/singleAdd', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		academyId,
		account,
		address,
		classId,
		headImg,
		mail,
		majorId,
		name,
		phone,
		sex,
		password
	} = ctx.request.body;
	let createTime = format(new Date(), 'YYYY-MM-DD HH:mm:ss');

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {

			if (isEmpty(password)) {
				password = "123456"
			}

			password = enbcrypt(password)
			let sql =`insert into tb_student(academyId,account,address,classId,headImg,mail,majorId,name,phone,sex,password,createTime) value('${academyId}','${account}','${address}','${classId}','${headImg}','${mail}','${majorId}','${name}','${phone}','${sex}','${password}','${createTime}');`;
			let result = await query(sql)
			if (result.affectedRows > 0) {
				ctx.body = {
					code: 200,
					msg: "添加成功"
				};
			} else {
				ctx.body = {
					code: 400,
					msg: '学生已存在'
				};
			}
		

	} else {
		ctx.body = returnDat.msg;
	}
})

/**
 * @route post /student/batchAddStudent
 * @desc 学生批量添加接口
 * @access 接口私有 只能管理员使用
 */
student.post('/batchAddStudent', koajwt({
	secret: secretOrKey
}), async ctx => {

	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {

		let bodyArr = ctx.request.body
		let createTime = format(new Date(), 'YYYY-MM-DD HH:mm:ss')
		let password= enbcrypt("123456")
		let sql ='insert into  tb_student(academyId,account,classId,majorId,name,sex,password,createTime) values '
		const values = bodyArr.map(item=>{
			`('${item.academyId}','${item.account}','${item.classId}','${item.majorId}','${item.name}','${item.sex}','${password}','${createTime}') `
		})
		sql += values

		let result = await query(sql)
		if (result.affectedRows > 0) {

			ctx.body = {
				code: 200,
				msg: '批量添加成功'
			};

		} else {
			ctx.body = {
				code: 400,
				msg: '批量添加失败'
			};
		}

	} else {
		ctx.body = returnDat.msg;
	}


})


/**
 * @route post /student/page
 * @desc 学生分页查寻信息接口
 * @access 接口私有 只能管理员使用
 */
student.post('/page', koajwt({
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

		let sql =`select b.studentId,b.account,b.name,b.sex,b.classId,a.name as className,b.majorId,c.name as majorName,b.academyId,d.name as academyName,b.phone,b.headImg,b.mail,b.address,(SELECT COUNT(*) from tb_student)as count from tb_class a,tb_student b,tb_major c,tb_academy d where a.classId=b.classId and c.majorId=b.majorId and d.academyId=b.academyId limit ${page},${pageSize};`
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
 * @route post /student/search
 * @desc 学生搜索分页接口
 * @access 接口私有 只能管理员使用
 */
student.post('/search', koajwt({
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

			let sql =`select b.studentId,b.account,b.name,b.sex,b.classId,a.name as className,b.majorId,c.name as majorName,b.academyId,d.name as academyName,b.phone,b.headImg,b.mail,b.address,(SELECT COUNT(*) from tb_student where account LIKE '%${searchValue}%')as count from tb_class a,tb_student b,tb_major c,tb_academy d where a.classId=b.classId and c.majorId=b.majorId and d.academyId=b.academyId and b.account LIKE '%${searchValue}%' limit ${page},${pageSize};`

			if (symbolcheck.test(searchValue)) {
				sql =`select b.studentId,b.account,b.name,b.sex,b.classId,a.name as className,b.majorId,c.name as majorName,b.academyId,d.name as academyName,b.phone,b.headImg,b.mail,b.address,(SELECT COUNT(*) from tb_student where name LIKE '%${searchValue}%')as count from tb_class a,tb_student b,tb_major c,tb_academy d where a.classId=b.classId and c.majorId=b.majorId and d.academyId=b.academyId and b.name LIKE '%${searchValue}%' limit ${page},${pageSize};`
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
 * @route post /student/searchunion
 * @desc 学生搜索分页接口
 * @access 接口私有 只能管理员使用
 */
student.post('/searchunion', koajwt({
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

			let sql =`select b.studentId,b.account,b.password,b.name,b.sex,b.classId,a.name as className,b.majorId,c.name as majorName,b.academyId,d.name as academyName,b.phone,b.headImg,b.mail,b.address,(select COUNT(*) from tb_student where account LIKE '%${searchValue}%' and academyId='${academyKey}') as count from tb_class a,tb_student b,tb_major c,tb_academy d where a.classId=b.classId and c.majorId=b.majorId and d.academyId=b.academyId and b.account LIKE '%${searchValue}%' and b.academyId='${academyKey}' limit ${page},${pageSize};`

			if (symbolcheck.test(searchValue)) {
				sql =`select b.studentId,b.account,b.password,b.name,b.sex,b.classId,a.name as className,b.majorId,c.name as majorName,b.academyId,d.name as academyName,b.phone,b.headImg,b.mail,b.address,(select COUNT(*) from tb_student where account LIKE '%${searchValue}%' and academyId='${academyKey}') as count from tb_class a,tb_student b,tb_major c,tb_academy d where a.classId=b.classId and c.majorId=b.majorId and d.academyId=b.academyId and b.name LIKE '%${searchValue}%' and b.academyId='${academyKey}' limit ${page},${pageSize};`
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
 * @route post /student/updata
 * @desc 单个学生修改接口
 * @access 接口私有 只能管理员使用
 */
student.post('/updata', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		academyId,
		address,
		classId,
		headImg,
		mail,
		majorId,
		name,
		phone,
		sex,
		studentId,
		password
	} = ctx.request.body;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {
		let sql
		if (isEmpty(password)) {
			sql =`UPDATE tb_student set mail='${mail}',headImg='${headImg}',classId='${classId}',address='${address}',academyId='${academyId}',majorId='${majorId}',name='${name}',phone='${phone}',sex='${sex}' where studentId='${studentId}'`
		} else {
			password = enbcrypt(password)
			sql =`UPDATE tb_student set password='${password}',mail='${mail}',headImg='${headImg}',classId='${classId}',address='${address}',academyId='${academyId}',majorId='${majorId}',name='${name}',phone='${phone}',sex='${sex}' where studentId='${studentId}'`
		}

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
 * @route post /student/singleDel
 * @desc 单个学生删除接口
 * @access 接口私有 只能管理员使用
 */
student.post('/singleDel', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		studentId
	} = ctx.request.body;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {

			let sql =`DELETE from tb_student where studentId='${studentId}';`
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
 * @route post /student/updataHeadImg
 * @desc 单个学生修改接口
 * @access 接口私有 只能管理员使用
 */
student.post('/updataHeadImg', koajwt({
	secret: secretOrKey
}), async ctx => {

	let {
		headImg,
		account
	} = ctx.request.body;

		let sql =`UPDATE tb_student set headImg='${headImg}' where account='${account}'`

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
})


/**
 * @route post /student/getLastStudentByClassId
 * @desc 根据班级查最后一个学生接口
 * @access 接口私有 只能管理员使用
 */
student.post('/getLastStudentByClassId', koajwt({
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

		let sql =` select account from tb_student WHERE classId='${classId}' order by studentId DESC limit 1;`
		let result = await query(sql)

		if (result.length > 0) {
			let num = Number(result[0].account) + 1
			ctx.body = {
				code: 200,
				data: num
			};

		} else {
			let acc = classId + "01"
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
 * @route post /student/getAcademyByStudentSeach
 * @desc 根据学院搜索学生分页接口
 * @access 接口私有 只能管理员使用
 */
student.post('/getAcademyByStudentSeach', koajwt({
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

			let sql =`select b.studentId,b.account,b.name,b.sex,b.classId,a.name as className,b.majorId,c.name as majorName,b.academyId,d.name as academyName,b.phone,b.headImg,b.mail,b.address,(select COUNT(*) from tb_student where academyId='${academyKey}') as count from tb_class a,tb_student b,tb_major c,tb_academy d where a.classId=b.classId and c.majorId=b.majorId and d.academyId=b.academyId and b.academyId='${academyKey}' limit ${page},${pageSize};`


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
 * @route post /student/info
 * @desc 学生信息接口
 * @access 接口私有
 */
student.post('/info', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		account
	} = ctx.request.body;


	if (isEmpty(account)) {
		ctx.body = {
			code: 400,
			msg: "参数错误"
		}

	} else {

		let sql =`SELECT a.studentId,a.account,a.name,a.headImg,a.mail,a.address,a.sex,a.classId,b.name as className,a.phone,a.loginTime,a.majorId,c.name as majorName,a.academyId,d.name as academyName FROM tb_student a,tb_class b,tb_major c,tb_academy d WHERE a.classId=b.classId and a.majorId=c.majorId and a.academyId=d.academyId and a.account='${account}'`

		let result = await query(sql)
		ctx.body = {
			code: 200,
			data: result
		}
	}
})

/**
 * @route post /student/getleaveinfoBystudent
 * @desc 学生请假信息接口
 * @access 接口私有
 */
student.post('/getleaveinfoBystudent', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		account
	} = ctx.request.body;


	if (isEmpty(account)) {
		ctx.body = {
			code: 400,
			msg: "参数错误"
		}

	} else {
		let sql =`SELECT a.leaveId,a.account,a.name,a.classId,b.name as className,a.majorId,c.name as majorName,a.academyId,d.name as academyName,a.reason,a.startTime,a.endTime,a.type,a.address,a.contacts,a.phone,a.teacherAccount,a.region,a.instructor,a.academy,a.state,a.createTime FROM tb_leave a,tb_class b,tb_major c,tb_academy d WHERE a.classId=b.classId and a.majorId=c.majorId and a.academyId=d.academyId and a.account='${account}'`
		let result = await query(sql)
		ctx.body = {
			code: 200,
			data: result
		}
	}
})

/**
 * @route post /student/gethealthyinfoBystudent
 * @desc 学生健康表信息接口
 * @access 接口私有
 */
student.post('/gethealthyinfoBystudent', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		account
	} = ctx.request.body;


	if (isEmpty(account)) {
		ctx.body ={
			code: 400,
			msg: "参数错误"
		}

	} else {

		let sql =`SELECT time FROM tb_healthy WHERE account='${account}'`

		let result = await query(sql)
		let list = []
				result.forEach(item => {
					let obj = {
						date: item.time,
						info: '已打卡',
						stat: true
					}
					list.push(obj)
				})
		ctx.body = {
			code: 200,
			data: list
		}
	}
})


/**
 * @route post /student/gethealthyListBystudent
 * @desc 学生健康表列表信息接口
 * @access 接口私有
 */
student.post('/gethealthyListBystudent', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		account
	} = ctx.request.body;


	if (isEmpty(account)) {
		ctx.body = {
			code: 400,
			msg: "参数错误"
		}

	} else {

		let sql =`SELECT * FROM tb_healthy WHERE account='${account}'`

		let result = await query(sql)
		ctx.body = {
			code: 200,
			data: result
		}
	}
})







module.exports = student;
