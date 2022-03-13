<template>
	<view class="apply status_bar">
		<Tittle :title="title"></Tittle>
		<view class="content">
			<u-form :model="model" :rules="rules" ref="uForm" :errorType="errorType">
				<u-form-item label-width="120" :label-position="labelPosition" label="姓名" prop="name">
					<u-input :border="border" placeholder="请输入姓名" v-model="model.name" type="text"></u-input>
				</u-form-item>
				<u-form-item :label-position="labelPosition" label="院系班级" prop="department" label-width="150">
					<u-input :border="border" type="select" :select-open="departmentshow" v-model="model.department"
						placeholder="请选择院系班级" @click="departmentshow = true"></u-input>
				</u-form-item>
				<u-form-item :label-position="labelPosition" label="请假事由" prop="reason" label-width="150">
					<u-input type="textarea" :border="border" placeholder="请填写请假事由" v-model="model.reason" />
				</u-form-item>
				<u-form-item :label-position="labelPosition" label="请假时间" prop="time" label-width="150">
					<u-input :border="border" type="select" :select-open="timeshow" v-model="model.time"
						placeholder="请选择请假时间" @click="timeshow = true"></u-input>
				</u-form-item>
				<u-form-item :label-position="labelPosition" label="请假类型" prop="type" label-width="150">
					<u-input :border="border" type="select" :select-open="typeShow" v-model="model.type"
						placeholder="请选择请假类型" @click="typeShow = true"></u-input>
				</u-form-item>
				<u-form-item :label-position="labelPosition" label="抄送教职工" label-width="150">
					<u-input :border="border" type="select" :select-open="teacherpickerShow" v-model="model.teacher"
						placeholder="请选择抄送教职工" @click="teacherpickerShow = true"></u-input>
				</u-form-item>
				<view v-if="model.type=='外出'">
					<u-form-item :label-position="labelPosition" label="前往地区" prop="region" label-width="150">
						<u-input :border="border" type="select" :select-open="pickerShow" v-model="model.region"
							placeholder="请选择地区" @click="pickerShow = true"></u-input>
					</u-form-item>
					<u-form-item :label-position="labelPosition" label="详细地址" prop="address" label-width="150">
						<u-input type="textarea" :border="border" placeholder="请填写纤细地址" v-model="model.address" />
					</u-form-item>
					<u-form-item label-width="120" :label-position="labelPosition" label="联系人" prop="contacts">
						<u-input :border="border" placeholder="请输入联系人" v-model="model.contacts" type="text"></u-input>
					</u-form-item>
					<u-form-item :label-position="labelPosition" label="手机号码" prop="phone" label-width="150">
						<u-input :border="border" placeholder="请输入手机号" v-model="model.phone" type="number"></u-input>
					</u-form-item>
				</view>
			</u-form>
			<view class="agreement" v-if="state==undefined">
				<u-checkbox v-model="check" @change="checkboxChange"></u-checkbox>
				<view class="agreement-text">
					勾选代表已阅读注意事项，明白填写事项并遵守相关学校规章制度。
				</view>
			</view>
			<u-button @click="submit" v-if="state==undefined">{{submitText}}</u-button>
			<u-button @click="submit" v-else>{{submitText}}</u-button>
		</view>
		<u-action-sheet :list="typeList" v-model="typeShow" @click="typeCallback"></u-action-sheet>
		<u-select mode="mutil-column-auto" :list="teacherAcdemyList" v-model="teacherpickerShow"
			@confirm="teacherConfirm">
		</u-select>
		<u-picker mode="region" v-model="pickerShow" @confirm="regionConfirm"></u-picker>
		<u-select mode="mutil-column-auto" :list="academyList" v-model="departmentshow" @confirm="departmentConfirm">
		</u-select>
		<u-calendar v-model="timeshow" ref="calendar" @change="change" :mode="mode" :start-text="startText"
			max-date="3000-10-1" :end-text="endText">
		</u-calendar>
	</view>
</template>

