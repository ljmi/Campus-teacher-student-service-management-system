<template>
	<div class="app-container">
		<div class="filter-container">
			<el-button class="filter-item" style="margin-left: 10px;" type="primary" icon="el-icon-edit"
				@click="handleCreate">
				添加
			</el-button>
		</div>
		<el-table :data="tableData" v-loading="listLoading">
			<el-table-column prop="account" label="账号" sortable fixed>
			</el-table-column>
			<el-table-column prop="name" label="姓名">
			</el-table-column>
			<el-table-column prop="sex" label="性别">
			</el-table-column>
			<el-table-column label="操作" fixed="right">
				<template slot-scope="scope">
					<el-button v-if="!scope.row.delivery" size="mini" type="success" @click="chageDelivery(scope.row)">
						启用
					</el-button>
					<el-button v-if="scope.row.delivery" size="mini" @click="chageDelivery(scope.row)">
						禁用
					</el-button>
					<el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
					<el-button size="mini" type="danger" @click="open(scope.$index, scope.row)">删除</el-button>
				</template>
			</el-table-column>
		</el-table>
		<el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible" @close="resetTemp">
			<el-form ref="temp" :model="temp" :rules="rules" label-position="left" label-width="70px"
				style="width: 400px; margin-left:50px;">
				<el-form-item label="id" prop="adminId">
					<el-input v-model.number="temp.adminId" :disabled="true" />
				</el-form-item>
				<el-form-item label="账号" prop="account">
					<el-input v-model.number="temp.account" />
				</el-form-item>
				<el-form-item label="姓名" prop="name">
					<el-input v-model="temp.name" />
				</el-form-item>
				<el-form-item label="性别" prop="sex">
					<el-select v-model="temp.sex" placeholder="请选择" class="filter-item"
						style="width: 330px;margin-right: 10px;">
						<el-option v-for="item in options" :key="item.value" :label="item.value" :value="item.value">
						</el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="是否启用">
					<el-switch v-model="temp.delivery" @change="changeDelivery"></el-switch>
				</el-form-item>
				<el-form-item label="邮箱" prop="mail">
					<el-input v-model="temp.mail" />
				</el-form-item>
				<el-form-item label="联系方式">
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
	import userApi from '@/api/user.js'
	export default {
		name: 'Admin',
		data() {
			var validateAccount = (rule, value, callback) => {
				var reg = /^[0-9]*$/;
				if (!value) {
					return callback(new Error('请输入账号'));
				} else if (!reg.test(value)) {
					callback(new Error('请输入数字类型的账号'));
				} else {
					callback();
				}
			};
			return {
				account: '',
				tableData: [],
				listLoading: false,
				dialogStatus: '',
				dialogFormVisible: false,
				textMap: {
					update: '修改信息',
					create: '添加管理员'
				},
				temp: {
					account: '',
					adminId: '',
					name: '',
					sex: '',
					address: '',
					mail: '',
					phone: '',
					delivery: true,
					jurisdiction: 1,
					headImg:'',
					password: ''
				},
				rules: {
					account: [{
						validator: validateAccount,
						trigger: 'blur'
					}],
					name: [{
						required: true,
						message: '请输入管理员姓名',
						trigger: 'blur'
					}],
				},
				options: [{
					value: '男'
				}, {
					value: '女'
				}],
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
					account: '',
					adminId: '',
					name: '',
					sex: '男',
					address: '',
					mail: '',
					phone: '',
					delivery: true,
					jurisdiction: 1,
					headImg:'',
					password: ''
				}
				userApi.getLastAdminId().then(res => {
					this.temp.adminId = res.data
				})

			},
			handleEdit(index, row) {
				this.temp.account = row.account
				this.temp.name = row.name
				this.temp.adminId = row.adminId
				this.temp.sex = row.sex
				this.temp.address = row.address
				this.temp.mail = row.mail
				this.temp.phone = row.phone
				this.temp.delivery = row.delivery
				this.temp.jurisdiction = row.jurisdiction
				this.temp.headImg = row.headImg
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
				userApi.singleDel(row).then(res => {
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
					this.getList();
				})
			},
			changeDelivery(e) {
				if (e) {
					this.temp.jurisdiction = 1
				} else {
					this.temp.jurisdiction = 2
				}
			},
			createData(formName) {
				console.log(this.temp)
				this.$refs[formName].validate((valid) => {
					if (valid) {
						userApi.singleAdd(this.temp).then(res => {
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
						userApi.updata(this.temp).then(res => {

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
			getList() {
				userApi.getUserList().then(res => {
					this.tableData = res.data
					this.tableData.forEach((item, index) => {
						if (item.account == this.account) {
							this.tableData.splice(index, 1)
						}
					})
				})
			},
			chageDelivery(row) {
				userApi.updataJurisdiction(row).then(res => {
					this.getList()
				})
			}
		},
		created() {
			this.getList()
			this.account = this.$store.getters.account
		}
	}
</script>

<style>
</style>
