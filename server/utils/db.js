let mysql = require('mysql')

let pool = mysql.createPool({
	host: 'localhost', // 连接的服务器(代码托管到线上后，需改为内网IP，而非外网)
	port: 3306, // mysql服务运行的端口
	database: 'bs_school', // 选择的库
	user: '', // 用户名
	password: '' // 用户密码   
})

//对数据库进行增删改查操作的基础
// function query(sql,callback){
//     pool.getConnection(function(err,connection){
//         connection.query(sql, function (err,rows) {
//             callback(err,rows)
//             connection.release()//中断连接
//         })
//     })
// }

let query = function(sql) {
	return new Promise((resolve, reject) => {
		pool.getConnection(function(err, connection) {
			if (err) {
				//连接失败
				console.log("连接失败！");
				
			} else {
				//连接成功后开启事务
				connection.beginTransaction(err => {
					if (err) {
						console.log("开启事务失败");
						
					} else {
						connection.query(sql, (err, rows) => {
							if (err) {
								connection.rollback()
								console.log("CRUD出错")
								resolve(err)
							} else {
								connection.commit((error) => {
									if (error) {
										console.log('事务提交失败')
										resolve(error)
									}
									resolve(rows)
								})
								
							}
							
							//一个事件就有一个从开始到结束的过程，数据库会话操作执行完后，就需要关闭掉，以免占用连接资源。
							connection.release()
						})
					}
				})

			}
		})
	})
}

// exports.query = query;
module.exports = {
	query
}
