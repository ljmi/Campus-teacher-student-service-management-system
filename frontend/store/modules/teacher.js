import request from '@/static/request/request.js'
export default {
	namespaced: true, //模块与文件同名
	state: {
		// 学院信息
		teacherAcdemyList:[],
		teacherLeaveList:[]
	},
	mutations: {
		// 设置教职工分学院数据
		setTeacherAcdemy(state, data) {
			state.teacherAcdemyList = data
		},
		// 设置教职工获取请假数据
		setTeacherLeave(state, data) {
			state.teacherLeaveList = data
		}
	},
	actions: {
		// 获取教职工分学院数据
		getTeacherAcdemy(ctx) {
			request.http.post('/api/teacher/cascade').then(res => {
				ctx.commit('setTeacherAcdemy', res.data)
			})
		},
		// 获取教职工获取请假数据
		getTeacherLeave(ctx,params) {
			request.http.post('/api/teacher/getLeaveByTeacherId',params).then(res => {
				ctx.commit('setTeacherLeave', res.data)
			})
		}
	}
}
