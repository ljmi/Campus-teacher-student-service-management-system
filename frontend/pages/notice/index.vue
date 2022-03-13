<template>
	<view class="noticeList status_bar">
		<u-sticky :offset-top="offsetTop" :enable="enable">
			<view class="noticeTitle">
				公告
			</view>
		</u-sticky>
		<view class="content">
			<view class="list" v-if="noticeList!=[]">
				<navigator :url="'./details?noticeId='+item.noticeId" class="card" v-for="item in noticeList">
					<view class="title">
						{{item.title}}
					</view>
					<view class="time">
						{{item.createTime |moment}}
					</view>
				</navigator>

			</view>
			<view class="empty" v-else>
				<u-empty :mode="mode1">
				</u-empty>
			</view>
		</view>

	</view>
</template>

<script>
	import { mapState } from 'vuex';
	export default {
		data() {
			return {
				mode1: 'history',
				offsetTop: 0,
				enable: true,
			};
		},
		computed: {
			...mapState('user', ['noticeList']),
		},
	}
</script>

<style lang="scss" scoped>
	.noticeList {
		width: 100%;
		height: 100%;

		.noticeTitle {
			padding: 20rpx 40rpx;
			font-size: 2.2em;
			width: 100%;
			background-color: #fcfdff;
			font-weight: 900;
		}

		.content {
			width: 100%;
			// height: 100%;

			.list {
				padding: 0 40rpx;
				margin-top: 40rpx;
				margin-bottom: 20rpx;

				.card {
					padding: 40rpx 40rpx;
					border-radius: 10rpx;
					background-color: #edf0f7;
					margin-bottom: 40rpx;
					display: flex;
					justify-content: space-between;
					align-items: center;
					.title{
						width: 60%;
						overflow: hidden;
						text-overflow:ellipsis;
						white-space: nowrap;
					}
					.time{
						width: 40%;
						text-align: right;
					}
				}
			}

			.empty {
				height: 100%;
				display: flex;
				align-items: center;
				justify-content: center;
			}
		}


	}
</style>
