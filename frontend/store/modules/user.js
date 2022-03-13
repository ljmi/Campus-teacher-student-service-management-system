import request from '@/static/request/request.js'
export default {
	namespaced: true, //模块与文件同名
	state: {
		// 用户信息
		user: [],
		// 请假信息
		leaveList: [],
		healthyList: [],
		healthy: [],
		userType: undefined,
		correctList: [],
		noticeList:[]
	},
	mutations: {
		// 设置用户数据
		setUserData(state, data) {
			state.user = data
		},
		// 设置请假数据
		setLeaveData(state, data) {
			state.leaveList = data
		},
		// 设置健康表列表数据
		setHealthyData(state, data) {
			state.healthyList = data
		},
		// 设置健康表列表数据
		setHealthy(state, data) {
			state.healthy = data
		},
		// 设置代批改请假列表数据
		setCorrectList(state, data) {
			state.correctList = data
		},
		// 设置用户类型数据
		setUserType(state, data) {
			state.userType = data
		},
		// 设置公告列表数据
		setNoticeList(state, data) {
			state.noticeList = data
		}
	},
	actions: {

		// 获取用户数据
		getStudent(ctx, params) {
			request.http.post('/api/student/info', params).then(res => {
				ctx.commit('setUserData', res.data[0])
			})
		},
		// 获取教职工数据
		getTeacher(ctx, params) {
			request.http.post('/api/teacher/info', params).then(res => {
				ctx.commit('setUserData', res.data[0])
			})
		},
		// 获取教职工数据1
		getTeacher1(ctx, params) {
			request.http.post('/api/teacher/info', params).then(res => {
				ctx.commit('setUserData', res.data[0])
				ctx.dispatch('getCorrectList', res.data[0])
			})
		},
		//辅导员收取请假信息
		getCorrectList(ctx, params) {
			request.http.post('/api/teacher/getLeaveByclassIdFor', params).then(res => {
				ctx.commit('setCorrectList', res.data)
			})
		},
		// 获取请假数据
		getLeave(ctx, params) {
			request.http.post('/api/student/getleaveinfoBystudent', params).then(res => {
				ctx.commit('setLeaveData', res.data)
			})
		},
		// 获取健康表数据
		getHealthy(ctx, params) {
			request.http.post('/api/student/gethealthyinfoBystudent', params).then(res => {
				ctx.commit('setHealthyData', res.data)
			})
		},
		// 设置健康表列表数据
		getHealthyList(ctx, params) {
			request.http.post('/api/student/gethealthyListBystudent', params).then(res => {
				ctx.commit('setHealthy', res.data)
			})
		},
		// 设置公告列表数据
		getNoticeList(ctx) {
			request.http.post('/api/notice/all').then(res => {
				ctx.commit('setNoticeList', res.data.items)
			})
		},
		getUserType(ctx, params) {
			ctx.commit('setUserType', params)
		},
		// 退出登录
		logout(ctx) {
			uni.removeStorageSync('token')
		}
	}
}
