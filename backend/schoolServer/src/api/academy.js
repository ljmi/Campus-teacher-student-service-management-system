import request from '@/utils/request'

export default {
	//获取学院信息
	academyInfo() {
		return request({
			url: '/api/academy/info',
			method: 'post'
		})
	},
	//获取所有学院信息
	academyAll() {
		return request({
			url: '/api/academy/all',
			method: 'post'
		})
	},
	//添加单个学院
	singleAdd(data) {
		return request({
			url: '/api/academy/singleAdd',
			method: 'post',
			data
		})
	},
	//学院信息更新
	academyupdata(data){
	  return request({
	    url: '/api/academy/updata',
	    method: 'post',
	    data
	  })
	},
	//学院单个删除
	academysingleDel(data){
	  return request({
	    url: '/api/academy/singleDel',
	    method: 'post',
	    data
	  })
	},
	//获取最后一个学院
	getLastAcademyId() {
		return request({
			url: '/api/academy/getLastAcademyId',
			method: 'post'
		})
	},
	//学院级联信息
	cascade() {
		return request({
			url: '/api/academy/cascade',
			method: 'post'
		})
	},
	//学院级联信息
	cascadeMajorAndAcademy() {
		return request({
			url: '/api/academy/cascadeMajorAndAcademy',
			method: 'post'
		})
	}
}
