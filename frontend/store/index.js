import Vue from 'vue'
import Vuex from 'vuex'
import user from './modules/user.js'
import academy from './modules/academy.js'
import teacher from './modules/teacher.js'
import area from './modules/area.js'
Vue.use(Vuex);
const store = new Vuex.Store({
	state: {
		
	},
	mutations: {
		
	},
	actions: {
		
	},
	modules:{
		user,
		academy,
		teacher,
		area
	}
});
export default store