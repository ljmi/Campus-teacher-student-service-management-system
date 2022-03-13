import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

/* Layout */
import Layout from '@/layout'

/**
 * Note: sub-menu only appear when route children.length >= 1
 * Detail see: https://panjiachen.github.io/vue-element-admin-site/guide/essentials/router-and-nav.html
 *
 * hidden: true                   if set true, item will not show in the sidebar(default is false)
 * alwaysShow: true               if set true, will always show the root menu
 *                                if not set alwaysShow, when item has more than one children route,
 *                                it will becomes nested mode, otherwise not show the root menu
 * redirect: noRedirect           if set noRedirect will no redirect in the breadcrumb
 * name:'router-name'             the name is used by <keep-alive> (must set!!!)
 * meta : {
    roles: ['admin','editor']    control the page roles (you can set multiple roles)
    title: 'title'               the name show in sidebar and breadcrumb (recommend set)
    icon: 'svg-name'/'el-icon-x' the icon show in the sidebar
    breadcrumb: false            if set false, the item will hidden in breadcrumb(default is true)
    activeMenu: '/example/list'  if set path, the sidebar will highlight the path you set
  }
 */

/**
 * constantRoutes
 * a base page that does not have permission requirements
 * all roles can be accessed
 */
export const constantRoutes = [{
		path: '/redirect',
		component: Layout,
		hidden: true,
		children: [{
			path: '/redirect/:path(.*)',
			component: () => import('@/views/redirect/index')
		}]
	},
	{
		path: '/login',
		component: () => import('@/views/login/index'),
		hidden: true
	},

	{
		path: '/404',
		component: () => import('@/views/404'),
		hidden: true
	},

	{
		path: '/',
		component: Layout,
		redirect: '/dashboard',
		children: [{
			path: 'dashboard',
			name: 'Dashboard',
			component: () => import('@/views/epidemic/index'),
			meta: {
				title: '仪表盘',
				icon: 'dashboard'
			}
		}]
	},
	{
		path: '/admin',
		component: Layout,
		redirect: '/admin/index',
		children: [{
			path: 'admin',
			component: () => import('@/views/admin/index'),
			name: 'Admin',
			meta: {
				title: '管理员管理',
				icon: 'admin'
			}
		}]
	},
	{
		path: '/student',
		component: Layout,
		redirect: '/student/index',
		name: 'Student',
		meta: {
			title: '学生管理',
			icon: 'studentSettings'
		},
		children: [{
				path: 'studentsindex',
				name: 'StudentIndex',
				component: () => import('@/views/student/index'),
				meta: {
					title: '学生列表',
					icon: 'student'
				}
			},
			{
				path: 'studentImport',
				name: 'StudentImport',
				component: () => import('@/views/student/import'),
				meta: {
					title: '批量录入学生',
					icon: 'import'
				}
			}
		]
	},
	{
		path: '/teacher',
		component: Layout,
		redirect: '/teachers/index',
		name: 'Teacher',
		meta: {
			title: '教职工管理',
			icon: 'teacherSettings'
		},
		children: [{
				path: 'teacherIndex',
				name: 'TeacherIndex',
				component: () => import('@/views/teachers/index'),
				meta: {
					title: '教职工列表',
					icon: 'teacher'
				}
			},
			{
				path: 'teacherImport',
				name: 'TeacherImport',
				component: () => import('@/views/teachers/import'),
				meta: {
					title: '批量录入教职工',
					icon: 'import'
				}
			}
		]
	},
	{
		path: '/leave',
		component: Layout,
		redirect: '/leave/index',
		name: 'Leave',
		children: [{
				path: 'leaveindex',
				name: 'Leaveindex',
				component: () => import('@/views/leave/index'),
				meta: {
					title: '请假管理',
					icon: 'epidemicindex'
				}
			},
			// {
			//   path: 'healthTable',
			//   name: 'HealthTable',
			//   component: () => import('@/views/epidemic/healthTable'),
			//   meta: { title: '健康表', icon: 'healthTable' }
			// },
			// {
			//   path: 'temperature',
			//   name: 'Temperature',
			//   component: () => import('@/views/epidemic/temperature'),
			//   meta: { title: '体温监测', icon: 'temperature' }
			// }
		]
	},
	{
		path: '/academy',
		component: Layout,
		redirect: '/academy/index',
		children: [{
			path: 'academy',
			name: 'Academy',
			component: () => import('@/views/academy/index'),
			meta: {
				title: '学院管理',
				icon: 'academy'
			}
		}]
	},
	{
		path: '/major',
		component: Layout,
		redirect: '/major/index',
		children: [{
			path: 'major',
			name: 'Major',
			component: () => import('@/views/major/index'),
			meta: {
				title: '专业管理',
				icon: 'major'
			}
		}]
	},
	{
		path: '/class',
		component: Layout,
		redirect: '/class/index',
		children: [{
			path: 'class',
			name: 'Class',
			component: () => import('@/views/class/index'),
			meta: {
				title: '班级管理',
				icon: 'class'
			}
		}]
	},
	{
		path: '/notice',
		component: Layout,
		redirect: '/notice/index',
		children: [{
			path: 'notice',
			name: 'Notice',
			component: () => import('@/views/notice/index'),
			meta: {
				title: '公告管理',
				icon: 'notice'
			}
		}]
	},
	{
		path: '/system',
		component: Layout,
		redirect: '/system/index',
		children: [{
			path: 'system',
			name: 'System',
			component: () => import('@/views/system/index'),
			meta: {
				title: '系统设置',
				icon: 'el-icon-setting'
			}
		}]
	},


	// 404 page must be placed at the end !!!
	{
		path: '*',
		redirect: '/404',
		hidden: true
	}
]

const createRouter = () => new Router({
	//mode: 'history', // require service support
	scrollBehavior: () => ({
		y: 0
	}),
	routes: constantRoutes
})

const router = createRouter()

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
	const newRouter = createRouter()
	router.matcher = newRouter.matcher // reset router
}

export default router
