const Router = require("koa-router")
const leave = new Router()
const bodyparser = require('koa-bodyparser')
const {query} = require('../utils/db.js')
const {format} = require('silly-datetime')
const {secretOrKey} = require('../utils/key.js')
const {checkAdmin} = require('../utils/check.js')
const koajwt = require('koa-jwt')
const {isEmpty} = require('../utils/valueCheck.js')

leave.use(bodyparser());


/**
 * @route post /leave/add
 * @desc 请假添加接口
 * @access 接口私有
 */
leave.post('/add', koajwt({
	secret: secretOrKey
}), async ctx => {

	let {
		account,
		name,
		classId,
		majorId,
		academyId,
		reason,
		startTime,
		endTime,
		type,
		address,
		contacts,
		phone,
		teacherAccount,
		region
	} = ctx.request.body;
	let createTime = format(new Date(), 'YYYY-MM-DD HH:mm:ss');
	var sql =`insert into tb_leave(teacherAccount,type,endTime,startTime,reason,academyId,account,classId,majorId,name,createTime) value('${teacherAccount}','${type}','${endTime}','${startTime}','${reason}','${academyId}','${account}','${classId}','${majorId}','${name}','${createTime}');`
	if (type == '外出') {
		sql =`insert into tb_leave(region,teacherAccount,contacts,type,endTime,startTime,reason,academyId,account,address,classId,majorId,name,phone,createTime) value('${region}','${teacherAccount}','${contacts}','${type}','${endTime}','${startTime}','${reason}','${academyId}','${account}','${address}','${classId}','${majorId}','${name}','${phone}','${createTime}');`
	}


	let result = await query(sql)
	if (result.affectedRows > 0) {
		ctx.body = {
			code: 200,
			msg: "提交成功"
		};
	} else {
		ctx.body = {
			code: 400,
			msg: '提交失败'
		};
	}
})


/**
 * @route post /leave/updata
 * @desc 请假修改接口
 * @access 接口私有
 */
