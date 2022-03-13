import request from '@/utils/request'

export default {

	//根据学院查最后一个教职工接口
	getLastTeacherByAcademyId(data) {
		return request({
			url: '/api/teacher/getLastTeacherByAcademyId',
			method: 'post',
			data
		})
	},
	//单个添加教职工接口
	singleAdd(data) {
		return request({
			url: '/api/teacher/singleAdd',
			method: 'post',
			data
		})
	},
	//分页条件查询教职工列表
	pageList(data) {
	  return request({
	    url: '/api/teacher/page',
	    method: 'post',
	    data
	  })
	},
	//教职工单个删除
	teachersingleDel(data){
	  return request({
	    url: '/api/teacher/singleDel',
	    method: 'post',
	    data
	  })
	},
	//教职工搜索
	teacherSeach(data){
	  return request({
	    url: '/api/teacher/search',
	    method: 'post',
	    data
	  })
	},
	//教职工加学院搜索
	searchunion(data){
	  return request({
	    url: '/api/teacher/searchunion',
	    method: 'post',
	    data
	  })
	},
	//根据学院搜索教职工分页
	getacademyByTeacherSeach(data) {
		return request({
			url: '/api/teacher/getacademyByTeacherSeach',
			method: 'post',
			data
		})
	},
	//教职工信息更新
	teacherupdata(data){
	  return request({
	    url: '/api/teacher/updata',
	    method: 'post',
	    data
	  })
	},
	//教职工批量添加
	batchAddTeacher(data){
	  return request({
	    url: '/api/teacher/batchAddTeacher',
	    method: 'post',
	    data
	  })
	},
}