let check = {
	checkAdmin(admin, jurisdiction) {
		if (admin == "admin" && jurisdiction == 1) {
			let obj = {
				state: true
			}
			return obj;
		} else if (admin == "admin" && jurisdiction == 2) {

			let obj = {
				state: false,
				msg: {
					code: 400,
					msg: '该管理员已禁用'
				}
			}
			return obj;

		} else {
			let obj = {
				state: false,
				msg: {
					code: 400,
					msg: '无权限'
				}
			}
			return obj;
		}
	}
}




module.exports = check;
