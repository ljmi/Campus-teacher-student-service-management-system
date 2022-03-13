<template>
	<view class="settings status_bar">
		<Tittle :title="title"></Tittle>
		<navigator url="./information">
		<view class="u-flex user-box u-p-l-30 u-p-r-20 u-p-b-30">
			
			<view class="u-m-r-10">
				<u-avatar :src="user.headImg" size="140"></u-avatar>
			</view>
			<view class="u-flex-1">
				
				<view class="u-font-18 u-p-b-20">{{user.name}}</view>
				<view class="u-font-14 u-tips-color" v-if="userType==1">学号:{{user.account}}</view>
				<view class="u-font-14 u-tips-color" v-else>工号:{{user.account}}</view>
			</view>
			
			<view class="u-m-l-10 u-p-10">
				<u-icon name="arrow-right" color="#969799" size="28"></u-icon>
			</view>
		</view>
		</navigator>
		
		<navigator url="./settings">
		<view class="u-m-t-20">
			<u-cell-group>
				<u-cell-item icon="setting" title="设置"></u-cell-item>
			</u-cell-group>
		</view>
		</navigator>
	</view>
</template>

<script>
	import {mapState} from 'vuex';
	import Tittle from "../../components/title.vue"
	export default {
		data() {
			return {
				title:"个人中心",
				identity:'学生',
			};
		},
		components:{
			Tittle
		},
		computed:{
			...mapState('user', ['user']),
			...mapState('user', ['userType']),
		}
	}
</script>

<style lang="scss" scoped>
.settings{
	width: 100%;
	height: 100%;
	// background-color: #ededed;
}
.user-box{
	background-color: #fff;
}
</style>
