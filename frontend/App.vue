<script>
	export default {
		onLaunch: function() {
			
			// 在页面加载时读取sessionStorage里的状态信息
			if (sessionStorage.getItem("store") ) {
			    this.$store.replaceState(Object.assign({}, this.$store.state,JSON.parse(sessionStorage.getItem("store"))))
			} 
						
			// 在页面刷新时将vuex里的信息保存到sessionStorage里
			window.addEventListener("beforeunload",()=>{
			    sessionStorage.setItem("store",JSON.stringify(this.$store.state))
			})
		},
		onShow: function() {
		},
		onHide: function() {
		}
	}
</script>

<style lang="scss">
	/*每个页面公共css */
	/* 引入uviewUi*/
	@import "uview-ui/index.scss";

	/* 状态栏高度 */
	.status_bar {
		height: var(--status-bar-height);
		width: 100%;
	}
	uni-page-body,#app {height: 100%;}
	
</style>
