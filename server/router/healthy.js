const Router = require("koa-router")
const healthy = new Router()
const bodyparser = require('koa-bodyparser')
const {query} = require('../utils/db.js')
const {format} = require('silly-datetime')
const {secretOrKey} = require('../utils/key.js')
const {checkAdmin} = require('../utils/check.js')
const koajwt = require('koa-jwt')

healthy.use(bodyparser());


/**
 * @route post /healthy/add
 * @desc 健康表添加接口
 * @access 接口私有
 */
healthy.post('/add', koajwt({
	secret: secretOrKey
}), async ctx => {

	let {
		account,
		category,
		cough,
		phone,
		region,
		school,
		sex,
		symptom,
		temperature,
		weakness,
		time
	} = ctx.request.body;
	let createTime = format(new Date(), 'YYYY-MM-DD HH:mm:ss');
	let sql =`insert into tb_healthy(account,category,cough,phone,region,school,sex,symptom,temperature,weakness,time,createTime) value('${account}','${category}','${cough}','${phone}','${region}','${school}','${sex}','${symptom}','${temperature}','${weakness}','${time}','${createTime}');`;

	let result = await query(sql)
	if (result.affectedRows > 0) {
		ctx.body = {
			code: 200,
			msg: "添加成功"
		};
	} else {
		ctx.body = {
			code: 400,
			msg: '健康表已存在'
		};
	}
})


/**
 * @route post /healthy/updata
 * @desc 学生健康表修改接口
 * @access 接口私有 只能管理员使用
 */
healthy.post('/updata', koajwt({
		secret: secretOrKey
	}), async ctx => {

		let {
			account,
			category,
			cough,
			phone,
			region,
			school,
			sex,
			symptom,
			temperature,
			weakness,
			time,
			healthyId
		} = ctx.request.body;

		let sql =`UPDATE tb_healthy set account='${account}',category='${category}',cough='${cough}',phone='${phone}',region='${region}',school='${school}',sex='${sex}',symptom='${symptom}',temperature='${temperature}',weakness='${weakness}',time='${time}' where healthyId='${healthyId}'`;

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
 * @route post /healthy/getWekeHealthy
 * @desc 最近一周学生填写健康表人数汇总接口
 * @access 接口私有
 */
healthy.post('/getWekeHealthy', koajwt({
	secret: secretOrKey
}), async ctx => {

	let {
		time,value
	} = ctx.request.body;

	let sql =`SELECT base.date,IFNULL(daily_new,0) daily_new FROM ( SELECT DATE( DATE_SUB( '${time}', INTERVAL @s := @s + 1 DAY ) ) AS date  FROM mysql.help_topic, ( SELECT @s := - 1 ) temp  WHERE @s < 6  ORDER BY date ) base left join ( SELECT count(*) daily_new, DATE_FORMAT(createTime,'%Y-%m-%d') as time from tb_healthy GROUP BY time ) res on base.date = res.time ORDER BY base.date;`;
	if(value==2){
		sql =`SELECT base.date,IFNULL(daily_new,0) daily_new FROM ( SELECT DATE( DATE_SUB( '${time}', INTERVAL @s := @s + 1 DAY ) ) AS date  FROM mysql.help_topic, ( SELECT @s := - 1 ) temp  WHERE @s < 29  ORDER BY date ) base left join ( SELECT count(*) daily_new, DATE_FORMAT(createTime,'%Y-%m-%d') as time from tb_healthy GROUP BY time ) res on base.date = res.time ORDER BY base.date;`;
	}
	
	let result = await query(sql)
	ctx.body = {
		code: 200,
		data: result
	}
})








module.exports = healthy;
