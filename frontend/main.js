import Vue from 'vue'
import App from './App'
import store from './store'

Vue.prototype.$store = store

// 引入封装请求
import request from '@/static/request/request.js'
Vue.prototype.$http=request.http
Vue.prototype.$host=request.host

// 封装原生 toast 提示
Vue.prototype.$toast=(content)=>{
	uni.showToast({
		icon:'none',
		title:content
	})
}

import moment from 'moment'
Vue.filter('moment',(val,type='YYYY-MM-DD')=>{
	if(!val) return ''
	return moment(val).format(type)
})

// 引入全局uView
import uView from 'uview-ui';
Vue.use(uView);

Vue.config.productionTip = false
App.mpType = 'app'
const app = new Vue({
	store,
    ...App
})
app.$mount()
