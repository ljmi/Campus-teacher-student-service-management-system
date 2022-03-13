const host = process.env.NODE_ENV !== 'development' ? 'http://localhost:3000' : 'http://1.12.251.160:3000'
//http://1.12.251.160:3000

// 普通短连接
const http = (mode = 'GET', path, data) => {
	let token = uni.getStorageSync('token')
	return new Promise((resolve, reject) => {
		uni.request({
			header: {
				'Authorization': token
			},
			method: mode,
			url: host + path,
			data,
			complete: (res) => {
				// 判断状态码
				watchStatusCode(res, resolve, reject)
			}
		})
	})
}


// 判断状态码
const watchStatusCode = (res, resolve, reject) => {
	switch (res.statusCode) {
		case 200: // 正常
			resolve(res.data)
			break
		case 401: // 登录过期
			uni.showModal({
				content: '登录已过期，请重新登录',
				showCancel: false,
				complete: () => {
					uni.removeStorageSync('token')
					uni.reLaunch({
						url: '/pages/login/index'
					})
				}
			})
			reject(res.data)
			break
		default: // 其他错误
			reject(res.data)
			uni.showToast({
				icon: 'none',
				title: res.msg
			})
			break;
	}
}



export default {
	http: {
		get: (url, data) => http('GET', url, data),
		post: (url, data) => http('POST', url, data)
	},
	host
}