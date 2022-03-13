import request from '@/utils/request'

export default {
	//根据学院id查所有专业
	getInfoByAcademyId(data) {
		return request({
			url: '/api/major/getInfoByAcademyId',
			method: 'post',
			data
		})
	},
	//分页条件查询学生列表
	pageList(data) {
	  return request({
	    url: '/api/major/page',
	    method: 'post',
	    data
	  })
	},
	//专业加学院搜索
	searchunion(data){
	  return request({
	    url: '/api/major/searchunion',
	    method: 'post',
	    data
	  })
	},
	//专业搜索
	majorSeach(data){
	  return request({
	    url: '/api/major/search',
	    method: 'post',
	    data
	  })
	},
	//根据学院搜索学生分页
	getAcademyByMajorSeach(data) {
		return request({
			url: '/api/major/getAcademyByMajorSeach',
			method: 'post',
			data
		})
	},
	//专业信息更新
	majorupdata(data){
	  return request({
	    url: '/api/major/updata',
	    method: 'post',
	    data
	  })
	},
	//专业单个添加
	majorsingleAdd(data){
	  return request({
	    url: '/api/major/singleAdd',
	    method: 'post',
	    data
	  })
	},
	//专业单个删除
	majorsingleDel(data){
	  return request({
	    url: '/api/major/singleDel',
	    method: 'post',
	    data
	  })
	},
	//根据学院查最后专业学生
	getLastMajorByAcademy(data){
	  return request({
	    url: '/api/major/getLastMajorByAcademy',
	    method: 'post',
	    data
	  })
	}
}
