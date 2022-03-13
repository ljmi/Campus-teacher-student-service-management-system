import request from '@/static/request/request.js'
export default {
	namespaced: true, //模块与文件同名
	state: {
		highlist:[],
		middlelist:[],
	},
	mutations: {
		sethighlist(state, data) {
			state.highlist = data
		},
		setmiddlelist(state, data) {
			state.middlelist = data
		},
	},
	actions: {
		getAreaData(ctx) {
			uni.request({
				url:'https://diqu.gezhong.vip/api.php',
				success:(res)=>{
					ctx.commit('sethighlist', res.data.data.highlist)
					ctx.commit('setmiddlelist', res.data.data.middlelist)
				}
			})
		}
	}
}
