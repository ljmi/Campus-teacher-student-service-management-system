<template>
	<div class="app-container">
		<div class="filter-container">
			<el-input v-model="searchValue" placeholder="专业名称或专业代号" style="width: 200px;margin-right: 10px;"
				class="filter-item" @keyup.enter.native="handleFilter" />

			<el-select v-model="academy" clearable placeholder="学院" class="filter-item"
				style="width: 400px;margin-right: 10px;">
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
			<el-table-column prop="majorId" label="id" sortable fixed>
			</el-table-column>
			<el-table-column prop="specialtyCode" label="专业代号">
			</el-table-column>
			<el-table-column prop="name" label="专业名称" sortable>
			</el-table-column>
			<el-table-column prop="academyName" label="从属二级学院" sortable>
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
				<el-form-item label="id" prop="majorId">
					<el-input v-model.number="temp.majorId" :disabled="true" />
				</el-form-item>
				<el-form-item label="从属学院">
					<el-select v-model="temp.academyId" placeholder="请选择" class="filter-item" @change="handleChange"
						style="width: 330px;margin-right: 10px;">
						<el-option v-for="item in calendarTypeOptions" :key="item.key"
							:label="item.display_name+'('+item.key+')'" :value="item.key" />
						</el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="专业代号" prop="specialtyCode">
					<el-input v-model.number="temp.specialtyCode" />
				</el-form-item>
				<el-form-item label="专业名称" prop="name">
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
	import majorApi from '../../api/major.js'
	export default {
		name: 'Major',
		data() {
			var validateMajorId = (rule, value, callback) => {
				if (!value) {
					return callback(new Error('请选择学院生成id'));
				} else {
					callback();
				}
			};
			var validateName = (rule, value, callback) => {
				var reg = /[\u4e00-\u9fa5]+/g;
				if (!value) {
					return callback(new Error('请输入专业名称'));
				}
				if (!reg.test(value)) {
					callback(new Error('请输入中文字符'));
				} else {
					callback();
				}
			};
			var validateSpecialtyCode = (rule, value, callback) => {
				var reg = /^[0-9][a-zA-Z0-9]*$/;
				if (!value) {
					return callback(new Error('请输入专业代号'));
				}
				if (!reg.test(value)) {
					callback(new Error('请输入正确的专业代号'));
				} else {
					callback();
				}
			};
			return {
				searchValue: undefined,
				academy: undefined,
				calendarTypeOptions: [],
				currentPage: 1,
				sizes: [5, 10],
				total: 0,
				pageSize: 5,
				tableData: [],
				listLoading: false,
				dialogStatus: '',
				dialogFormVisible: false,
				temp: {
					academyId: '',
					name: '',
					specialtyCode: '',
					majorId: '',
				},
				textMap: {
					update: '修改信息',
					create: '添加专业'
				},
				rules: {
					majorId: [{
						validator: validateMajorId,
						trigger: 'blur'
					}],
					academyId: [{
						required: true,
						message: '请选择学院',
						trigger: 'blur'
					}],
					name: [{
						validator: validateName,
						trigger: 'blur'
					}],
					specialtyCode: [{
						validator: validateSpecialtyCode,
						trigger: 'blur'
					}],
				}
			}
		},
		methods: {
			createData(formName) {
				this.$refs[formName].validate((valid) => {
					if (valid) {
						majorApi.majorsingleAdd(this.temp).then(res => {
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
			updateData(formName) {
				this.$refs[formName].validate((valid) => {
					if (valid) {
						majorApi.majorupdata(this.temp).then(res => {

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
			handleEdit(index, row) {
				console.log(row)
				this.temp.specialtyCode = row.specialtyCode
				this.temp.name = row.name
				this.temp.academyId = row.academyId
				this.temp.majorId = row.majorId
				this.dialogStatus = 'update'
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
			handleFilter() {
				this.currentPage = 1;
				this.getList(this.currentPage, this.pageSize, this.searchValue, this.academy);
			},
			getList(page, pageSize, searchValue, academyKey) {
				this.tableData = [];
				this.listLoading = true
				if (typeof(searchValue) != "undefined" && searchValue != "" && typeof(academyKey) != "undefined" &&
					academyKey != "") {
					let data = {
						page,
						pageSize,
						searchValue,
						academyKey
					};
					majorApi.searchunion(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
					})
				} else if (typeof(searchValue) != "undefined" && searchValue != "" && typeof(academyKey) == "undefined") {
					let data = {
						page,
						pageSize,
						searchValue
					};
					majorApi.majorSeach(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
					})
				} else if (typeof(academyKey) != "undefined" && academyKey != "" && typeof(searchValue) == "undefined") {
					let data = {
						page,
						pageSize,
						academyKey
					};
					majorApi.getAcademyByMajorSeach(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
					})
				} else {
					let data = {
						page,
						pageSize
					};
					majorApi.pageList(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
					})
				}
				setTimeout(() => {
					this.listLoading = false
				}, 800)
			},
			resetTemp() {
				this.temp = {
					academyId: '',
					name: '',
					specialtyCode: '',
					majorId: '',
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
			handleChange(value) {
				console.log(value)
				this.temp.academyId = value
				if (this.dialogStatus == 'create') {
					this.getLastMajorByAcademy(this.temp.academyId)
				}

			},
			getLastMajorByAcademy(academyId) {
				let obj = {
					academyId
				}
				majorApi.getLastMajorByAcademy(obj).then(res => {
					console.log(res)
					this.temp.majorId = res.data
				})
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
				majorApi.majorsingleDel(row).then(res => {
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
		},
		created() {
			this.$store.dispatch('academy/getAcademy')
			this.calendarTypeOptions = this.$store.getters.academyList
			this.getList(this.currentPage, this.pageSize);
		}
	}
</script>

<style>
</style>
