<template>
	<div class="app-container" v-loading.fullscreen.lock="uploadLoading">
		<upload-excel-component :on-success="handleSuccess" :before-upload="beforeUpload" v-loading.fullscreen.lock="uploadLoading"/>
		<el-table :data="tableData" border highlight-current-row style="width: 100%;margin-top:20px;">
		  <el-table-column v-for="item of tableHeader" :key="item" :prop="item" :label="item" />
		</el-table>
	</div>
</template>

<script>
	import studentApi from '@/api/student.js'
	import UploadExcelComponent from '@/components/UploadExcel/index.vue'
	export default {
		name: 'StudentImport',
		components: { UploadExcelComponent },
		data() {
		  return {
			  tableData: [],
			  tableHeader: [],
			uploadLoading: false,
		  }
		},
		methods: {
		  beforeUpload(file) {
			 this.uploadLoading=true
		    const isLt25M = file.size / 1024 / 1024 < 25
		
		    if (isLt25M) {
			this.uploadLoading=false
		      return true
		    }
		
		    this.$message({
		      message: '请不要上传大于25m的文件.',
		      type: 'warning'
		    })
			this.uploadLoading=false
		    return false
		  },
		  handleSuccess({ results, header }) {
			  this.tableHeader = header
			  this.uploadLoading=true
			  var num=0;
			header.forEach(item=>{
				if(item=="account" || item=="name" || item=="sex" || item=="classId" || item=="majorId" || item=="academyId"){
					num++
				}
			})
			if(num!=header.length){
				this.$message({
					showClose: true,
					message: "请上传标准内容格式文件",
					type: 'error'
				});
				this.uploadLoading=false
			}else{
				
				studentApi.batchAddStudent(results).then(res=>{
					if (res.code == 200) {
						this.$message({
							showClose: true,
							message: res.msg,
							type: 'success'
						});
					} else {
						this.$message({
							showClose: true,
							message: res.msg,
							type: 'error'
						});
					}
					console.log(res)
				})
				this.uploadLoading=false
				console.log(results)
			}
		  }
		}
	}
</script>

<style>
	.app-container{
		width: 100%;
		height: 100%;
	}
</style>
