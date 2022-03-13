<template>
	<view class="information status_bar">
		<view class="u-m-t-20">
			<u-cell-group>
				<u-cell-item title="头像">
					<view class="u-m-r-10">
						<navigator url='./imgPage'>
						<u-avatar :src="user.headImg" size="140"></u-avatar>
						</navigator>
					</view>
				</u-cell-item>
				<u-cell-item title="姓名">
					<view class="u-m-r-10">
						{{user.name}}
					</view>
				</u-cell-item>
				<u-cell-item :title="userType==1?'学号':'工号'">
					<view class="u-m-r-10">
						{{user.account}}
					</view>
				</u-cell-item>
				<u-cell-item title="性别">
					<view class="u-m-r-10">
						{{user.sex}}
					</view>
				</u-cell-item>
				<u-cell-item title="学院">
					<view class="u-m-r-10">
						{{user.academyName}}
					</view>
				</u-cell-item>
				<u-cell-item title="专业" v-if="userType==1">
					<view class="u-m-r-10">
						{{user.majorName}}
					</view>
				</u-cell-item>
				<u-cell-item title="班级" v-if="userType==1">
					<view class="u-m-r-10">
						{{user.className}}
					</view>
				</u-cell-item>
			</u-cell-group>
		</view>
	</view>
</template>

<script>
	import {
		mapState
	} from 'vuex';
	export default {
		data() {
			return {
				pic: 'https://uviewui.com/common/logo.png',
			};
		},
		computed:{
			...mapState('user',['userType']),
			...mapState('user',['user']),
		},
		onLoad() {
		}
	}
</script>

<style lang="scss" scoped>
	.information {}
</style>
