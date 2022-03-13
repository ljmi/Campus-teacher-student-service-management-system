<template>
	<view class="healthy status_bar">
		<view class="img">
			<image src="@/static/img/healthy_bg.png"></image>
		</view>
		<view class="head">
			<Tittle :title="title" style="padding-left: 0;"></Tittle>
			<u-line class="u-line" :border-style="borderStyle" :length="length" :direction="direction"
				:hair-line="hairLine"></u-line>
			<view class="tipText">
				<text>请于每天12:00至14:30时间段进行体温检测并填报本表。本人承诺填报的信息真实、完整、有效。</text>
			</view>
			<view class="headTime">
				<text>日期：{{time}}</text>
			</view>
		</view>
		<view class="content">
			<u-form :model="model" :rules="rules" ref="uForm" :errorType="errorType">
				<u-form-item label-width="120" :label-position="labelPosition" label="1.体温(摄氏度)" prop="temperature">
					<u-input :border="border" placeholder="请填写体温" v-model="model.temperature" type="number"></u-input>
				</u-form-item>
				<u-form-item :label-position="labelPosition" label="2.本人当前所在位置" prop="region" label-width="150">
					<u-input :border="border" type="select" :select-open="pickerShow" v-model="model.region"
						placeholder="请选择地区" @click="pickerShow = true"></u-input>
				</u-form-item>
				<u-form-item :label-position="labelPosition" label="3.性别" prop="sex">
					<u-input :border="border" type="select" :select-open="actionSheetShow" v-model="model.sex"
						placeholder="请选择性别" @click="actionSheetShow = true"></u-input>
				</u-form-item>
				<u-form-item label-width="120" :label-position="labelPosition" label="4.学号" prop="account">
					<u-input :border="border" placeholder="请输入学号" v-model="model.account" type="text"></u-input>
				</u-form-item>
				<u-form-item :label-position="labelPosition" label="5.学生类别" prop="category">
					<u-input :border="border" type="select" :select-open="categoryShow" v-model="model.category"
						placeholder="请选择学生类别" @click="categoryShow = true"></u-input>
				</u-form-item>
				<u-form-item :label-position="labelPosition" label="6.手机号码" prop="phone" label-width="150">
					<u-input :border="border" placeholder="请填写手机号" v-model="model.phone" type="number"></u-input>
				</u-form-item>
				<u-form-item :label-position="labelPosition" label="7.填报当天是否在学校(包括在学校指定的宿舍居住)" prop="school">
					<u-input :border="border" type="select" :select-open="schoolShow" v-model="model.school"
						placeholder="请选择" @click="schoolShow = true"></u-input>
				</u-form-item>
				<u-form-item :label-position="labelPosition" label="8.有无咳嗽" prop="cough">
					<u-input :border="border" type="select" :select-open="coughShow" v-model="model.cough"
						placeholder="请选择" @click="coughShow = true"></u-input>
				</u-form-item>
				<u-form-item :label-position="labelPosition" label="9.有无乏力" prop="weakness">
					<u-input :border="border" type="select" :select-open="weaknessShow" v-model="model.weakness"
						placeholder="请选择" @click="weaknessShow = true"></u-input>
				</u-form-item>
				<u-form-item label-width="120" :label-position="labelPosition" label="10.其他不适(请说明)">
					<u-input :border="border" placeholder="请填写不适应症状" v-model="model.symptom" type="textarea"></u-input>
				</u-form-item>
			</u-form>
			<u-button style="margin-bottom: 40px;" @click="submit">{{submitText}}</u-button>
		</view>
		<u-picker mode="region" v-model="pickerShow" @confirm="regionConfirm"></u-picker>
		<u-action-sheet :list="actionSheetList" v-model="actionSheetShow" @click="actionSheetCallback"></u-action-sheet>
		<u-action-sheet :list="categoryList" v-model="categoryShow" @click="categoryCallback"></u-action-sheet>
		<u-action-sheet :list="schoolList" v-model="schoolShow" @click="schoolCallback"></u-action-sheet>
		<u-action-sheet :list="currencylList" v-model="coughShow" @click="coughCallback"></u-action-sheet>
		<u-action-sheet :list="currencylList" v-model="weaknessShow" @click="weaknessCallback"></u-action-sheet>
	</view>
</template>

