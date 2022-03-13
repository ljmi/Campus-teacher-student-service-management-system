<template>
	<div class="app-container">
		<div class="filter-container">
			<el-input v-model="searchValue" placeholder="姓名或工号" style="width: 200px;margin-right: 10px;"
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
			<el-table-column prop="account" label="工号" width="180" sortable fixed>
			</el-table-column>
			<el-table-column prop="name" label="姓名" width="180">
			</el-table-column>
			<el-table-column prop="sex" label="性别" width="180" sortable>
			</el-table-column>
			<el-table-column prop="type" label="身份" width="180" sortable>
			</el-table-column>
			<el-table-column prop="classId" label="任课/管理班级" width="180" sortable>
			</el-table-column>
			<!-- <el-table-column label="管理班级" width="200">
				<template slot-scope="{row}">
					<el-tag :type="row.status | statusFilter">
						{{ row.status }}
					</el-tag>
				</template>
			</el-table-column> -->
			<el-table-column prop="academyName" label="从属二级学院" width="180" sortable>
			</el-table-column>
			<el-table-column prop="mail" label="邮箱" width="180">
			</el-table-column>
			<el-table-column prop="phone" label="联系方式" width="180">
			</el-table-column>
			<el-table-column prop="address" label="联系地址" width="180">
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
				<el-form-item label="院系">
					<el-select v-model="temp.academyId" placeholder="学院" class="filter-item"
						style="width: 330px;margin-right: 10px;" @change="handleChange">
						<el-option v-for="item in academyoptions" :key="item.key"
							:label="item.display_name+'('+item.key+')'" :value="item.key" />
					</el-select>
				</el-form-item>
				<el-form-item label="工号" prop="account">
					<el-input v-model.number="temp.account" :disabled="true" />
				</el-form-item>
				<el-form-item label="姓名" prop="name">
					<el-input v-model="temp.name" />
				</el-form-item>
				<el-form-item label="密码" prop="password">
					<el-input placeholder="请输入密码" v-model="temp.password" show-password></el-input>
				</el-form-item>
				<el-form-item label="性别" prop="sex">
					<el-select v-model="temp.sex" placeholder="请选择" class="filter-item"
						style="width: 330px;margin-right: 10px;">
						<el-option v-for="item in options" :key="item.value" :label="item.value" :value="item.value">
						</el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="身份" prop="type">
					<el-select v-model="temp.type" placeholder="请选择" class="filter-item"
						style="width: 330px;margin-right: 10px;">
						<el-option v-for="item in typeOptions" :key="item.value" :label="item.value" :value="item.value">
						</el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="管理班级">
					<el-cascader v-model="temp.class" :options="classOptions" :props="props" :show-all-levels="false"
						clearable separator style="width: 330px;margin-right: 10px;" @change="changeClass">
					</el-cascader>
				</el-form-item>
				<el-form-item label="邮箱" prop="mail">
					<el-input v-model="temp.mail" />
				</el-form-item>
				<el-form-item label="联系方式" >
					<el-input v-model.number="temp.phone" />
				</el-form-item>
				<el-form-item label="联系地址">
					<el-input v-model="temp.address" />
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
	import academyApi from '../../api/academy'
	import teacherApi from '../../api/teacher'
	export default {
		name: 'Teacher',
		filters: {
			statusFilter(status) {
				const statusMap = {
					published: 'success',
					draft: 'info',
					deleted: 'danger'
				}
				return statusMap[status]
			}
		},
		data() {
			var validateAccount = (rule, value, callback) => {
				if (!value) {
					return callback(new Error('请选择院系班级生成学号'));
				} else {
					callback();
				}
			};
			var validateName = (rule, value, callback) => {
				var reg = /^[\u4e00-\u9fa5]{2,5}$/;
				if (!value) {
					return callback(new Error('请输入姓名'));
				}
				if (!reg.test(value)) {
					callback(new Error('请输入2-5位中文字符'));
				} else {
					callback();
				}
			};
			var validatePhone = (rule, value, callback) => {
				var reg = /^1(3[0-9]|4[5,7]|5[0,1,2,3,5,6,7,8,9]|6[2,5,6,7]|7[0,1,7,8]|8[0-9]|9[1,8,9])\d{8}$/;

				if (value || value != '') {
					if (!reg.test(value)) {
						callback(new Error('请输入正确的手机号码'));
					} else {
						callback();
					}
				} else {
					callback();
				}

			};
			return {
				searchValue: undefined,
				academy: undefined,
				calendarTypeOptions: [],
				tableData: [],
				listLoading: false,
				currentPage: 1,
				sizes: [5, 10],
				total: 0,
				pageSize: 5,
				temp: {
					academyId: '',
					academyName: '',
					account: '',
					address: '',
					headImg: '',
					mail: '',
					name: '',
					phone: '',
					sex: '',
					teacherId: '',
					password: '',
					class: [],
					classString: '',
					type:''
				},
				dialogStatus: '',
				dialogFormVisible: false,
				options: [{
					value: '男'
				}, {
					value: '女'
				}],
				typeOptions: [{
					value: '教职工'
				}, {
					value: '辅导员'
				}],
				textMap: {
					update: '修改信息',
					create: '添加教职工'
				},
				rules: {
					account: [{
						validator: validateAccount,
						trigger: 'blur'
					}],
					sex: [{
						required: true,
						message: '请选择性别',
						trigger: 'blur'
					}],
					type: [{
						required: true,
						message: '请选择身份',
						trigger: 'blur'
					}],
					name: [{
						validator: validateName,
						trigger: 'blur'
					}],
					mail: [{
						type: 'email',
						message: '请输入正确的邮箱地址',
						trigger: ['blur', 'change']
					}],
					phone: [{
						validator: validatePhone,
						trigger: 'blur'
					}],
				},
				academyoptions: [],
				props: {
					multiple: true
				},
				classOptions: []
			}
		},
		methods: {
			handleFilter() {
				this.currentPage = 1;
					this.getList(this.currentPage, this.pageSize, this.searchValue, this.academy);
			},
			resetForm(formName) {
				this.$refs[formName].resetFields();
			},
			resetTemp() {
				this.temp = {
					academyId: '',
					academyName: '',
					account: '',
					address: '',
					headImg: '',
					mail: '',
					majorId: '',
					majorName: '',
					name: '',
					phone: '',
					sex: '男',
					teacherId: '',
					password: '',
					class: [],
					classString: '',
					type:'教职工'
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
			handleEdit(index, row) {
				console.log(row)
				this.temp.academyId = row.academyId
				this.temp.account = row.account
				this.temp.address = row.address
				this.temp.headImg = row.headImg
				this.temp.mail = row.mail
				this.temp.name = row.name
				this.temp.phone = row.phone
				this.temp.sex = row.sex
				this.temp.teacherId = row.teacherId
				this.temp.password = row.password
				this.temp.type = row.type
				this.temp.class=[]
				this.temp.class.push(row.classId)
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
				teacherApi.teachersingleDel(row).then(res => {
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
			handleSizeChange(val) {
				this.pageSize = val;
				this.getList(this.currentPage, this.pageSize, this.searchValue, this.academy);
			},
			handleCurrentChange(val) {
				this.currentPage = val;
				this.getList(this.currentPage, this.pageSize, this.searchValue, this.academy);
			},
			createData(formName) {
				this.$refs[formName].validate((valid) => {
					if (valid) {
						teacherApi.singleAdd(this.temp).then(res => {
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
						teacherApi.teacherupdata(this.temp).then(res => {

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
			handleChange(value) {
				if (this.dialogStatus==='create') {
					var d = new Date();
					let year = d.getFullYear();
					this.temp.account = year + value
					this.getLastTeacherByAcademyId(value)
				}
			},
			getLastTeacherByAcademyId(value) {
				let obj = {
					academyId: value
				}
				teacherApi.getLastTeacherByAcademyId(obj).then(res => {
						this.temp.account = res.data
				})
			},
			cascade() {
				academyApi.cascade().then(res => {
					this.classOptions = res.data;
				})
			},
			changeClass() {
				this.temp.classString = ''
				this.temp.class.forEach(item => {
					if (this.temp.classString == '') {
						this.temp.classString = item[2]
					} else {
						this.temp.classString = this.temp.classString + "," + item[2]
					}

				})
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
					teacherApi.searchunion(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
					})
				} else if (typeof(searchValue) != "undefined" && searchValue != "" && typeof(academyKey) == "undefined") {
					let data = {
						page,
						pageSize,
						searchValue
					};
					teacherApi.teacherSeach(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
					})
				} else if (typeof(academyKey) != "undefined" && academyKey != "" && typeof(searchValue) == "undefined") {
					let data = {
						page,
						pageSize,
						academyKey
					};
					teacherApi.getacademyByTeacherSeach(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
					})
				} else {
					let data = {
						page,
						pageSize
					};
					teacherApi.pageList(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
						// console.log(this.tableData)
						// this.tableData.forEach((item,$index) =>{
						// 	var sArr = item.classId.split(",");
						// 	for(var i=0; i < sArr.length; i++){
						// 		console.log($index+":"+sArr[i])
						// 	}
						// })
					})
				}

				setTimeout(() => {
					this.listLoading = false
				}, 800)
			},
		},
		created() {
			this.$store.dispatch('academy/getAcademy')
			this.cascade()
			this.calendarTypeOptions = this.$store.getters.academyList
			this.academyoptions = this.$store.getters.academyList
			this.getList(this.currentPage, this.pageSize);
		}
	}
</script>

<style>
</style>
