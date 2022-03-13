<template>
	<view class="noticeDetails status_bar">
		<view class="title">
			{{title}}
		</view>
		<view class="u-content">
			<u-parse :html="content"></u-parse>
		</view>
	</view>
</template>

<script>
	import { mapState } from 'vuex';
	export default {
		data() {
			return {
				content:'',
				title:'',
				noticeId:''
			};
		},
		computed: {
			...mapState('user', ['noticeList']),
		},
		onLoad(option) {
			console.log(option.noticeId)
			this.noticeList.forEach(item=>{
				if(item.noticeId==option.noticeId){
					this.content=item.content
					this.title=item.title
				}
			})
		}
	}
</script>

<style lang="scss" scoped>
.noticeDetails{
	width: 100%;
	height: 100%;
	.title{
		font-size: 40rpx;
		width: 100%;
		text-align: center;
		font-weight: 900;
	}
	.u-content{
		margin: 40rpx 40rpx 0 40rpx;
	}
}
</style>