<script>
	import {
		mapState
	} from 'vuex';
	import Tittle from "@/components/title.vue"
	export default {
		data() {
			return {
				time: '',
				title: '健康登记表',
				direction: 'row',
				hairLine: false,
				length: '100%',
				borderStyle: 'solid',
				model: {
					temperature: '',
					region: '',
					sex: '',
					account: '',
					category: '',
					phone: '',
					school: '',
					weakness: '',
					cough: '',
					symptom: '',
					time: '',
					healthyId: ''
				},
				rules: {
					temperature: [{
						required: true,
						message: '请输入体温',
						trigger: 'blur',
					}],
					region: [{
						required: true,
						message: '请选择地区',
						trigger: 'change',
					}],
					sex: [{
						required: true,
						message: '请选择性别',
						trigger: 'change'
					}, ],
					school: [{
						required: true,
						message: '请选择',
						trigger: 'change'
					}, ],
					cough: [{
						required: true,
						message: '请选择',
						trigger: 'change'
					}, ],
					weakness: [{
						required: true,
						message: '请选择',
						trigger: 'change'
					}, ],
					category: [{
						required: true,
						message: '请选择学生类别',
						trigger: 'change'
					}, ],
					account: [{
						required: true,
						message: '请输入学号',
						trigger: 'blur',
					}, {
						pattern: /^[0-9]*$/,
						message: '学号只能为数字',
						trigger: 'change',
					}],
					phone: [{
							required: true,
							message: '请输入手机号',
							trigger: ['change', 'blur'],
						},
						{
							validator: (rule, value, callback) => {
								// 调用uView自带的js验证规则，详见：https://www.uviewui.com/js/test.html
								return this.$u.test.mobile(value);
							},
							message: '手机号码不正确',
							// 触发器可以同时用blur和change，二者之间用英文逗号隔开
							trigger: ['change', 'blur'],
						}
					],
				},
				errorType: ['message'],
				border: false,
				labelPosition: 'top',
				pickerShow: false,
				actionSheetList: [{
						text: '男'
					},
					{
						text: '女'
					}
				],
				actionSheetShow: false,
				categoryList: [{
						text: '研究生'
					},
					{
						text: '本科生'
					},
					{
						text: '专科生/高职生'
					},
					{
						text: '留学生'
					},
					{
						text: '其他'
					},
				],
				categoryShow: false,
				schoolList: [{
						text: '是'
					},
					{
						text: '否'
					}
				],
				schoolShow: false,
				currencylList: [{
						text: '有'
					},
					{
						text: '无'
					}
				],
				weaknessShow: false,
				coughShow: false,
				stat: false
			};
		},
		components: {
			Tittle,
		},
		computed: {
			...mapState('user', ['healthy']),
			borderCurrent() {
				return this.border ? 0 : 1;
			},
			submitText() {
				if (this.stat == 'true') {
					return '修改'
				} else {
					return '提交'
				}
			}
		},
		onReady() {
			this.$refs.uForm.setRules(this.rules);
		},
		onLoad(Option) {
			this.time = Option.time
			this.model.time = Option.time
			this.stat = Option.stat
		},
		methods: {
			// 选择地区回调
			regionConfirm(e) {
				this.model.region = e.province.label + '-' + e.city.label + '-' + e.area.label;
			},
			// 点击actionSheet回调
			actionSheetCallback(index) {
				uni.hideKeyboard();
				this.model.sex = this.actionSheetList[index].text;
			},
			categoryCallback(index) {
				uni.hideKeyboard();
				this.model.category = this.categoryList[index].text;
			},
			schoolCallback(index) {
				uni.hideKeyboard();
				this.model.school = this.schoolList[index].text;
			},
			coughCallback(index) {
				uni.hideKeyboard();
				this.model.cough = this.currencylList[index].text;
			},
			weaknessCallback(index) {
				uni.hideKeyboard();
				this.model.weakness = this.currencylList[index].text;
			},
			submit() {
				console.log(this.model)
				this.$refs.uForm.validate(valid => {
					if (valid) {
						if (this.stat == 'true') {
							this.$http.post('/api/healthy/updata', this.model).then(res => {
								this.$toast(res.msg)
								this.$store.dispatch('user/getHealthy', this.model)
								this.$store.dispatch('user/getHealthyList', this.model)
								setTimeout(() => {
									uni.reLaunch({
										url:'../index/index'
									})
								}, 1000)
							})
						} else if (this.stat == 'false') {
							this.$http.post('/api/healthy/add', this.model).then(res => {
								this.$toast(res.msg)
								this.$store.dispatch('user/getHealthy', this.model)
								this.$store.dispatch('user/getHealthyList', this.model)
								setTimeout(() => {
									uni.reLaunch({
										url:'../index/index'
									})
								}, 1000)
							})
						}

						console.log('验证通过');
					} else {
						console.log('验证失败');
					}
				});
			}
		},
		created() {
			if (this.stat == 'true') {
				this.healthy.forEach(item => {
					if (item.time == this.model.time) {
						this.model.healthyId = item.healthyId
						this.model.temperature = item.temperature.toFixed(1)
						this.model.region = item.region
						this.model.sex = item.sex
						this.model.account = item.account
						this.model.category = item.category
						this.model.phone = item.phone
						this.model.school = item.school
						this.model.weakness = item.weakness
						this.model.cough = item.cough
						this.model.symptom = item.symptom
						this.model.time = item.time
					}
				})
			} else if (this.stat == 'false') {
				let list = this.healthy[this.healthy.length - 1]
				this.model.temperature = list.temperature.toFixed(1)
				this.model.region = list.region
				this.model.sex = list.sex
				this.model.account = list.account
				this.model.category = list.category
				this.model.phone = list.phone
				this.model.school = list.school
				this.model.weakness = list.weakness
				this.model.cough = list.cough
				this.model.symptom = list.symptom
			}
		}
	}
</script>

<style lang="scss" scoped>
	.healthy {
		.img {
			width: 100%;
			height: 400rpx;

			image {
				width: 100%;
				height: 100%;
			}
		}

		.head {
			width: 100%;
			padding: 0 20rpx;

			.tipText {
				margin: 10rpx 0;
			}

			.headTime {
				color: #383938;
			}
		}

		.content {
			padding: 20rpx;
		}

	}
</style>
