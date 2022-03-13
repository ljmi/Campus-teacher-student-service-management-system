import request from '@/utils/request'

export default {
	//根据专业id查所有班级
	getInfoByMajorId(data) {
		return request({
			url: '/api/classapi/getInfoByMajorId',
			method: 'post',
			data
		})
	},
	//分页条件查询班级列表
	pageList(data) {
	  return request({
	    url: '/api/classapi/page',
	    method: 'post',
	    data
	  })
	},
	//班级加学院搜索
	searchunion(data){
	  return request({
	    url: '/api/classapi/searchunion',
	    method: 'post',
	    data
	  })
	},
	//班级搜索
	classSeach(data){
	  return request({
	    url: '/api/classapi/search',
	    method: 'post',
	    data
	  })
	},
	//根据学院搜索班级分页
	getAcademyByClassSeach(data) {
		return request({
			url: '/api/classapi/getAcademyByClassSeach',
			method: 'post',
			data
		})
	},
	//根据专业查最后一个班级
	getLastClassByMajorId(data){
	  return request({
	    url: '/api/classapi/getLastClassByMajorId',
	    method: 'post',
	    data
	  })
	},
	//班级个添加
	classsingleAdd(data){
	  return request({
	    url: '/api/classapi/singleAdd',
	    method: 'post',
	    data
	  })
	},
	//班级信息更新
	classupdata(data){
	  return request({
	    url: '/api/classapi/updata',
	    method: 'post',
	    data
	  })
	},
	//班级单个删除
	classsingleDel(data){
	  return request({
	    url: '/api/classapi/singleDel',
	    method: 'post',
	    data
	  })
	},
}
