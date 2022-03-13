import request from '@/static/request/request.js'
export default {
	namespaced: true, //模块与文件同名
	state: {
		// 学院信息
		academyList:[]
	},
	mutations: {
		// 设置学院数据
		setAcademyData(state, data) {
			state.academyList = data
		}
	},
	actions: {
		
		// 获取学院数据
		getAcademy(ctx) {
			request.http.post('/api/academy/cascade').then(res => {
				ctx.commit('setAcademyData', res.data)
			})
		}
	}
}
