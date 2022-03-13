import request from '@/utils/request'

export function login(data) {
	return request({
		url: '/api/login/admin',
		method: 'post',
		data
	})
}

export function getInfo(token) {
	return request({
		url: '/api/admin/info',
		method: 'post',
		params: {
			token
		}
	})
}



export function logout() {
	return Cookies.remove(TokenKey)
}

export default {
	getUserList() {
		return request({
			url: '/api/admin/adminList',
			method: 'post'
		})
	},
	updataJurisdiction(data) {
		return request({
			url: '/api/admin/updataJurisdiction',
			method: 'post',
			data
		})
	},
	getLastAdminId() {
		return request({
			url: '/api/admin/getLastAdminId',
			method: 'post'
		})
	},
	singleAdd(data) {
		return request({
			url: '/api/admin/singleAdd',
			method: 'post',
			data
		})
	},
	updata(data) {
		return request({
			url: '/api/admin/updata',
			method: 'post',
			data
		})
	},
	singleDel(data) {
		return request({
			url: '/api/admin/singleDel',
			method: 'post',
			data
		})
	}
}
