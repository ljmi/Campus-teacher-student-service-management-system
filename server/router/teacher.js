const Router = require("koa-router")
const teacher = new Router()
const bodyparser = require('koa-bodyparser')
const {query} = require('../utils/db.js')
const {format} = require('silly-datetime')
const {enbcrypt} = require('../utils/tool.js')
const {secretOrKey} = require('../utils/key.js')
const {checkAdmin} = require('../utils/check.js')
const koajwt = require('koa-jwt')
const {isEmpty} = require('../utils/valueCheck.js')

teacher.use(bodyparser());

/**
 * @route post /teacher/getLastTeacherByAcademyId
 * @desc 根据学院查最后一个教职工接口
 * @access 接口私有 只能管理员使用
 */
teacher.post('/getLastTeacherByAcademyId', koajwt({
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
		if(isEmpty(academyId)){
			ctx.body = {
				code: 400,
				msg:"参数错误"
			};
		}else{
			let sql =` select account from tb_teacher WHERE academyId='${academyId}' order by teacherId DESC limit 1;`
			let result = await query(sql)
			
			if (result.length > 0) {
				let num = Number(result[0].account) + 1
				ctx.body = {
					code: 200,
					data: num
				};
			
			} else {
				var d = new Date()
				let year = d.getFullYear()
				let acc = year+academyId+"0001"
				ctx.body = {
					code: 200,
					data: acc
				};
			}
		}

		

	} else {
		ctx.body = returnDat.msg;
	}
})

/**
 * @route post /teacher/singleAdd
 * @desc 单个教职工添加接口
 * @access 接口私有 只能管理员使用
 */
teacher.post('/singleAdd', koajwt({
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
		name,
		phone,
		sex,
		password,
		classString
	} = ctx.request.body;
	

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {

			if(isEmpty(password)){
				password=enbcrypt("123456")
			}
			let createTime = format(new Date(), 'YYYY-MM-DD HH:mm:ss')
			let sql =`insert into tb_teacher(academyId,account,address,classId,headImg,mail,name,phone,sex,password,createTime) value('${academyId}','${account}','${address}','${classString}','${headImg}','${mail}','${name}','${phone}','${sex}','${password}','${createTime}');`
			let result = await query(sql)
			if (result.affectedRows > 0) {
				ctx.body = {
					code: 200,
					msg: "添加成功"
				}
			} else {
				ctx.body = {
					code: 400,
					msg: '教师已存在'
				}
			}
				
		

	} else {
		ctx.body = returnDat.msg;
	}
})


/**
 * @route post /teacher/page
 * @desc 教职工分页查寻信息接口
 * @access 接口私有 只能管理员使用
 */
