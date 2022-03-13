<template>
	<div class="app-container">
		<div class="filter-container">
			<el-input v-model="searchValue" placeholder="公告标题" style="width: 200px;margin-right: 10px;"
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
			<el-table-column prop="title" label="标题" sortable fixed>
			</el-table-column>
			<el-table-column prop="createTime" label="添加时间">
			</el-table-column>
			<el-table-column label="操作" fixed="right">
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
			<el-form ref="temp" :model="temp" label-position="left">
				<el-form-item label="标题">
					<el-input v-model="temp.title" type="textarea" />
				</el-form-item>
				<el-form-item label="内容">
					<tinymce v-model="temp.content" :height="300" />
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
	</div>
</template>

<script>
	import Tinymce from '@/components/Tinymce'
	import noticeApi from '@/api/notice.js'
	import moment from 'moment'
	export default {
		name: "Notice",
		components: {
			Tinymce
		},
		data() {
			return {
				searchValue: undefined,
				listLoading: false,
				tableData: [],
				currentPage: 1,
				sizes: [5, 10],
				total: 0,
				pageSize: 5,
				textMap: {
					update: '修改公告',
					create: '添加公告'
				},
				dialogStatus: '',
				dialogFormVisible: false,
				temp: {
					title: '',
					content: '',
					noticeId:''
				},

			}
		},
		methods: {
			resetTemp() {
				this.temp = {
					title: '',
					content: '',
					noticeId:''
				}
			},
			resetForm(formName) {
				this.$refs[formName].resetFields();
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
				this.temp.title = row.title
				this.temp.noticeId = row.noticeId
				this.temp.content = row.content
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
				noticeApi.singleDel(row).then(res => {
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
			createData(formName) {
				noticeApi.singleAdd(this.temp).then(res => {
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
						noticeApi.updata(this.temp).then(res => {
			
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
			getList(page, pageSize, searchValue) {
				this.tableData = [];
				this.listLoading = true
				if (typeof(searchValue) != "undefined" && searchValue != "") {
					let data = {
						page,
						pageSize,
						searchValue
					};
					noticeApi.search(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
					})
				} else {
					let data = {
						page,
						pageSize
					};
					noticeApi.pageList(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
						this.tableData.forEach(item=>{
							let type='YYYY-MM-DD'
							item.createTime=moment(item.createTime).format(type)
						})
					})
				}
				setTimeout(() => {
					this.listLoading = false
				}, 800)
			},
		},
		created() {
			this.getList(this.currentPage, this.pageSize);
		}
	}
</script>

<style>
</style>
