<template>
	<view class="index status_bar">
		<Tittle :title="title" style="margin-bottom: 10rpx;"></Tittle>
		<view class="content">
			<view class="index-card">
				<view class="cardTop">
					<view class="headImg">
						<u-avatar :src="user.headImg" size="140"></u-avatar>
					</view>
					<view class="name">
						<h2>{{user.name ||"无"}}</h2>
					</view>
				</view>
				<u-line class="u-line" :border-style="borderStyle" color="red" :color="color" :length="length"
					:direction="direction" :hair-line="hairLine"></u-line>
				<view class="cardDown">
					<view class="cardList">
						<image src="@/static/img/phone.png" mode=""></image>
						<text>{{user.phone ||"无"}}</text>
					</view>
					<view class="cardList">
						<image src="@/static/img/email.png" mode=""></image>
						<text>{{user.mail ||"无"}}</text>
					</view>
					<view class="cardList">
						<image src="@/static/img/map.png" mode=""></image>
						<text>{{user.address ||"无"}}</text>
					</view>
				</view>
			</view>
			<view class="index-card notice">
				<u-notice-bar :autoplay="autoplay" :playState="playState" :speed="speed" @getMore="getMore" :mode="mode" :show="show" :type="type" :list="list" :moreIcon="moreIcon" :volumeIcon="volumeIcon"
					:duration="duration" :isCircular="isCircular"></u-notice-bar>
			</view>

			<view class="index-card leave" v-if="userType==1">
				<text class="leaveText">健康填表</text>
				<u-gap bg-color="default" height="30" margin-top="0" margin-bottom="0"></u-gap>
				<uni-calendar @change="change" :selected="info.selected" :showMonth="true"></uni-calendar>
			</view>
			
		</view>
	</view>
</template>

<script>
	/**
	 * 获取任意时间
	 */
	function getDate(date, AddDayCount = 0) {
		if (!date) {
			date = new Date()
		}
		if (typeof date !== 'object') {
			date = date.replace(/-/g, '/')
		}
		const dd = new Date(date)

		dd.setDate(dd.getDate() + AddDayCount) // 获取AddDayCount天后的日期

		const y = dd.getFullYear()
		const m = dd.getMonth() + 1 < 10 ? '0' + (dd.getMonth() + 1) : dd.getMonth() + 1 // 获取当前月份的日期，不足10补0
		const d = dd.getDate() < 10 ? '0' + dd.getDate() : dd.getDate() // 获取当前几号，不足10补0
		return {
			fullDate: y + '-' + m + '-' + d,
			year: y,
			month: m,
			date: d,
			day: dd.getDay()
		}
	}
	import { mapState } from 'vuex';
	import Tittle from "@/components/title.vue"
	export default {
		data() {
			return {
				title: '我的名片',
				direction: 'row',
				hairLine: true,
				length: '100%',
				color: '#333',
				borderStyle: 'solid',
				show: true,
				autoplay: false,
				type: 'none',
				list: [],
				mode: 'vertical',
				playState: 'play',
				speed: 160,
				duration: 2000,
				moreIcon: true,
				volumeIcon: true,
				isCircular: true,
				current: 0,
				mode1: 'history',
				info: {
					lunar: true,
					range: true,
					insert: false,
					selected: []
				},
				
			}
		},
		computed: {
			...mapState('user', ['user']),
			...mapState('user', ['healthyList']),
			...mapState('user', ['userType']),
			...mapState('user', ['noticeList']),
		},
		onReady() {
			this.$nextTick(() => {
				this.showCalendar = true
			})
			// TODO 模拟请求异步同步数据
			// setTimeout(() => {
			// 	this.info.date = getDate(new Date(), -30).fullDate
			// 	this.info.startDate = getDate(new Date(), -60).fullDate
			// 	this.info.endDate = getDate(new Date(), 0).fullDate
				
			// }, 2000)
		},
		components: {
			Tittle,
		},
		methods: {
			getMore() {
				uni.navigateTo({
					url:'../notice/index'
				})
			},
			change(e) {
				uni.navigateTo({
					url:`../healthy/index?time=${e.fulldate}&stat=${e.extraInfo.stat}`
				})
			},
		},
		onLoad() {
			let token = uni.getStorageSync('token')
					if(!token){
						uni.reLaunch({
							url:'/pages/login/index'
						})
					}
					
					console.log(this.healthyList)
					
					this.healthyList.forEach(item=>{
						this.info.selected.push(item)
					})
					this.noticeList.forEach(item=>{
						this.list.push(item.title)
					})
		}
	}
</script>

<style scoped lang="scss">

	.index {
		width: 100%;
		height: auto;

		.content {
			width: 100%;
			height: auto;
			padding: 40rpx;
			padding-top: 0;

			.index-card {
				width: 100%;
				height: auto;
				padding: 10rpx 30rpx;
				border: 2rpx solid #FBFCFE;
				border-radius: 10rpx;
				background-color: #FBFCFE;
				box-shadow: 0px 0px 10px #ccc;
				margin-bottom: 20rpx;

				.cardTop {
					width: 100%;
					display: flex;
					padding: 10rpx;
					align-items: center;
					margin: 30rpx 0;

					.headImg {
						width: 130rpx;
						height: 130rpx;

						image {
							width: 100%;
							height: 100%;
							border-radius: 50%;
						}
					}

					.name {
						margin-left: 40rpx;
					}
				}

				.cardDown {
					.cardList {
						display: flex;
						align-items: center;
						margin: 15rpx 0;

						image {
							width: 30rpx;
							height: 30rpx;
							margin: 10rpx;
						}

						text {
							margin-left: 10rpx;
							color: #333;
						}
					}
				}
			}

			.notice {
				padding: 0;
			}

			.leave {
				padding: 30rpx;
				margin-bottom: 80rpx;
			}
		}
	}
</style>
