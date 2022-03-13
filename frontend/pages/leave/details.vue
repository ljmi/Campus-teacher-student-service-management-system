<template>
	<view  class="details status_bar">
		<Tittle :title="title"></Tittle>
		<view class="content">
			<view class="cell">
				请假人：{{info.name}}
			</view>
			<view class="cell">
				班别：{{info.className}}
			</view>
			<view class="cell">
				请假理由：{{info.reason}}
			</view>
			<view class="cell">
				请假时间：{{info.startTime}}-{{info.endTime}}
			</view>
			<view class="cell">
				请假类型：{{info.type}}
			</view>
			<view class="cell" v-show="info.type=='外出'">
				前往地点：{{info.region}}
			</view>
			<view class="cell" v-show="info.type=='外出'">
				联系人：{{info.contacts}}
			</view>
			<view class="cell" v-show="info.type=='外出'">
				联系人电话：{{info.phone}}
			</view>
			<view class="proposal" v-show="info.type=='外出' && user.type=='辅导员' && info.state=='待审批'">
				建议：当前外出地点为{{proposal}}地区
			</view>
			<view class="cell" style="color: red;" v-show="user.type=='教职工'">
				请假状态：{{info.state}}
			</view>
		</view>
		<view class="bt" v-if="user.type=='辅导员' && info.state=='待审批'">
			<view class="bt-cell">
				<u-button @click="noClick" style="min-width: 150px;" type="error" >不通过</u-button>
			</view>
			<view class="bt-cell">
				<u-button @click="yesClick" style="min-width: 150px;" type="success">通过</u-button>
			</view>
			
		</view>
		
		<u-modal ref="uModal" v-model="show" :show-cancel-button="true"
			:show-title="showTitle"
			@confirm="confirm" :content="content"
		>
			<!-- #ifndef MP-WEIXIN || MP-TOUTIAO -->
			<view class="warp" style="margin: 30rpx;" v-if="contentSlot">
				<image class="logo" src="https://uviewui.com/common/logo.png" style="width: 220rpx;" mode="widthFix"></image>
			</view>
			<!-- #endif -->
		</u-modal>
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
				leaveId:undefined,
				title:'请假单',
				show: false,
				showTitle: true,
				contentSlot: false,
				content: '',
				start:'',
				info:[],
				proposal:'低风险'
			};
		},
		components:{
			Tittle
		},
		computed: {
			current() {
				return this.show ? 0 : 1;
			},
			...mapState('area',['highlist']),
			...mapState('area',['middlelist']),
			...mapState('user', ['user'])
		},
		onLoad(option) {
			this.leaveId=option.leaveId
			let obj={
				leaveId:option.leaveId
			}
			this.$http.post('/api/leave/leaveInfo', obj).then(res => {
				this.info=res.data[0]
				if(this.info.type=='外出' && this.user.type=="辅导员" && this.info.state=='待审批'){
					this.getProposal(this.info.region)
				}
				
			})
		},
		methods:{
			confirm() {
				let parems={
					state:this.start,
					leaveId:this.leaveId
				}
				this.$http.post('/api/teacher/approval',parems).then(res =>{
					this.$toast(res.msg)
					let obj={
						classId:this.user.classId
					}
					this.$store.dispatch('user/getCorrectList', obj)
					setTimeout(() => {
						this.show = false;
						uni.reLaunch({
							url: '/pages/leave/index'
						})
					}, 2000)
				})
				
			},
			noClick(){
				this.show = true;
				this.content='是否不通过请假？'
				this.start='不通过'
			},
			yesClick(){
				this.show = true;
				this.content='是否通过请假？'
				this.start='已通过'
			},
			getProposal(data){
				let par=data.replace(/-/g,' ')
				this.highlist.forEach(item=>{
					if(par==item.area_name){
						this.proposal='高风险'
					}
				})
				this.middlelist.forEach(item=>{
					if(par==item.area_name){
						this.proposal='中风险'
					}
				})
			}
		},
		created() {
		}
	}
</script>

<style lang="scss" scoped>
.details{
	width: 100%;
	height: 100%;
	position: relative;
	.content{
		padding: 40rpx;
		.cell{
			margin: 20rpx 0;
			font-size: 36rpx;
		}
		.proposal{
			color: #aa0000;
		}
	}
	.bt{
		position: absolute;
		bottom: 0;
		height: 120rpx;
		background-color: #fff;
		align-items: center;
		left: 0;
		right: 0;
		display: flex;
		justify-content: space-around;
	}
}
</style>
