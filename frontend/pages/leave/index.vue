<template>
	<view class="leave status_bar">
		<Tittle :title="title"></Tittle>
		<view class="top" v-if="userType==1">
			<view class="headbg">
			</view>
			<navigator url="./apply">
				<view class="headImg">
					<image src="@/static/img/qj.png" mode=""></image>
				</view>
			</navigator>
		</view>
		<view class="content" v-if="userType==1">
			<u-sticky :offset-top="offsetTop" :enable="enable">
				<view class="historyTitle">
					请假历史
				</view>
			</u-sticky>

			<view class="page-box" v-if="leaveList.length>0">
				<navigator :url="'./apply?leaveId='+item.leaveId" v-for="item in leaveList">
					<view class="card">
						<view class="title cell">
							<view class="situation">
								审批状态：{{item.state}}
							</view>
							<view class="time">
								{{item.createTime |moment}}
							</view>
						</view>
						<view class="leaveCategory cell">
							请假类别：{{item.type}}
						</view>
						<view class="leaveTime cell">
							<u-icon name="clock" size="30" color="#909399"></u-icon>
							<text>请假时间：</text>
							<view class="statTime">
								{{item.startTime|moment}}
							</view>
							<view class="">
								—
							</view>
							<view class="endTime">
								{{item.endTime|moment}}
							</view>
						</view>
					</view>
				</navigator>

			</view>
			<view class="empty" v-else>
				<u-empty :mode="mode1">
				</u-empty>
			</view>

		</view>

		<view class="content" v-if="userType==2">

			<view class="page-box" v-if="teacherLeaveList.length>0">
				<navigator :url="'./details?leaveId='+item.leaveId" v-for="item in teacherLeaveList">
					<view class="card">
						<view class="title cell">
							<view class="situation">
								请假人：{{item.name}}
							</view>
							<view class="time">
								{{item.createTime |moment}}
							</view>
						</view>
						<view class="leaveCategory cell">
							{{item.academyName}}
						</view>
						<view class="leaveCategory cell">
							{{item.majorName}}-{{item.className}}
						</view>
						<view class="leaveTime cell">
							<u-icon name="clock" size="30" color="#909399"></u-icon>
							<text>请假时间：</text>
							<view class="statTime">
								{{item.startTime|moment}}
							</view>
							<view class="">
								—
							</view>
							<view class="endTime">
								{{item.endTime|moment}}
							</view>
						</view>
					</view>
				</navigator>

			</view>
			<view class="empty" v-else>
				<u-empty :mode="mode1">
				</u-empty>
			</view>

		</view>
		<view class="content" v-if="userType==3">
			<u-sticky :offset-top="offsetTop" :enable="enable" v-if="cList.length>0">
				<view class="historyTitle">
					待审批
				</view>
			</u-sticky>
			<view class="page-box" v-if="cList.length>0">
				<navigator :url="'./details?leaveId='+item.leaveId" v-for="item in cList">
					<view class="card">
						<view class="title cell">
							<view class="situation">
								请假人：{{item.name}}
							</view>
							<view class="time">
								{{item.createTime |moment}}
							</view>
						</view>
						<view class="leaveCategory cell">
							请假类别：{{item.type}}
						</view>
						<view class="leaveCategory cell">
							{{item.academyName}}
						</view>
						<view class="leaveCategory cell">
							{{item.majorName}}-{{item.className}}
						</view>
						<view class="leaveTime cell">
							<u-icon name="clock" size="30" color="#909399"></u-icon>
							<text>请假时间：</text>
							<view class="statTime">
								{{item.startTime|moment}}
							</view>
							<view class="">
								—
							</view>
							<view class="endTime">
								{{item.endTime|moment}}
							</view>
						</view>
					</view>
				</navigator>

			</view>
			<u-sticky :offset-top="offsetTop" :enable="enable">
				<view class="historyTitle">
					审批记录
				</view>
			</u-sticky>
			<view class="page-box" v-if="hList.length>0">
				<navigator :url="'./details?leaveId='+item.leaveId" v-for="item in hList">
					<view class="card">
						<view class="title cell">
							<view class="situation">
								请假人：{{item.name}}
							</view>
							<view class="time">
								{{item.createTime |moment}}
							</view>
						</view>
						<view class="leaveCategory cell">
							请假类别：{{item.type}}
						</view>
						<view class="leaveCategory cell">
							{{item.academyName}}
						</view>
						<view class="leaveCategory cell">
							{{item.majorName}}-{{item.className}}
						</view>
						<view class="leaveTime cell">
							<u-icon name="clock" size="30" color="#909399"></u-icon>
							<text>请假时间：</text>
							<view class="statTime">
								{{item.startTime|moment}}
							</view>
							<view class="">
								—
							</view>
							<view class="endTime">
								{{item.endTime|moment}}
							</view>
						</view>
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
	import {
		mapState
	} from 'vuex';
	import Tittle from "@/components/title.vue"
	export default {
		data() {
			return {
				title: '请假',
				mode1: 'history',
				offsetTop: 0,
				enable: true,
				cList: [],
				hList: []
			};
		},
		components: {
			Tittle
		},
		computed: {
			...mapState('user', ['leaveList']),
			...mapState('user', ['userType']),
			...mapState('teacher', ['teacherLeaveList']),
			...mapState('user', ['correctList']),
			...mapState('user', ['user'])
		},
		methods: {

		},
		onLoad() {
			this.correctList.forEach(item => {
				if (item.state == '待审批') {
					this.cList.push(item)
				} else {
					this.hList.push(item)
				}
			})
			console.log(this.userType)
		},
		onShow() {
			this.enable=true
		},
		onHide() {
			this.enable=false
		},
		onPullDownRefresh() {
			if (this.userType == 3) {
				let obj = {
					classId: this.user.classId
				}
				this.$store.dispatch('user/getCorrectList', obj)
			} else if (this.userType == 2) {
				let obj = {
					account: this.user.account
				}
				this.$store.dispatch('teacher/getTeacherLeave', obj)
			}else if(this.userType==1){
				let obj = {
					account: this.user.account
				}
				this.$store.dispatch('user/getLeave', obj)
			}

			setTimeout(function() {
				uni.stopPullDownRefresh();
			}, 2000);
		}
	}
