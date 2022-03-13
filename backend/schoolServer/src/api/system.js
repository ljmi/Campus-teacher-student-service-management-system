import request from '@/utils/request'

export default {
	//分页条件查询系统设置列表
	pageList(data) {
		return request({
			url: '/api/system/page',
			method: 'post',
			data
		})
	},
	//系统设置单个添加
	singleAdd(data) {
		return request({
			url: '/api/system/singleAdd',
			method: 'post',
			data
		})
	},
	//系统设置信息更新
	updata(data){
	  return request({
	    url: '/api/system/updata',
	    method: 'post',
	    data
	  })
	},
	//系统设置单个删除
	singleDel(data){
	  return request({
	    url: '/api/system/singleDel',
	    method: 'post',
	    data
	  })
	},
	//系统设置搜索
	search(data){
	  return request({
	    url: '/api/system/search',
	    method: 'post',
	    data
	  })
	},
	updataJurisdiction(data) {
		return request({
			url: '/api/system/updataJurisdiction',
			method: 'post',
			data
		})
	},
}
