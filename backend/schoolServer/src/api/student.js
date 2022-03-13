import request from '@/utils/request'

export default {
  //分页条件查询学生列表
  pageList(data) {
    return request({
      url: '/api/student/page',
      method: 'post',
      data
    })
  },
  //学生搜索
  studentSeach(data){
    return request({
      url: '/api/student/search',
      method: 'post',
      data
    })
  },
	//学生加学院搜索
	searchunion(data){
	  return request({
	    url: '/api/student/searchunion',
	    method: 'post',
	    data
	  })
	},
	//根据学院搜索学生分页
	getAcademyByStudentSeach(data) {
		return request({
			url: '/api/student/getAcademyByStudentSeach',
			method: 'post',
			data
		})
	},
	//学生信息更新
	studentupdata(data){
	  return request({
	    url: '/api/student/updata',
	    method: 'post',
	    data
	  })
	},
	//学生单个添加
	studentsingleAdd(data){
	  return request({
	    url: '/api/student/singleAdd',
	    method: 'post',
	    data
	  })
	},
	//学生批量添加
	batchAddStudent(data){
	  return request({
	    url: '/api/student/batchAddStudent',
	    method: 'post',
	    data
	  })
	},
	//学生单个删除
	studentsingleDel(data){
	  return request({
	    url: '/api/student/singleDel',
	    method: 'post',
	    data
	  })
	},
	//根据班级查最后一个学生
	getLastStudentByClassId(data){
	  return request({
	    url: '/api/student/getLastStudentByClassId',
	    method: 'post',
	    data
	  })
	}
}
