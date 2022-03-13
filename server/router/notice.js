const Router = require("koa-router")
const notice = new Router()
const bodyparser = require('koa-bodyparser')
const {query} = require('../utils/db.js')
const {format} = require('silly-datetime')
const {secretOrKey} = require('../utils/key.js')
const {checkAdmin} = require('../utils/check.js')
const koajwt = require('koa-jwt')

notice.use(bodyparser())

/**
 * @route post /notice/all
 * @desc 公告分页查寻信息接口
 * @access 接口私有
 */
notice.post('/all', async ctx => {

	let sql =`select noticeId,title,createTime,content from tb_notice;`
	let result = await query(sql)

	ctx.body = {
		code: 200,
		data: {
			items: result
		}
	}
})

/**
 * @route post /notice/page
 * @desc 公告分页查寻信息接口
 * @access 接口私有 只能管理员使用
 */
notice.post('/page', koajwt({
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

		let sql =`select noticeId,title,content,createTime,classes,(SELECT COUNT(*) from tb_notice)as count from tb_notice limit ${page},${pageSize};`
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
 * @route post /notice/updata
 * @desc 单个公告修改接口
 * @access 接口私有 只能管理员使用
 */
notice.post('/updata', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		noticeId,
		title,
		content
	} = ctx.request.body;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {
		let sql =`UPDATE tb_notice set title='${title}',content='${content}' where noticeId='${noticeId}'`

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
 * @route post /notice/singleAdd
 * @desc 单个公告添加接口
 * @access 接口私有 只能管理员使用
 */
notice.post('/singleAdd', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		title,
		content
	} = ctx.request.body;
	let createTime = format(new Date(), 'YYYY-MM-DD HH:mm:ss');

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {

		let sql =`insert into tb_notice(title,content,createTime) value('${title}','${content}','${createTime}');`
		let result = await query(sql)
		if (result.affectedRows > 0) {
			ctx.body = {
				code: 200,
				msg: "添加成功"
			};
		} else {
			ctx.body = {
				code: 400,
				msg: '公告已存在'
			};
		}


	} else {
		ctx.body = returnDat.msg;
	}
})

/**
 * @route post /notice/singleDel
 * @desc 单个公告删除接口
 * @access 接口私有 只能管理员使用
 */
notice.post('/singleDel', koajwt({
	secret: secretOrKey
}), async ctx => {
	let {
		admin,
		jurisdiction
	} = ctx.state.user;

	let {
		noticeId
	} = ctx.request.body;

	let returnDat = checkAdmin(admin, jurisdiction);

	if (returnDat.state) {

			let sql =`DELETE from tb_notice where noticeId='${noticeId}';`
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
 * @route post /notice/search
 * @desc 公告搜索分页接口
 * @access 接口私有 只能管理员使用
 */
notice.post('/search', koajwt({
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

			let sql =`select noticeId,title,content,createTime,classes,(SELECT COUNT(*) from tb_student where name LIKE '%${ searchValue }%')as count from tb_notice where title LIKE '%${ searchValue }%' limit ${page},${pageSize};`

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

module.exports = notice;