</script>

<style lang="scss" scoped>
	.leave {
		width: 100%;
		height: 100%;

		.top {
			.headbg {
				position: relative;
				width: 100%;
				height: 400rpx;
				text-align: center;
				line-height: 50px;
			}

			.headbg:after {
				width: 140%;
				height: 400rpx;
				position: absolute;
				left: -20%;
				top: 0;
				z-index: -1;
				content: '';
				border-radius: 0 0 50% 50%;
				background: #261c3e;
			}

			.headImg {
				width: 80%;
				height: 400rpx;
				margin: 0 auto;
				margin-top: -360rpx;

				image {
					width: 100%;
					height: 100%;
				}
			}
		}

		.content {
			margin-top: 40rpx;

			.historyTitle {
				padding: 20rpx 40rpx;
				font-size: 40rpx;
				width: 100%;
				background-color: #fcfdff;
			}

			.empty {
				height: 100%;
				display: flex;
				align-items: center;
				justify-content: center;
			}

			.page-box {
				padding: 0 40rpx;
				margin-top: 40rpx;
				padding-bottom: 80rpx;

				.card {
					padding: 40rpx 40rpx;
					border-radius: 10rpx;
					background-color: #edf0f7;
					margin-bottom: 40rpx;


					.cell {
						margin: 20rpx 0;
					}

					.title {
						display: flex;
						justify-content: space-between;
						align-items: center;

						.situation {
							font-size: 34rpx;
							font-weight: 900;
						}
					}

					.leaveTime {
						display: flex;
						font-size: 32rpx;
					}

					.leaveCategory {
						font-size: 32rpx;
					}

				}
			}
		}


	}
</style>
