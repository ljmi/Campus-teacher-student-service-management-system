import {login,logout,getInfo} from '@/api/user'
import {getToken,setToken,removeToken} from '@/utils/auth'
import router,{resetRouter} from '@/router'


const state = {
		token: getToken(),
		name: '',
		avatar: '',
		account: '',
		roles: []
	}

const mutations = {
	SET_TOKEN: (state, token) => {
		state.token = token
	},
	SET_NAME: (state, name) => {
		state.name = name
	},
	SET_AVATAR: (state, avatar) => {
		state.avatar = avatar
	},
	SET_ACCOUNT: (state, account) => {
		state.account = account
	},
  SET_ROLES: (state, roles) => {
    state.roles = roles
  }
}

const actions = {
	// user login
	login({commit}, userInfo) {
		const {account,password} = userInfo
		return new Promise((resolve, reject) => {
			login({account:account.trim(),password:password}).then(response => {
				console.log(response.data.token)
				const {data} = response
				commit('SET_ACCOUNT', account)
				commit('SET_TOKEN', data.token)
				setToken(data.token)
				resolve()
			}).catch(error => {
				reject(error)
			})
		})
	},

	// get user info
	getInfo({commit,state}) {
		return new Promise((resolve, reject) => {
			getInfo(state.token).then(response => {
				const {data} = response

				if (!data) {
					return reject('验证失败，请重新登录.')
				}

				const {roles,name,avatar} = data
				// roles must be a non-empty array
				if (!roles || roles.length <= 0) {
				    reject('getInfo: roles must be a non-null array!')
				}
				commit('SET_ROLES', roles)
				commit('SET_NAME', name)
				commit('SET_AVATAR', avatar)
				resolve(data)
			}).catch(error => {
				reject(error)
			})
		})
	},

	// user logout
	logout({commit,state}) {
		return new Promise((resolve, reject) => {
			logout(state.token).then(() => {
				commit('SET_TOKEN', '')
				commit('SET_ROLES', [])
				removeToken() // must remove  token  first
				resetRouter()
				resolve()
			}).catch(error => {
				reject(error)
			})
		})
	},

	// remove token
	resetToken({commit}) {
		return new Promise(resolve => {
			commit('SET_TOKEN', '')
			commit('SET_ROLES', [])
			removeToken()
			resolve()
		})
	}
}

export default {
	namespaced: true,
	state,
	mutations,
	actions
}
