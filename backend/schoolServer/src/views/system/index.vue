<template>
	<div class="app-container">
		<div class="filter-container">
			<el-input v-model="searchValue" placeholder="规则" style="width: 200px;margin-right: 10px;"
				class="filter-item" @keyup.enter.native="handleFilter" />

			<el-button class="filter-item" type="primary" icon="el-icon-search" @click="handleFilter">
				搜索
			</el-button>
			<el-button class="filter-item" style="margin-left: 10px;" type="primary" icon="el-icon-edit"
				@click="handleCreate">
				添加
			</el-button>
		</div>
		<el-table :data="tableData" style="width: 100%" v-loading="listLoading">
			<el-table-column prop="ruleName" label="规则" sortable fixed>
			</el-table-column>
			<el-table-column label="操作" fixed="right">
				<template slot-scope="scope">
					<el-button v-if="!scope.row.value" size="mini" type="success" @click="chageDelivery(scope.row)">
						启用
					</el-button>
					<el-button v-if="scope.row.value" size="mini" @click="chageDelivery(scope.row)">
						禁用
					</el-button>
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
			<el-form ref="temp" :model="temp" label-position="left">
				<el-form-item label="规则">
					<el-input v-model="temp.ruleName" type="textarea" />
				</el-form-item>
				
				<el-form-item label="开关" v-show="dialogStatus==='create'">
					<el-switch
					  v-model="temp.value"
					  active-color="#13ce66"
					  inactive-color="#ff4949" @change="changeSwitch">
					</el-switch>
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
	import systemApi from '@/api/system.js'
	export default {
		name: 'System',
		data() {
			return {
				searchValue: undefined,
				listLoading: false,
				tableData: [],
				currentPage: 1,
				sizes: [5, 10],
				total: 0,
				pageSize: 5,
				value: true,
				textMap: {
					update: '修改规则',
					create: '添加规则'
				},
				dialogStatus: '',
				dialogFormVisible: false,
				temp: {
					ruleName: '',
					value: true,
					settingsId:'',
					switchValue:0
				},
			}
		},
		methods: {
			changeSwitch(e){
				if(e){
					this.temp.switchValue=0
				}else{
					this.temp.switchValue=1
				}
			},
			resetTemp() {
				this.temp = {
					ruleName: '',
					value: true,
					settingsId:'',
					switchValue:0
				}
			},
			handleFilter() {
				this.currentPage = 1;
				this.getList(this.currentPage, this.pageSize, this.searchValue, this.academy);
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
				this.temp.ruleName = row.ruleName
				this.temp.settingsId = row.settingsId
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
			createData(formName) {
				systemApi.singleAdd(this.temp).then(res => {
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
					this.getList(this.currentPage, this.pageSize, this.searchValue);
					this.temp.content=''
					this.$nextTick(() => {
						this.$refs['temp'].clearValidate()
					})
					this.dialogFormVisible = false
				})
			},
			updateData(formName) {
				this.$refs[formName].validate((valid) => {
					if (valid) {
						systemApi.updata(this.temp).then(res => {
			
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
							this.getList(this.currentPage, this.pageSize, this.searchValue);
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
			handleDelete(index, row) {
				systemApi.singleDel(row).then(res => {
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
					this.getList(this.currentPage, this.pageSize, this.searchValue);
				})
			},
			handleSizeChange(val) {
				this.pageSize = val;
				this.getList(this.currentPage, this.pageSize, this.searchValue);
			},
			handleCurrentChange(val) {
				this.currentPage = val;
				this.getList(this.currentPage, this.pageSize, this.searchValue);
			},
			getList(page, pageSize, searchValue) {
				this.tableData = [];
				this.listLoading = true
				if (typeof(searchValue) != "undefined" && searchValue != "") {
					let data = {
						page,
						pageSize,
						searchValue
					};
					systemApi.search(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
					})
				} else {
					let data = {
						page,
						pageSize
					};
					systemApi.pageList(data).then(res => {
						this.total = res.data.total;
						this.tableData =[];
						res.data.items.forEach(item =>{
							let obj={
								value:'',
								ruleName:item.ruleName,
								settingsId:item.settingsId,
								switch:item.switch
							}
							if(item.switch==0){
								obj.value=true
							}else if(item.switch==1){
								obj.value=false
							}
							this.tableData.push(obj)
						})
					})
				}
				setTimeout(() => {
					this.listLoading = false
				}, 800)
			},
			chageDelivery(row) {
				row.value=!row.value
				systemApi.updataJurisdiction(row).then(res => {
					this.getList(this.currentPage, this.pageSize);
				})
			}
		},
		created() {
			this.getList(this.currentPage, this.pageSize);
		}
	}
</script>

<style>
</style>
