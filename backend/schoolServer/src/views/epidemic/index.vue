<template>
	<div class="dashboard-editor-container">
		<el-select v-model="value" placeholder="请选择" @change="changeType">
			<el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value">
			</el-option>
		</el-select>
		<panel-group @handleSetLineChartData="handleSetLineChartData" :data1="obj" />

		<el-row style="background:#fff;padding:16px 16px 0;margin-bottom:32px;">
			<line-chart :chart-data="lineChartData" />
		</el-row>
	</div>
</template>

<script>
	import PanelGroup from './components/PanelGroup'
	import LineChart from './components/LineChart'
	import leaveApi from '@/api/leave.js'
	import healthyApi from '@/api/healthy.js'

	let lineChartData = {
		newVisitis: {
			expectedData: [0, 1, 10, 100, 1000, 10000, 100000],
			actualData: [],
			timeData: []
		},
		messages: {
			expectedData: [0, 1, 10, 100, 1000, 10000, 100000],
			actualData: [],
			timeData: []
		},
		purchases: {
			expectedData: [0, 1, 10, 100, 1000, 10000, 100000],
			actualData: [],
			timeData: []
		},
		shoppings: {
			expectedData: [0, 1, 10, 100, 1000, 10000, 100000],
			actualData: [],
			timeData: []
		}
	}
	var time = (new Date).getTime() - 24 * 60 * 60 * 1000;
	var yesday = new Date(time); // 获取的是前一天日期
	yesday = yesday.getFullYear() + "-" + (yesday.getMonth() > 9 ? (yesday.getMonth() + 1) : "0" + (yesday
		.getMonth() + 1)) + "-" + (yesday.getDate() > 9 ? (yesday.getDate()) : "0" + (yesday
		.getDate())); //字符串拼接转格式：例如2018-08-19

	export default {
		name: "Epidemic",
		components: {
			LineChart,
			PanelGroup
		},
		data() {
			return {
				lineChartData: lineChartData.newVisitis,
				options: [{
					value: '1',
					label: '最近七天'
				}, {
					value: '2',
					label: '最近一个月'
				}, {
					value: '3',
					label: '按学院'
				}],
				value: '1',
				obj: {
					outSizeCount: 0,
					inSizeCount: 0,
					healthyCount: 0
				}
			}
		},
		methods: {
			getWekeCount() {
				leaveApi.getWekeCount({
					time: yesday,
					value: this.value
				}).then(res => {
					this.obj.outSizeCount = res.data[0].outSizeCount
					this.obj.inSizeCount = res.data[0].inSizeCount
					this.obj.healthyCount = res.data[0].healthyCount
				})
			},
			changeType() {
				this.getWekeOutsize({
					time: yesday,
					value: this.value
				})
				this.getWekeInsize({
					time: yesday,
					value: this.value
				})
				this.getWekeHealthy({
					time: yesday,
					value: this.value
				})
				this.getWekeCount({
					time: yesday,
					value: this.value
				})
			},
			handleSetLineChartData(type) {
				this.lineChartData = lineChartData[type]
			},
			formatDateTime(obj) {
				if (obj == null) {
					return null
				}
				let date = new Date(obj);
				let y = 1900 + date.getYear();
				let m = "0" + (date.getMonth() + 1);
				let d = "0" + date.getDate();
				return y + "-" + m.substring(m.length - 2, m.length) + "-" + d.substring(d.length - 2, d.length);
			},
			getWekeOutsize() {
				leaveApi.getWekeOutsize({
					time: yesday,
					value: this.value
				}).then(res => {
					let arr = res.data
					let lsarr = []
					let lsarr1 = []
					arr.forEach(item => {
						lsarr.push(this.formatDateTime(item.date))
						lsarr1.push(item.daily_new)
					})
					lineChartData.newVisitis.timeData = lsarr
					lineChartData.newVisitis.actualData = lsarr1
				})
			},
			getWekeInsize() {
				leaveApi.getWekeInsize({
					time: yesday,
					value: this.value
				}).then(res => {
					let arr = res.data
					let lsarr = []
					let lsarr1 = []
					arr.forEach(item => {
						lsarr.push(this.formatDateTime(item.date))
						lsarr1.push(item.daily_new)
					})
					lineChartData.messages.timeData = lsarr
					lineChartData.messages.actualData = lsarr1
				})
			},
			getWekeHealthy() {
				healthyApi.getWekeHealthy({
					time: yesday,
					value: this.value
				}).then(res => {
					let arr = res.data
					let lsarr = []
					let lsarr1 = []
					arr.forEach(item => {
						lsarr.push(this.formatDateTime(item.date))
						lsarr1.push(item.daily_new)
					})
					lineChartData.purchases.timeData = lsarr
					lineChartData.purchases.actualData = lsarr1
				})
			}
		},
		created() {
			this.getWekeOutsize({
				time: yesday,
				value: this.value
			})
			this.getWekeInsize({
				time: yesday,
				value: this.value
			})
			this.getWekeHealthy({
				time: yesday,
				value: this.value
			})
			this.getWekeCount({
				time: yesday,
				value: this.value
			})
		}
	}
</script>

<style lang="scss" scoped>
	.dashboard-editor-container {
		padding: 32px;
		background-color: rgb(240, 242, 245);
		position: relative;

		.chart-wrapper {
			background: #fff;
			padding: 16px 16px 0;
			margin-bottom: 32px;
		}
	}

	@media (max-width:1024px) {
		.chart-wrapper {
			padding: 8px;
		}
	}
</style>