leave.post('/updata', koajwt({
	secret: secretOrKey
}), async ctx => {

	let {
		account,
		name,
		classId,
		majorId,
		academyId,
		reason,
		startTime,
		endTime,
		type,
		address,
		contacts,
		phone,
		teacherAccount,
		region,
		leaveId
	} = ctx.request.body;

	let sql =`UPDATE tb_leave set region='${region}',teacherAccount='${teacherAccount}',contacts='${contacts}',type='${type}',endTime='${endTime}',startTime='${startTime}',reason='${reason}',academyId='${academyId}',account='${account}',address='${address}',classId='${classId}',majorId='${majorId}',name='${name}',phone='${phone}' where leaveId='${leaveId}'`;


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
 * @route post /leave/leaveInfo
 * @desc 请假信息接口
 * @access 接口私有
 */
leave.post('/leaveInfo', koajwt({
	secret: secretOrKey
}), async ctx => {

	let {
		leaveId
	} = ctx.request.body;

	let sql =`select a.leaveId,a.account,a.name,a.classId,b.name as className,a.majorId,c.name as majorName,a.academyId,d.name as academyName,a.reason,a.startTime,a.endTime,a.type,a.address,a.contacts,a.phone,a.createTime,a.teacherAccount,a.region,a.instructor,a.academy,a.state from tb_leave a,tb_class b,tb_major c,tb_academy d where a.classId=b.classId and a.majorId=c.majorId and a.academyId=d.academyId and leaveId='${leaveId}';`;


	let result = await query(sql)
	ctx.body = {
		code: 200,
		data: result
	}
})


/**
 * @route post /leave/page
 * @desc 学生分页查寻信息接口
 * @access 接口私有 只能管理员使用
 */
leave.post('/page', koajwt({
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

		let sql =`SELECT a.leaveId,a.account,a.name,a.classId,b.name as className,a.majorId,c.name as majorName,a.academyId,d.name as academyName,a.reason,a.startTime,a.endTime,a.type,a.address,a.contacts,a.phone,a.createTime,a.teacherAccount,e.name as teacherName,a.region,a.instructor,a.academy,a.state,(SELECT COUNT(*) from tb_leave)as count FROM tb_leave a,tb_class b,tb_major c,tb_academy d,tb_teacher e WHERE a.classId=b.classId and a.majorId=c.majorId and a.academyId=d.academyId and a.teacherAccount=e.account limit ${page},${pageSize};`
			
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
 * @route post /leave/search
 * @desc 请假搜索分页接口
 * @access 接口私有 只能管理员使用
 */
leave.post('/search', koajwt({
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

			var sql =`SELECT a.leaveId,a.account,a.name,a.classId,b.name as className,a.majorId,c.name as majorName,a.academyId,d.name as academyName,a.reason,a.startTime,a.endTime,a.type,a.address,a.contacts,a.phone,a.createTime,a.teacherAccount,e.name as teacherName,a.region,a.instructor,a.academy,a.state,(SELECT COUNT(*) from tb_leave where account LIKE '%${ searchValue }%')as count FROM tb_leave a,tb_class b,tb_major c,tb_academy d,tb_teacher e WHERE a.classId=b.classId and a.majorId=c.majorId and a.academyId=d.academyId and a.teacherAccount=e.account and a.account LIKE '%${ searchValue }%' limit ${page},${pageSize};`

			if (symbolcheck.test(searchValue)) {
				sql =`SELECT a.leaveId,a.account,a.name,a.classId,b.name as className,a.majorId,c.name as majorName,a.academyId,d.name as academyName,a.reason,a.startTime,a.endTime,a.type,a.address,a.contacts,a.phone,a.createTime,a.teacherAccount,e.name as teacherName,a.region,a.instructor,a.academy,a.state,(SELECT COUNT(*) from tb_leave where account LIKE '%${ searchValue }%')as count FROM tb_leave a,tb_class b,tb_major c,tb_academy d,tb_teacher e WHERE a.classId=b.classId and a.majorId=c.majorId and a.academyId=d.academyId and a.teacherAccount=e.account and a.name LIKE '%${ searchValue }%' limit ${page},${pageSize};`
			}

			let result = await query(sql)
			var count
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
 * @route post /leave/searchunion
 * @desc 请假搜索分页接口
 * @access 接口私有 只能管理员使用
 */
leave.post('/searchunion', koajwt({
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

			let sql =`SELECT a.leaveId,a.account,a.name,a.classId,b.name as className,a.majorId,c.name as majorName,a.academyId,d.name as academyName,a.reason,a.startTime,a.endTime,a.type,a.address,a.contacts,a.phone,a.createTime,a.teacherAccount,e.name as teacherName,a.region,a.instructor,a.academy,a.state,(SELECT COUNT(*) from tb_leave where account LIKE '%${ searchValue }%' and academyId='${academyKey}')as count FROM tb_leave a,tb_class b,tb_major c,tb_academy d,tb_teacher e WHERE a.classId=b.classId and a.majorId=c.majorId and a.academyId=d.academyId and a.teacherAccount=e.account and a.account LIKE '%${ searchValue }%' and a.academyId='${academyKey}' limit ${page},${pageSize};`

			if (symbolcheck.test(searchValue)) {
				sql =`SELECT a.leaveId,a.account,a.name,a.classId,b.name as className,a.majorId,c.name as majorName,a.academyId,d.name as academyName,a.reason,a.startTime,a.endTime,a.type,a.address,a.contacts,a.phone,a.createTime,a.teacherAccount,e.name as teacherName,a.region,a.instructor,a.academy,a.state,(SELECT COUNT(*) from tb_leave where account LIKE '%${ searchValue }%' and academyId='${academyKey}')as count FROM tb_leave a,tb_class b,tb_major c,tb_academy d,tb_teacher e WHERE a.classId=b.classId and a.majorId=c.majorId and a.academyId=d.academyId and a.teacherAccount=e.account and a.name LIKE '%${ searchValue }%' and a.academyId='${academyKey}' limit ${page},${pageSize};`
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
 * @route post /leave/getAcademyBylLeaveSeach
 * @desc 根据学院搜索请假分页接口
 * @access 接口私有 只能管理员使用
 */
leave.post('/getAcademyBylLeaveSeach', koajwt({
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

			let sql =`SELECT a.leaveId,a.account,a.name,a.classId,b.name as className,a.majorId,c.name as majorName,a.academyId,d.name as academyName,a.reason,a.startTime,a.endTime,a.type,a.address,a.contacts,a.phone,a.createTime,a.teacherAccount,e.name as teacherName,a.region,a.instructor,a.academy,a.state,(SELECT COUNT(*) from tb_leave where academyId='${ academyKey }')as count FROM tb_leave a,tb_class b,tb_major c,tb_academy d,tb_teacher e WHERE a.classId=b.classId and a.majorId=c.majorId and a.academyId=d.academyId and a.teacherAccount=e.account and a.academyId='${ academyKey }' limit ${page},${pageSize};`

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
 * @route post /leave/getWekeOutsize
 * @desc 外出请假人数接口
 * @access 接口私有
 */
leave.post('/getWekeOutsize', koajwt({
	secret: secretOrKey
}), async ctx => {

	let {
		time,value
	} = ctx.request.body;

	let sql=`SELECT base.date,IFNULL(daily_new,0) daily_new FROM ( SELECT DATE( DATE_SUB( '${time}', INTERVAL @s := @s + 1 DAY ) ) AS date  FROM mysql.help_topic, ( SELECT @s := - 1 ) temp  WHERE @s < 6  ORDER BY date ) base left join ( SELECT count(*) daily_new, DATE_FORMAT(createTime,'%Y-%m-%d') as time from tb_leave  WHERE type='外出' GROUP BY time ) res on base.date = res.time ORDER BY base.date;`
	if(value==2){
		sql=`SELECT base.date,IFNULL(daily_new,0) daily_new FROM ( SELECT DATE( DATE_SUB( '${time}', INTERVAL @s := @s + 1 DAY ) ) AS date  FROM mysql.help_topic, ( SELECT @s := - 1 ) temp  WHERE @s < 29  ORDER BY date ) base left join ( SELECT count(*) daily_new, DATE_FORMAT(createTime,'%Y-%m-%d') as time from tb_leave  WHERE type='外出' GROUP BY time ) res on base.date = res.time ORDER BY base.date;`
	}

	let result = await query(sql)
	ctx.body = {
		code: 200,
		data: result
	}
})

/**
 * @route post /leave/getWekeInsize
 * @desc 非外出请假人数接口
 * @access 接口私有
 */
leave.post('/getWekeInsize', koajwt({
	secret: secretOrKey
}), async ctx => {

	let {
		time,value
	} = ctx.request.body;

	let sql=`SELECT base.date,IFNULL(daily_new,0) daily_new FROM ( SELECT DATE( DATE_SUB( '${time}', INTERVAL @s := @s + 1 DAY ) ) AS date  FROM mysql.help_topic, ( SELECT @s := - 1 ) temp  WHERE @s < 6  ORDER BY date ) base left join ( SELECT count(*) daily_new, DATE_FORMAT(createTime,'%Y-%m-%d') as time from tb_leave  WHERE type!='外出' GROUP BY time ) res on base.date = res.time ORDER BY base.date;`
	if(value==2){
		sql=`SELECT base.date,IFNULL(daily_new,0) daily_new FROM ( SELECT DATE( DATE_SUB( '${time}', INTERVAL @s := @s + 1 DAY ) ) AS date  FROM mysql.help_topic, ( SELECT @s := - 1 ) temp  WHERE @s < 29  ORDER BY date ) base left join ( SELECT count(*) daily_new, DATE_FORMAT(createTime,'%Y-%m-%d') as time from tb_leave  WHERE type!='外出' GROUP BY time ) res on base.date = res.time ORDER BY base.date;`
	}


	let result = await query(sql)
	ctx.body = {
		code: 200,
		data: result
	}
})


/**
 * @route post /leave/getWekeInsizeCount
 * @desc 最近一周非外出请假人数汇总接口
 * @access 接口私有
 */
leave.post('/getWekeInsizeCount', koajwt({
	secret: secretOrKey
}), async ctx => {

	let {
		time
	} = ctx.request.body;

	let sql =`SELECT base.date,IFNULL(daily_new,0) daily_new FROM ( SELECT DATE( DATE_SUB( '${time}', INTERVAL @s := @s + 1 DAY ) ) AS date  FROM mysql.help_topic, ( SELECT @s := - 1 ) temp  WHERE @s < 6  ORDER BY date ) base left join ( SELECT count(*) daily_new, DATE_FORMAT(createTime,'%Y-%m-%d') as time from tb_leave  WHERE type!='外出' GROUP BY time ) res on base.date = res.time ORDER BY base.date;`;


	let result = await query(sql)
	ctx.body = {
		code: 200,
		data: result
	}
})

/**
 * @route post /leave/getWekeCount
 * @desc 请假和填表人数汇总接口
 * @access 接口私有
 */
leave.post('/getWekeCount', koajwt({
	secret: secretOrKey
}), async ctx => {
	
	let {
		value
	} = ctx.request.body;

	let sql =`select (select COUNT(type) from tb_leave where date_sub(curdate(), interval 7 day) <= date(createTime) and type='外出') as outSizeCount,(select COUNT(type) from tb_leave where date_sub(curdate(), interval 7 day) <= date(createTime) and type!='外出') as inSizeCount,(select COUNT(createTime) from tb_healthy where date_sub(curdate(), interval 7 day) <= date(createTime)) as healthyCount from tb_leave,tb_healthy LIMIT 1;`
	if(value==2){
		sql =`select (select COUNT(type) from tb_leave where date_sub(curdate(), interval 29 day) <= date(createTime) and type='外出') as outSizeCount,(select COUNT(type) from tb_leave where date_sub(curdate(), interval 29 day) <= date(createTime) and type!='外出') as inSizeCount,(select COUNT(createTime) from tb_healthy where date_sub(curdate(), interval 29 day) <= date(createTime)) as healthyCount from tb_leave,tb_healthy LIMIT 1;`
	}
		
	let result = await query(sql)
	ctx.body = {
		code: 200,
		data: result
	}
})





module.exports = leave;
