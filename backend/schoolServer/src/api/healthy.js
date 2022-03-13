import request from '@/utils/request'

export default {
	
	//最近一周学生填写健康表人数汇总接口
	getWekeHealthy(data) {
		return request({
			url: '/api/healthy/getWekeHealthy',
			method: 'post',
			data
		})
	},
}