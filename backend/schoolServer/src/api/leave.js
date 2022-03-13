import request from '@/utils/request'

export default {
	//分页条件查询请假列表
	pageList(data) {
	  return request({
	    url: '/api/leave/page',
	    method: 'post',
	    data
	  })
	},
	//请假搜索
	leaveSeach(data){
	  return request({
	    url: '/api/leave/search',
	    method: 'post',
	    data
	  })
	},
	//学生加学院搜索
	searchunion(data){
	  return request({
	    url: '/api/leave/searchunion',
	    method: 'post',
	    data
	  })
	},
	//根据学院搜索请假分页
	getAcademyBylLeaveSeach(data) {
		return request({
			url: '/api/leave/getAcademyBylLeaveSeach',
			method: 'post',
			data
		})
	},
	//最近一周外出请假人数接口
	getWekeOutsize(data) {
		return request({
			url: '/api/leave/getWekeOutsize',
			method: 'post',
			data
		})
	},
	//最近一周非外出请假人数接口
	getWekeInsize(data) {
		return request({
			url: '/api/leave/getWekeInsize',
			method: 'post',
			data
		})
	},
	getWekeCount(data) {
		return request({
			url: '/api/leave/getWekeCount',
			method: 'post',
			data
		})
	},
}