<script>
	import {
		mapState
	} from 'vuex';
	import Tittle from "../../components/title.vue"
	export default {
		data() {
			return {
				title: '请假申请',
				check: false,
				model: {
					account: '',
					name: '',
					region: '',
					department: '',
					reason: '',
					time: '',
					address: '',
					contacts: '',
					phone: '',
					agreement: false,
					type: '外出',
					teacher: '',
					teacherAccount: '',
					classId: '',
					majorId: '',
					academyId: '',
					startTime: '',
					endTime: '',
					leaveId: ''
				},
				rules: {
					name: [{
							required: true,
							message: '请输入姓名',
							trigger: 'blur',
						},
						{
							min: 2,
							max: 5,
							message: '姓名长度在2到5个字符',
							trigger: ['blur'],
						},
						{
							// 此为同步验证，可以直接返回true或者false，如果是异步验证，稍微不同，见下方说明
							validator: (rule, value, callback) => {
								// 调用uView自带的js验证规则，详见：https://www.uviewui.com/js/test.html
								return this.$u.test.chinese(value);
							},
							message: '姓名必须为中文',
							// 触发器可以同时用blur和change，二者之间用英文逗号隔开
							trigger: ['blur'],
						},
					],
					contacts: [{
							required: true,
							message: '请输入联系人',
							trigger: 'change',
						},
						{
							min: 2,
							max: 5,
							message: '联系人姓名长度在2到5个字符',
							trigger: ['change'],
						},
						{
							// 此为同步验证，可以直接返回true或者false，如果是异步验证，稍微不同，见下方说明
							validator: (rule, value, callback) => {
								// 调用uView自带的js验证规则，详见：https://www.uviewui.com/js/test.html
								return this.$u.test.chinese(value);
							},
							message: '联系人姓名必须为中文',
							// 触发器可以同时用blur和change，二者之间用英文逗号隔开
							trigger: ['blur'],
						},
					],
					region: [{
						required: true,
						message: '请选择地区',
						trigger: 'change',
					}],
					type: [{
						required: true,
						message: '请选择请假类型',
						trigger: 'blur',
					}],
					department: [{
						required: true,
						message: '请选择院系班级',
						trigger: 'change',
					}],
					reason: [{
						required: true,
						message: '请填写请假事由',
						trigger: 'blur',
					}],
					address: [{
						required: true,
						message: '请填写详细地址',
						trigger: 'change',
					}],
					time: [{
						required: true,
						message: '请选择请假时间',
						trigger: 'change',
					}],
					phone: [{
							required: true,
							message: '请输入手机号',
							trigger: ['change'],
						},
						{
							validator: (rule, value, callback) => {
								// 调用uView自带的js验证规则，详见：https://www.uviewui.com/js/test.html
								return this.$u.test.mobile(value);
							},
							message: '手机号码不正确',
							// 触发器可以同时用blur和change，二者之间用英文逗号隔开
							trigger: ['change'],
						}
					],
				},
				errorType: ['message'],
				labelPosition: 'left',
				border: false,
				pickerShow: false,
				teacherpickerShow: false,
				departmentshow: false,
				typeList: [{
						text: '外出'
					},
					{
						text: '非外出事假'
					},
					{
						text: '非外出病假'
					}
				],
				typeShow: false,
				timeshow: false,
				mode: 'range',
				startText: '开始',
				endText: '结束',
				leaveId: undefined,
				state: undefined
			};
		},
		components: {
			Tittle
		},
		computed: {
			...mapState('academy', ['academyList']),
			...mapState('teacher', ['teacherAcdemyList']),
			...mapState('user', ['healthyList']),
			...mapState('user', ['leaveList']),
			borderCurrent() {
				return this.border ? 0 : 1;
			},
			user() {
				return this.$store.state.user
			},
			submitText() {
				if (this.state == "待审批") {
					return "修改"
				} else if (typeof(this.state) == 'undefined') {
					return '提交'
				} else {
					return this.state
				}
			}
		},
		onReady() {
			this.$refs.uForm.setRules(this.rules);
		},
		onLoad(Option) {
			this.model.account = this.user.user.account
			this.model.name = this.user.user.name
			this.leaveId = Option.leaveId
			if (typeof(this.leaveId) == "undefined") {

			} else {
				console.log(this.leaveList)
				this.leaveList.forEach(item => {
					if (this.leaveId == item.leaveId) {
						if (item.state == "待审批" || item.state == "审批中" || item.state == "不通过" || item.state ==
							"已通过" || item.state == "已结束") {
							this.state = item.state
							this.model.leaveId = item.leaveId
							this.model.account = item.account
							this.model.type = item.type
							this.model.name = item.name
							this.model.department = item.academyName + "-" + item.majorName + "-" + item.className
							this.model.academyId = item.academyId
							this.model.majorId = item.majorId
							this.model.classId = item.classId
							this.model.reason = item.reason
							this.model.time = item.startTime + "-" + item.endTime
							this.model.startTime = item.startTime
							this.model.endTime = item.endTime
							this.model.teacher = item.teacherName
							this.model.teacherAccount = item.teacherAccount
							this.model.region = item.region
							this.model.address = item.address
							this.model.contacts = item.contacts
							this.model.phone = item.phone
							this.model.agreement = item.agreement
							this.model.account = item.account
						}
					}
				})
			}
			console.log(this.state)
		},
		methods: {
			// 点击actionSheet回调
			typeCallback(index) {
				uni.hideKeyboard();
				this.model.type = this.typeList[index].text;
			},
			regionConfirm(e) {
				this.model.region = e.province.label + '-' + e.city.label + '-' + e.area.label;
			},
			// 选择教职工回调
			teacherConfirm(e) {
				console.log(e)
				this.model.teacher = e[1].label;
				this.model.teacherAccount = e[1].value
			},
			// 选择学院回调
			departmentConfirm(e) {
				this.model.academyId = e[0].value
				this.model.majorId = e[1].value
				this.model.classId = e[2].value
				this.model.department = '';
				e.map((val, index) => {
					this.model.department += this.model.department == '' ? val.label : '-' + val.label;
				})
			},
			change(e) {
				this.model.startTime = e.startDate
				this.model.endTime = e.endDate
				if (this.mode == 'range') {
					this.model.time = e.startDate + " 至 " + e.endDate;
				} else {
					this.model.time = e.result;
				}
			},
			// 勾选版权协议
			checkboxChange(e) {
				this.model.agreement = e.value;
			},
			submit() {
				if (this.state == "待审批") {
					//修改
					this.model.agreement = true
					this.$refs.uForm.validate(valid => {

						if (valid) {
							if (!this.model.agreement) {
								return this.$u.toast('请勾选协议');
							}
							console.log(this.model)
							this.$http.post('/api/leave/updata', this.model).then(res => {
								this.$toast(res.msg)
								this.$store.dispatch('user/getLeave', this.model)
								setTimeout(() => {
									uni.switchTab({
										url: '/pages/leave/index'
									})
								}, 1000)
							})
						} else {
							console.log('验证失败');
						}
					});
				} else if (typeof(this.state) == "undefined") {
					this.$refs.uForm.validate(valid => {

						if (valid) {
							if (!this.model.agreement) {
								return this.$u.toast('请勾选协议');
							}
							this.$http.post('/api/leave/add', this.model).then(res => {
								this.$toast(res.msg)
								this.$store.dispatch('user/getLeave', this.model)
								setTimeout(() => {
									uni.switchTab({
										url: '/pages/leave/index'
									})
								}, 1000)
							})
						} else {
							console.log('验证失败');
						}
					});
				}


			},
		}
	}
</script>

<style lang="scss" scoped>
	.apply {
		width: 100%;
		height: 100%;

		.content {
			padding: 20rpx;

			.agreement {
				display: flex;
				align-items: center;
				margin: 40rpx 0;

				.agreement-text {
					padding-left: 8rpx;
					color: $u-tips-color;
				}
			}
		}
	}
</style>
