import academyApi from "@/api/academy"


const state = {
	academyList: [],
}

const mutations = {
	SET_ACADEMYlLIST: (state, academyList) => {
		state.academyList = academyList
	}
}

const actions = {
	getAcademy({commit}) {
		return new Promise((resolve, reject) => {
			academyApi.academyInfo().then(res => {
				let academyList=res.data
				commit('SET_ACADEMYlLIST', academyList)
				resolve()
			}).catch(error => {
				reject(error)
			})
		})
	}

}


export default {
	namespaced: true,
	state,
	mutations,
	actions
}
