<template>
	<view class="imgpage">
		<image class="img" :src="img"></image>
		<view class="button">
			<button type="primary" @click="uploadImage">从相册选一张</button>
		</view>
	</view>
</template>

<script>
	import {
		mapState
	} from 'vuex';
	import OSSUtil from '@/commont/libs/ossUtil.js'
	export default {
		data() {
			return {
				img: undefined
			}
		},
		computed: {
			...mapState('user', ['user']),
			...mapState('user', ['userType']),
		},
		methods: {
			// 上传图片处理逻辑
			async uploadImage() {
				const that = this

				let files = await OSSUtil.getImage(); // 选择图片
				let sign = await OSSUtil.get_STS() // 获取签名等信息
				let imageSrc = files.tempFilePaths[0]; // 图片上传微信平台返回的是数组
				let fileName = OSSUtil.getFileName('img', imageSrc); // 第一个参数为自己设置的oss文件目录地址 第二个参数为文件目录地址

				// uploadTask   此处返回所有上传信息，方便后面获取上传进度
				let uploadTask = uni.uploadFile({
					url: sign.host,
					filePath: imageSrc,
					fileType: 'image',
					name: 'file',
					formData: {
						name: imageSrc,
						'key': fileName,
						'policy': sign.policy,
						'OSSAccessKeyId': sign.accessId,
						'success_action_status': '200', //让服务端返回200,不然，默认会返回204
						'signature': sign.signature,
					},
					success: (res) => {
						that.img = sign.host + "/" + fileName
						if (res.statusCode != 200) {
							uni.showToast({
								title: '上传失败',
								icon: 'none',
								duration: 2000
							});
							return;
						} else {
							this.updataImg()
						}
					},
					fail: (err) => {
						uni.showModal({
							content: err.errMsg,
							showCancel: false
						});
					}
				});
				// 实时获取上传进度，图片文件太小，进度可能不是很明显
				// uploadTask.onProgressUpdate((res) => {
				// 	console.log("上传进度" + res.progress);
				// 	this.imageProgress = res.progress;
				// });
			},
			async updataImg(){
				if(this.userType==1){
					await this.$http.post('/api/student/updataHeadImg', {
						account: this.user.account,
						headImg: this.img
					}).then(res => {
						this.$store.dispatch('user/getStudent', {
							account: this.user.account
						})
						uni.showToast({
							title: '上传成功',
							icon: 'success',
							duration: 2000
						});
						setTimeout(() => {
							uni.navigateBack({
								delta: 1
							},2000);
						})
					})
				}else{
					await this.$http.post('/api/teacher/updataHeadImg', {
						account: this.user.account,
						headImg: this.img
					}).then(res => {
						this.$store.dispatch('user/getTeacher', {
							account: this.user.account
						})
						uni.showToast({
							title: '上传成功',
							icon: 'success',
							duration: 2000
						});
						setTimeout(() => {
							uni.navigateBack({
								delta: 1
							},2000);
						})
					})
				}
				
			}
		},
		onLoad() {
			this.img = this.user.headImg
			console.log(this.user)
		}
	}
</script>

<style lang="scss" scoped>
	.imgpage {
		width: 100%;
		height: 100%;

		.img {
			width: 100%;
			height: 50%;
		}

		.button {
			position: fixed;
			bottom: 30%;
			left: 0;
			right: 0;
			margin-left: 40rpx;
			margin-right: 40rpx;
		}
	}
</style>