teacher.post('/page', koajwt({
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

		let sql =`select a.teacherId,a.account,a.name,a.headImg,a.mail,a.address,a.sex,a.classId,a.phone,a.academyId,b.name as academyName,a.type,(SELECT COUNT(*) from tb_teacher)as count from tb_teacher a,tb_academy b WHERE a.academyId=b.academyId limit ${page},${pageSize};`
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
 * @route post /teacher/singleDel
 * @desc 单个教职工删除接口
 * @access 接口私有 只能管理员使用
 */
teacher.post('/singleDel', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		teacherId
	} = ctx.request.body;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {

			let sql =
				`DELETE from tb_teacher where teacherId='${teacherId}';`
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
 * @route post /teacher/search
 * @desc 教职工搜索分页接口
 * @access 接口私有 只能管理员使用
 */
teacher.post('/search', koajwt({
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

			let sql =`select a.teacherId,a.account,a.name,a.headImg,a.mail,a.address,a.sex,a.classId,a.phone,a.academyId,b.name as academyName,a.type,(SELECT COUNT(*) from tb_teacher where account LIKE '%${ searchValue }%')as count from tb_teacher a,tb_academy b where a.academyId=b.academyId and a.account LIKE '%${ searchValue }%' limit ${page},${pageSize};`

			if (symbolcheck.test(searchValue)) {
				sql =`select a.teacherId,a.account,a.name,a.headImg,a.mail,a.address,a.sex,a.classId,a.phone,a.academyId,b.name as academyName,a.type,(SELECT COUNT(*) from tb_teacher where name LIKE '%${ searchValue }%')as count from tb_teacher a,tb_academy b where a.academyId=b.academyId and a.name LIKE '%${ searchValue }%' limit ${page},${pageSize};`
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
 * @route post /teacher/searchunion
 * @desc 教职工搜索分页接口
 * @access 接口私有 只能管理员使用
 */
teacher.post('/searchunion', koajwt({
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

			let sql =`select a.teacherId,a.account,a.name,a.headImg,a.mail,a.address,a.sex,a.classId,a.phone,a.type,a.academyId,b.name as academyName from tb_teacher a,tb_academy b where a.academyId=b.academyId and a.account LIKE '%${ searchValue }%' and a.academyId='${academyKey}' limit ${page},${pageSize};`
			if (symbolcheck.test(searchValue)) {
				sql =`select a.teacherId,a.account,a.name,a.headImg,a.mail,a.address,a.sex,a.classId,a.phone,a.type,a.academyId,b.name as academyName from tb_teacher a,tb_academy b where a.academyId=b.academyId and a.name LIKE '%${ searchValue }%' and a.academyId='${academyKey}' limit ${page},${pageSize};`
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
 * @route post /teacher/getAcademyByTeacherSeach
 * @desc 根据学院搜索教职工分页接口
 * @access 接口私有 只能管理员使用
 */
teacher.post('/getAcademyByTeacherSeach', koajwt({
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
			let sql =`select a.teacherId,a.account,a.name,a.headImg,a.mail,a.address,a.sex,a.classId,a.phone,a.type,a.academyId,b.name as academyName,(select COUNT(*) from tb_teacher where academyId='${ academyKey }')as count from tb_teacher a,tb_academy b where a.academyId=b.academyId and a.academyId='${ academyKey }' limit ${page},${pageSize};`
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
 * @route post /teacher/updata
 * @desc 单个教职工修改接口
 * @access 接口私有 只能管理员使用
 */
teacher.post('/updata', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		academyId,
		address,
		headImg,
		mail,
		name,
		phone,
		sex,
		teacherId,
		password,
		type,
		classString
	} = ctx.request.body;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {
		let sql
		if (isEmpty(password)) {
			sql =`UPDATE tb_teacher set mail='${mail}',headImg='${headImg}',address='${address}',academyId='${academyId}',name='${name}',type='${type}',phone='${phone}',sex='${sex}',classId='${classString}' where teacherId='${teacherId}';`;
		} else {
			password = enbcrypt(password)
			sql =`UPDATE tb_teacher set password='${password}',mail='${mail}',headImg='${headImg}',address='${address}',type='${type}',academyId='${academyId}',name='${name}',phone='${phone}',sex='${sex}',classId='${classString}' where teacherId='${teacherId}';`;
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
 * @route post /teacher/batchAddTeacher
 * @desc 教职工批量添加接口
 * @access 接口私有 只能管理员使用
 */
teacher.post('/batchAddTeacher', koajwt({
	secret: secretOrKey
}), async ctx => {

	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {

		let bodyArr = ctx.request.body

		let insertSql =`insert into tb_teacher(academyId,account,name,sex,password,createTime,type) value`
		const values = bodyArr.map(item=>{
			`('${item.academyId}','${item.account}','${item.name}','${item.sex}','${password}','${createTime}','${type}') `
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
 * @route post /teacher/cascade
 * @desc 教职工分院信息接口
 * @access 接口私有
 */
teacher.post('/cascade', koajwt({
	secret: secretOrKey
}), async ctx => {
	//查询所有学院信息
	let sql = `SELECT academyId,name  from tb_academy;`
	let result = await query(sql)

	//查询所有教师信息
	let sql1 = `SELECT account,name  from tb_teacher;`
	let result1 = await query(sql1)


	var list = []

	for (var i = 0; i < result.length; i++) {
		list.push({
			value: result[i].academyId,
			label: result[i].name,
			children: []
		})

	}

	for (var u = 0; u < list.length; u++) {
		for (var j = 0; j < result1.length; j++) {
			if (list[u].value == result1[j].academyId) {
				list[u].children.push({
					value: result1[j].account,
					label: result1[j].name
				})
			}
		}
	}

	ctx.body = {
		code: 200,
		data: list
	}

})


/**
 * @route post /teacher/info
 * @desc 教职工信息接口
 * @access 接口私有
 */
teacher.post('/info', koajwt({
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

		let sql =`SELECT a.teacherId,a.account,a.name,a.headImg,a.mail,a.address,a.sex,a.classId,a.phone,a.loginTime,a.academyId,a.type,d.name as academyName FROM tb_teacher a,tb_academy d WHERE  a.academyId=d.academyId and a.account='${account}'`

		let result = await query(sql)
		ctx.body = {
			code: 200,
			data: result
		}
	}
})


/**
 * @route post /teacher/getLeaveByTeacherId
 * @desc 教职工收取请假信息接口
 * @access 接口私有
 */
teacher.post('/getLeaveByTeacherId', koajwt({
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

		let sql =`select a.leaveId,a.account,a.name,a.classId,b.name as className,a.majorId,c.name as majorName,a.academy,d.name as academyName,a.reason,a.startTime,a.endTime,a.type,a.address,a.contacts,a.phone,a.createTime,a.region,a.instructor,a.academy,a.state from tb_leave a,tb_class b,tb_major c,tb_academy d  WHERE a.classId=b.classId and a.majorId=c.majorId and a.academyId=d.academyId and a.state='已通过' and a.teacherAccount='${account}'`

		let result = await query(sql)
		ctx.body = {
			code: 200,
			data: result
		}
	}
})


/**
 * @route post /teacher/getLeaveByclassIdFor
 * @desc 辅导员收取请假信息接口
 * @access 接口私有
 */
teacher.post('/getLeaveByclassIdFor', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		classId
	} = ctx.request.body;


	if (isEmpty(classId)) {
		ctx.body = {
			code: 400,
			msg: "参数错误"
		}

	} else {
		let classIdlist,list=[]
		classIdlist=classId.split(',')
		if(classIdlist.length>0){
			for(let i=0;i<classIdlist.length;i++){
				let sql =`select a.leaveId,a.account,a.name,a.classId,b.name as className,a.majorId,c.name as majorName,a.academyId,d.name as academyName,a.reason,a.startTime,a.endTime,a.type,a.address,a.contacts,a.phone,a.createTime,a.region,a.instructor,a.academy,a.state from tb_leave a,tb_class b,tb_major c,tb_academy d  WHERE a.classId=b.classId and a.majorId=c.majorId and a.academyId=d.academyId and a.classId=${classIdlist[i]};`
				
				let result = await query(sql)
				result.forEach(item=>{
					list.push(item)
				})
				
			}
		}
		
		ctx.body = {
			code: 200,
			data: list
		}
	}
})


/**
 * @route post /teacher/approval
 * @desc 请假批准接口
 * @access 接口私有
 */
teacher.post('/approval', koajwt({
	secret: secretOrKey
}), async ctx => {

	let {
		state,
		leaveId
	} = ctx.request.body;

	let sql =`UPDATE tb_leave set state='${state}' where leaveId='${leaveId}'`
	let result = await query(sql)
	if (result.affectedRows > 0) {
		ctx.body = {
			code: 200,
			msg: "审批成功"
		};
	} else {
		ctx.body = {
			code: 400,
			msg: '审批失败'
		};
	}
})

/**
 * @route post /teacher/updataHeadImg
 * @desc 单个学生修改接口
 * @access 接口私有 只能管理员使用
 */
teacher.post('/updataHeadImg', koajwt({
	secret: secretOrKey
}), async ctx => {

	let {
		headImg,
		account
	} = ctx.request.body;

			let sql =`UPDATE tb_teacher set headImg='${headImg}' where account='${account}'`

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





module.exports = teacher;
