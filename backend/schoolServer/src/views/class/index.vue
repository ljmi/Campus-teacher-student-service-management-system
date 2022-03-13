<template>
	<div class="app-container">
		<div class="filter-container">
			<el-input v-model="searchValue" placeholder="班级名称或班级号" style="width: 200px;margin-right: 10px;"
				class="filter-item" @keyup.enter.native="handleFilter" />
		
			<el-select v-model="academy"  clearable placeholder="学院" class="filter-item" style="width: 400px;margin-right: 10px;">
				<el-option v-for="item in calendarTypeOptions" :key="item.key"
					:label="item.display_name+'('+item.key+')'" :value="item.key" />
			</el-select>
		
			<el-button class="filter-item" type="primary" icon="el-icon-search" @click="handleFilter">
				搜索
			</el-button>
			<el-button class="filter-item" style="margin-left: 10px;" type="primary" icon="el-icon-edit"
				@click="handleCreate">
				添加
			</el-button>
		</div>
		<el-table :data="tableData" style="width: 100%" v-loading="listLoading">
			<el-table-column prop="classId" label="班级号"  sortable fixed>
			</el-table-column>
			<el-table-column prop="name" label="班级名称"  sortable>
			</el-table-column>
			<el-table-column prop="majorName" label="专业"  sortable>
			</el-table-column>
			<el-table-column prop="academyName" label="二级学院"  sortable>
			</el-table-column>
			<el-table-column label="操作" fixed="right" width="150">
				<template slot-scope="scope">
					<el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
					<el-button size="mini" type="danger" @click="open(scope.$index, scope.row)">删除</el-button>
				</template>
			</el-table-column>
		</el-table>
		<el-pagination style="margin-top: 20px;" @size-change="handleSizeChange" @current-change="handleCurrentChange"
			:current-page="currentPage" :page-sizes="sizes" :page-size="100"
			layout="total, sizes, prev, pager, next, jumper" :total="total">
		</el-pagination>
		
		<el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible" @close="resetTemp">
			<el-form ref="temp" :model="temp" :rules="rules" label-position="left" label-width="70px"
				style="width: 400px; margin-left:50px;">
				<el-form-item label="院系专业">
					<el-cascader v-model="value" :options="academyoptions" @change="handleChange"
						style="width: 330px;margin-right: 5px;"></el-cascader>
				</el-form-item>
				<el-form-item label="班级号" prop="classId">
					<el-input v-model.number="temp.classId" :disabled="true" />
				</el-form-item>
				<el-form-item label="班级名称" prop="name">
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
	import classApi from '../../api/class.js'
	export default {
		name:"ClassIndex",
		data(){
			return{
				searchValue: undefined,
				academy: undefined,
				calendarTypeOptions: [],
				currentPage: 1,
				textMap: {
					update: '修改信息',
					create: '添加班级'
				},
				dialogStatus: '',
				dialogFormVisible: false,
				tableData: [],
				listLoading: false,
				sizes: [5, 10],
				total: 0,
				pageSize: 5,
				temp:{
					classId:'',
					name:'',
					majorId:'',
					academyId:'',
				},
				rules:{
					
				},
				value: [],
				academyoptions: [],
			}
		},
		methods:{
			handleDelete(index, row) {
				classApi.classsingleDel(row).then(res => {
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
			handleEdit(index, row) {
				console.log(row)
				this.value = []
				this.value[0] = row.academyId
				this.temp.academyId = row.academyId
				this.temp.classId = row.classId
				this.value[1] = row.majorId
				this.temp.majorId = row.majorId
				this.temp.name = row.name
				this.dialogStatus = 'update'
				this.$nextTick(() => {
					this.$refs['temp'].clearValidate()
				})
				this.dialogFormVisible = true
			},
			updateData(formName) {
				this.$refs[formName].validate((valid) => {
					if (valid) {
						classApi.classupdata(this.temp).then(res => {
			
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
			createData(formName) {
				this.$refs[formName].validate((valid) => {
					if (valid) {
						classApi.classsingleAdd(this.temp).then(res => {
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
			resetForm(formName) {
				this.$refs[formName].resetFields();
			},
			handleFilter() {
				this.currentPage = 1;
				this.getList(this.currentPage, this.pageSize, this.searchValue, this.academy);
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
			resetTemp() {
				this.value=[]
				this.temp = {
					classId:'',
					name:'',
					majorId:'',
					academyId:''
				}
			},
			handleCreate() {
				this.resetTemp()
				this.dialogStatus = 'create'
				this.$nextTick(() => {
					this.$refs['temp'].clearValidate()
				})
				this.dialogFormVisible = true
			},
			handleSizeChange(val) {
				this.pageSize = val;
				this.getList(this.currentPage, this.pageSize, this.searchValue, this.academy);
			},
			handleCurrentChange(val) {
				this.currentPage = val;
				this.getList(this.currentPage, this.pageSize, this.searchValue, this.academy);
			},
			getList(page, pageSize, searchValue, academyKey) {
				this.tableData = [];
				this.listLoading = true
				if (typeof(searchValue) != "undefined" && searchValue != "" && typeof(academyKey) != "undefined" && academyKey != "") {
					let data = {
						page,
						pageSize,
						searchValue,
						academyKey
					};
					classApi.searchunion(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
					})
				} else if (typeof(searchValue) != "undefined" && searchValue != "" && typeof(academyKey) == "undefined") {
					let data = {
						page,
						pageSize,
						searchValue
					};
					classApi.classSeach(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
					})
				} else if (typeof(academyKey) != "undefined" && academyKey != "" && typeof(searchValue) == "undefined") {
					let data = {
						page,
						pageSize,
						academyKey
					};
					classApi.getAcademyByClassSeach(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
					})
				} else {
					let data = {
						page,
						pageSize
					};
					classApi.pageList(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
					})
				}
				setTimeout(() => {
					this.listLoading = false
				}, 800)
			},
			handleChange(value) {
				this.temp.academyId = value[0]
				this.temp.majorId = value[1]
				this.temp.className=value[1].label
				if (this.dialogStatus == 'create') {
					this.getLastClassByMajorId(this.temp.majorId)
				}
				console.log(value)
			},
			getLastClassByMajorId(majorId) {
				let obj = {
					majorId
				}
				classApi.getLastClassByMajorId(obj).then(res => {
					this.temp.classId = res.data
					let year=res.data.substr(0,4)
					let c=res.data.charAt(res.data.length-1)
					this.temp.name=year+"级"+c+"班"
				})
			},
			cascade() {
				academyApi.cascadeMajorAndAcademy().then(res => {
					this.academyoptions = res.data;
				})
			},
		},
		created() {
			this.$store.dispatch('academy/getAcademy')
			this.calendarTypeOptions =this.$store.getters.academyList
			this.getList(this.currentPage, this.pageSize);
			this.cascade();
		}
	}
</script>

<style>
</style>
