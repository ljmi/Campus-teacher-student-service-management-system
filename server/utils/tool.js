const bcrypt = require('bcryptjs')

const tool = {
	//密码加密
	enbcrypt(password) {
		let salt = bcrypt.genSaltSync(10);
		let hash = bcrypt.hashSync(password, salt);
		return hash;
	}
}


module.exports = tool;
