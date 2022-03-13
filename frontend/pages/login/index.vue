<template>
	<view class="wrap">
		<view class="top"></view>
		<view class="content">
			<view class="title">欢迎登录</view>
			<u-form :model="model" :rules="rules" ref="uForm" :errorType="errorType">
				<u-form-item label-width="120" :label-position="labelPosition" label="账号" prop="account">
					<u-input :border="border" placeholder="请输入账号" v-model="model.account" type="number"></u-input>
				</u-form-item>
				<u-form-item :label-position="labelPosition" label-width="120" label="密码" prop="password">
					<u-input :password-icon="true" :border="border" type="password" v-model="model.password"
						placeholder="请输入密码"></u-input>
				</u-form-item>
				<u-form-item :label-position="labelPosition" label="类型" label-width="150">
					<u-radio-group v-model="radio" @change="radioGroupChange" :width="radioCheckWidth"
						:wrap="radioCheckWrap">
						<u-radio shape="circle" v-for="(item, index) in radioList" :key="index" :name="item.name">
							{{ item.name }}
						</u-radio>
					</u-radio-group>
				</u-form-item>
			</u-form>

			<view class="alternative">
				<view class="password"></view>
				<view class="issue">遇到问题</view>
			</view>
			<u-button @click="submit">登录</u-button>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				labelPosition: 'left',
				radioCheckWidth: 'auto',
				radioCheckWrap: false,
				radioList: [{
						name: '学生',
						checked: true,
						disabled: false
					},
					{
						name: '教职工',
						checked: false,
						disabled: false
					},
					{
						name: '辅导员',
						checked: false,
						disabled: false
					}
				],
				radio: '学生',
				model: {
					account: '',
					password: '',
					type: 1
				},
				rules: {
					account: [{
						required: true,
						message: '请输入账号',
						trigger: ['change', 'blur'],
					}],
					password: [{
						required: true,
						message: '请输入密码',
						trigger: ['change', 'blur'],
					}],
				},
				errorType: ['message'],
				border: false,
				type: ''
			}
		},
		computed: {
			borderCurrent() {
				return this.border ? 0 : 1;
			}
		},
		onReady() {
			this.$refs.uForm.setRules(this.rules);
		},
		methods: {
			submit() {
				this.$refs.uForm.validate(valid => {
					if (valid) {
						this.$http.post('/api/login', this.model).then(res => {
							this.$toast(res.msg)
							uni.setStorageSync('token', res.data.token)
							if (this.model.type == 1) {
								this.$store.dispatch('user/getStudent', this.model)
								this.$store.dispatch('user/getLeave', this.model)
								this.$store.dispatch('user/getHealthy', this.model)
								this.$store.dispatch('user/getHealthyList', this.model)
							}else if (this.model.type == 2){
								this.$store.dispatch('user/getTeacher', this.model)
								this.$store.dispatch('teacher/getTeacherLeave', this.model)
							}else if (this.model.type == 3){
								this.$store.dispatch('user/getTeacher1', this.model)
								this.$store.dispatch('area/getAreaData')
							}

							this.$store.dispatch('academy/getAcademy')
							this.$store.dispatch('teacher/getTeacherAcdemy')
							this.$store.dispatch('user/getNoticeList')
							this.$store.dispatch('user/getUserType', this.model.type)
							setTimeout(() => {
								uni.switchTab({
									url: '/pages/index/index'
								})
							}, 1000)
						})
					} else {
						console.log('验证失败');
					}
				});
			},
			// radio选择发生变化
			radioGroupChange(e) {
				this.radio = e;
				if (e == '学生') {
					this.model.type = 1;
				} else if (e == '教职工') {
					this.model.type = 2;
				}else if (e == '辅导员') {
					this.model.type = 3;
				}

			},

		}
	};
</script>

<style lang="scss" scoped>
	.wrap {
		width: 100%;
		height: 100%;
		font-size: 28rpx;

		.content {
			width: 80%;
			height: 100%;
			margin: 80rpx auto 0;

			.title {
				text-align: left;
				font-size: 60rpx;
				font-weight: 500;
				margin-bottom: 100rpx;
			}

			input {
				text-align: left;
				margin-bottom: 10rpx;
				padding-bottom: 6rpx;
			}

			.tips {
				color: $u-type-info;
				margin-bottom: 60rpx;
				margin-top: 8rpx;
			}

			.getCaptcha {
				background-color: rgb(253, 243, 208);
				color: $u-tips-color;
				border: none;
				font-size: 30rpx;
				padding: 12rpx 0;

				&::after {
					border: none;
				}
			}

			.alternative {
				color: $u-tips-color;
				display: flex;
				justify-content: space-between;
				margin-top: 30rpx;
				margin-bottom: 40rpx;
			}
		}

		.buttom {
			.loginType {
				display: flex;
				padding: 350rpx 150rpx 150rpx 150rpx;
				justify-content: space-between;

				.item {
					display: flex;
					flex-direction: column;
					align-items: center;
					color: $u-content-color;
					font-size: 28rpx;
				}
			}

			.hint {
				padding: 20rpx 40rpx;
				font-size: 20rpx;
				color: $u-tips-color;

				.link {
					color: $u-type-warning;
				}
			}
		}
	}
</style>
