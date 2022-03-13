<template>
	<div class="app-container">
		<div class="filter-container">
			<el-button class="filter-item" style="margin-left: 10px;" type="primary" icon="el-icon-edit"
				@click="handleCreate">
				添加
			</el-button>
		</div>
		<el-table :data="tableData" v-loading="listLoading">
			<el-table-column prop="academyId" label="代号" sortable fixed>
			</el-table-column>
			<el-table-column prop="name" label="名称">
			</el-table-column>
			<el-table-column label="操作" fixed="right" width="150">
				<template slot-scope="scope">
					<el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
					<el-button size="mini" type="danger" @click="open(scope.$index, scope.row)">删除</el-button>
				</template>
			</el-table-column>
		</el-table>
		<el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible" @close="resetTemp">
			<el-form ref="temp" :model="temp" :rules="rules" label-position="left" label-width="70px"
				style="width: 400px; margin-left:50px;">
				<el-form-item label="代号" prop="academyId">
					<el-input v-model.number="temp.academyId" :disabled="true" />
				</el-form-item>
				<el-form-item label="名字" prop="name">
					<el-input v-model="temp.name" />
				</el-form-item>
			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button @click="dialogFormVisible = false">
					取消
				</el-button>
				<el-button type="primary" @click="dialogStatus==='create'?createData('temp'):updateData('temp')">
					确认
				</el-button>
			</div>
		</el-dialog>
		
	</div>
</template>

<script>
	import academyApi from '../../api/academy.js'
	export default {
		name: 'Academy',
		data() {
			return {
				dialogStatus: '',
				dialogFormVisible: false,
				tableData: [],
				listLoading: false,
				textMap: {
					update: '修改信息',
					create: '添加学院'
				},
				temp: {
					academyId: '',
					name: ''
				},
				rules:{
					name: [{
						required: true,
						message: '请输入二级院校名称',
						trigger: 'blur'
					}],
				},
			}
		},
		methods: {
			resetForm(formName) {
				this.$refs[formName].resetFields();
			},
			handleCreate() {
				this.resetTemp()
				this.dialogStatus = 'create'
				this.$nextTick(() => {
					this.$refs['temp'].clearValidate()
				})
				this.dialogFormVisible = true
			},
			resetTemp() {
				this.temp = {
					academyId: '',
					name: ''
				}
				academyApi.getLastAcademyId().then(res =>{
					this.temp.academyId=res.data
				})
				console.log(this.temp)
				
			},
			handleEdit(index, row) {
				console.log(row)
				this.temp.academyId = row.academyId
				this.temp.name = row.name
				this.dialogStatus = 'update'
				this.$nextTick(() => {
					this.$refs['temp'].clearValidate()
				})
				this.dialogFormVisible = true
			},
			open(index, row) {
				this.$confirm('此操作将永久删除该记录, 是否继续?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.handleDelete(index, row);
				}).catch(() => {
					this.$message({
						type: 'info',
						message: '已取消删除'
					});
				});
			},
			handleDelete(index, row) {
				academyApi.academysingleDel(row).then(res => {
					if (res.code == 200) {
						this.$message({
							showClose: true,
							message: res.msg,
							type: 'success'
						});
					} else {
						console.log(res)
						this.$message({
							showClose: true,
							message: res.msg,
							type: 'error'
						});
					}
					this.getList(this.currentPage, this.pageSize, this.searchValue, this.academy);
				})
			},
			createData(formName) {
				console.log(this.temp)
				this.$refs[formName].validate((valid) => {
					if (valid) {
						academyApi.singleAdd(this.temp).then(res => {
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
							this.getList();
							this.$nextTick(() => {
								this.$refs['temp'].clearValidate()
							})
							this.dialogFormVisible = false
						})
					} else {
						return false;
					}
				});
			
			},
			updateData(formName) {
				this.$refs[formName].validate((valid) => {
					if (valid) {
						academyApi.academyupdata(this.temp).then(res => {
			
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
							this.getList(this.currentPage, this.pageSize, this.searchValue, this.academy);
							this.$nextTick(() => {
								this.$refs['temp'].clearValidate()
							})
							this.dialogFormVisible = false
						})
					} else {
						return false;
					}
				});
			
			},
			getList(){
				academyApi.academyAll().then(res =>{
					this.tableData=res.data
				})
			}
		},
		created() {
			this.getList()
		}
	}
</script>

<style>
</style>
