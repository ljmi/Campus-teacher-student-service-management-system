<template>
	<view class="setPass status_bar">
		<view class="tip">
			设置密码后请重新登录
		</view>
		<u-form :model="model" :rules="rules" ref="uForm" :errorType="errorType">
			<u-form-item :label-position="labelPosition" label="旧密码" prop="oldpassword" label-width="150">
				<u-input :password-icon="true" :border="border" type="password" v-model="model.oldpassword" placeholder="请输入旧密码"></u-input>
			</u-form-item>
		<u-form-item :label-position="labelPosition" label="密码" label-width="150" prop="password">
			<u-input :password-icon="true" :border="border" type="password" v-model="model.password" placeholder="请输入新密码"></u-input>
		</u-form-item>
		<u-form-item :label-position="labelPosition" label="确认密码" label-width="150" prop="rePassword">
			<u-input :border="border" type="password" v-model="model.rePassword" placeholder="请确认新密码"></u-input>
		</u-form-item>
		</u-form>
		<view class="tip">
			需同时含有字母和数字，长度在6-12之间
		</view>
		<u-button @click="submit">提交</u-button>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				labelPosition: 'left',
				errorType: ['message'],
				model:{
					oldpassword:'',
					password: '',
					rePassword: '',
				},
				rules: {
					oldpassword: [
						{
							required: true,
							message: '请输入密码',
							trigger: ['change','blur'],
						},
						{
							// 正则不能含有两边的引号
							pattern: /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]+\S{5,12}$/,
							message: '需同时含有字母和数字，长度在6-12之间',
							trigger: ['change','blur'],
						}
					],
					password: [
						{
							required: true,
							message: '请输入密码',
							trigger: ['change','blur'],
						},
						{
							// 正则不能含有两边的引号
							pattern: /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]+\S{5,12}$/,
							message: '需同时含有字母和数字，长度在6-12之间',
							trigger: ['change','blur'],
						}
					],
					rePassword: [
						{
							required: true,
							message: '请重新输入密码',
							trigger: ['change','blur'],
						},
						{
							validator: (rule, value, callback) => {
								return value === this.model.password;
							},
							message: '两次输入的密码不相等',
							trigger: ['change','blur'],
						}
					],
				},
			};
		},
		computed: {
			borderCurrent() {
				return this.border ? 0 : 1;
			}
		},
		onReady() {
			this.$refs.uForm.setRules(this.rules);
		},
		methods:{
			submit() {
				this.$refs.uForm.validate(valid => {
					if (valid) {
						console.log('验证通过');
					} else {
						console.log('验证失败');
					}
				});
			},
		}
	}
</script>

<style lang="scss" scoped>
	page{height:100%}
.setPass{
	padding: 40rpx;
	.tip{
		font-size: 20rpx;
		color: #909399;
		padding: 40rpx 0;
	}
}
</style>
