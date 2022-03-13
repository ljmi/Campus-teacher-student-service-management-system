import request from '@/utils/request'

export default {
	//分页条件查询公告列表
	pageList(data) {
		return request({
			url: '/api/notice/page',
			method: 'post',
			data
		})
	},
	//公告单个添加
	singleAdd(data) {
		return request({
			url: '/api/notice/singleAdd',
			method: 'post',
			data
		})
	},
	//公告信息更新
	updata(data){
	  return request({
	    url: '/api/notice/updata',
	    method: 'post',
	    data
	  })
	},
	//公告单个删除
	singleDel(data){
	  return request({
	    url: '/api/notice/singleDel',
	    method: 'post',
	    data
	  })
	},
	//公告搜索
	search(data){
	  return request({
	    url: '/api/notice/search',
	    method: 'post',
	    data
	  })
	},
}
