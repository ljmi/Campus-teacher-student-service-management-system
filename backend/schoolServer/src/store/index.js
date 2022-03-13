import Vue from 'vue'
import Vuex from 'vuex'
import getters from './getters'
import app from './modules/app'
import settings from './modules/settings'
import user from './modules/user'
import tagsView from './modules/tagsView'
import permission from './modules/permission.js'
import student from './modules/student'
import teacher from './modules/teacher'
import academy from './modules/academy'
import leave from './modules/leave.js'

Vue.use(Vuex)

const store = new Vuex.Store({
  modules: {
    app,
    settings,
    user,
    tagsView,
    permission,
    student,
	teacher,
	academy,
	leave
  },
  getters
})

export default store
