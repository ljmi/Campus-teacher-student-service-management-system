// 统一异常处理
module.exports = (app) => {
	app.use(async (ctx, next) => {
		let status = 0;
		let fileName = "";
		try {
			await next();
			status = ctx.status;
		} catch (err) {
			//console.log(err);
			status = 500;
		}
		if (status >= 400) {
			switch (status) {
				case 400:
					fileName = "Bad Request";
					break;
				case 401:
					fileName = "没有权限";
					break;
				case 404:
					fileName = "Not Found";
					break;
				case 500:
					fileName = "Internal Server Error";
					break;
				default:
					fileName = "other";
					break;
			}
		}
		ctx.response.status = status;
		console.log(fileName);
		ctx.body = {
			code: status,
			msg: fileName
		}
	});
}
