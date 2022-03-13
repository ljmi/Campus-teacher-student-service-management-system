<template>
	<view class="settings status_bar">
		<view class="content">
			<view class="u-m-t-20">
				<u-cell-group>
					<navigator url="./setPassword">
					<u-cell-item title="密码">
						<view class="u-m-r-10">
							点击修改
						</view>
					</u-cell-item>
					</navigator>
				</u-cell-group>
			</view>
			<u-button @click="submit" class="sumit" :loading="loading">退出登录</u-button>
		</view>
		
	</view>
</template>

<script>
	export default {
		data() {
			return {
				loading: false,
			}
		},
		methods: {
			submit(){
				this.loading=true
				this.$store.dispatch('user/logout').then(()=>{
					setTimeout(()=>{
						this.loading=false
						uni.reLaunch({
							url:'../login/index'
						})
					},3000)
				})
				
			}
		}
	}
</script>

<style lang="scss" scoped>
.settings{
	width: 100%;
	height: 100%;
	.content{
		width: 100%;
		height: 100%;
		position: relative;
		.sumit{
			position: fixed;
			margin: 0 40rpx;
			bottom: 40rpx;
			left: 0;
			right: 0;
		}
	}
	
}
</style>
