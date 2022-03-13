<template>
	<view class="title">
		<h2>{{title}}</h2>
	</view>
</template>

<script>
	export default {
		name: "Title",
		props: {
			title: {
				type: String,
				default: "无"
			}
		},
		data() {
			return {

			};
		}
	}
</script>

<style scoped lang="scss">
	.title {
		width: 100%;
		padding:20rpx 0;
		padding-left: 40rpx;
		background-color: #fff;
		font-size: 40rpx;
		font-weight: 900;
	}
</style>
