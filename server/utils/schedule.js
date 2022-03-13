const {scheduleJob} = require('node-schedule')
const https = require('https')
const {query} = require('./db.js')

async function s(){
	return await query(`select switch from tb_settings WHERE settingsId=9`)
}

function scheduleCronstyle() {
	//每分钟的第30秒定时执行一次:
	 scheduleJob('30 1 1 * * *', async ctx => {
		console.log('scheduleCronstyle:' + new Date());
		let result =await query(`select switch from tb_settings WHERE settingsId=9`)
		console.log(result)
		
		if(result[0].switch==0){
			 https.get('https://diqu.gezhong.vip/api.php',(res)=>{
				res.on('data',(d)=>{
					console.log(d.toString())
					let result = query(`update tb_settings set text='${d.toString()}' WHERE settingsId=9;`)
					
				})
			}).on('error',(e)=>{
				console.error(e)
			})
		}

		
	});
}

module.exports = {scheduleCronstyle}
