<template>
	<div class="app-container">
		<div class="filter-container">
			<el-input v-model="searchValue" placeholder="姓名或学号" style="width: 200px;margin-right: 10px;"
				class="filter-item" @keyup.enter.native="handleFilter" />

			<el-select v-model="academy" @clear="clearAcademy" clearable placeholder="学院" class="filter-item"
				style="width: 400px;margin-right: 10px;">
				<el-option v-for="item in calendarTypeOptions" :key="item.key"
					:label="item.display_name+'('+item.key+')'" :value="item.key" />
			</el-select>

			<el-button class="filter-item" type="primary" icon="el-icon-search" @click="handleFilter">
				搜索
			</el-button>
		</div>
		
		<el-table :data="tableData" style="width: 100%" v-loading="listLoading">
			<el-table-column prop="account" label="学号" width="180" sortable fixed>
			</el-table-column>
			<el-table-column prop="name" label="姓名" width="180">
			</el-table-column>
			<el-table-column prop="className" label="班级" width="180" sortable>
			</el-table-column>
			<el-table-column prop="majorName" label="专业" width="180" sortable>
			</el-table-column>
			<el-table-column prop="academyName" label="二级学院" width="180" sortable>
			</el-table-column>
			<el-table-column prop="type" label="请假类型" width="180" sortable>
			</el-table-column>
			<el-table-column prop="state" label="当前状态" width="180" sortable>
			</el-table-column>
			<el-table-column label="操作" fixed="right" width="150">
				<template slot-scope="scope">
					<el-button size="mini" @click="handleEdit(scope.$index, scope.row)">查看</el-button>
					<el-button size="mini" type="danger" @click="open(scope.$index, scope.row)">删除</el-button>
				</template>
			</el-table-column>
		</el-table>
		
		
		<el-pagination style="margin-top: 20px;" @size-change="handleSizeChange" @current-change="handleCurrentChange"
			:current-page="currentPage" :page-sizes="sizes" :page-size="100"
			layout="total, sizes, prev, pager, next, jumper" :total="total">
		</el-pagination>
		
		<el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
			<el-form ref="temp" :model="temp" label-position="left" label-width="70px"
				style="width: 400px; margin-left:50px;">
				<el-form-item label="学号">
					<el-input v-model.number="temp.account" :disabled="true" />
				</el-form-item>
				<el-form-item label="姓名">
					<el-input v-model="temp.name" :disabled="true" />
				</el-form-item>
				<el-form-item label="院系班级">
					<el-input v-model="temp.academyandclass" type="textarea"  :disabled="true" />
				</el-form-item>
				<el-form-item label="请假事由">
					<el-input v-model="temp.reason" type="textarea" :disabled="true" />
				</el-form-item>
				<el-form-item label="请假时间">
					<el-input v-model="temp.time" :disabled="true" />
				</el-form-item>
				<el-form-item label="通知老师" v-show="this.temp.teacherAccount!=''">
					<el-input v-model="temp.teacherName" :disabled="true" />
				</el-form-item>
				<el-form-item label="请假类型">
					<el-input v-model="temp.type" :disabled="true" />
				</el-form-item>
				<el-form-item label="前往地区" v-show="this.temp.type=='外出'">
					<el-input v-model="temp.region" :disabled="true" />
				</el-form-item>
				<el-form-item label="详细地址" v-show="this.temp.type=='外出'">
					<el-input v-model="temp.address" :disabled="true" />
				</el-form-item>
				<el-form-item label="联系人" v-show="this.temp.type=='外出'">
					<el-input v-model="temp.contacts" :disabled="true" />
				</el-form-item>
				<el-form-item label="联系人电话" v-show="this.temp.type=='外出'">
					<el-input v-model="temp.phone" :disabled="true" />
				</el-form-item>
			</el-form>
		</el-dialog>
	</div>
</template>

<script>
	import leaveApi from '@/api/leave.js'
	export default {
		name: 'Leave',
		data() {
			return {
				searchValue: undefined,
				academy: undefined,
				calendarTypeOptions: [],
				dialogFormVisible: false,
				listLoading: false,
				currentPage: 1,
				sizes: [5, 10],
				total: 0,
				pageSize: 5,
				tableData: [],
				textMap: {
					update: '查看信息'
				},
				dialogStatus: '',
				temp: {
					academy: '',
					academyandclass:'',
					academyId: '',
					academyName: '',
					account: '',
					address: '',
					classId: '',
					className: '',
					contacts: '',
					createTime: '',
					endTime: '',
					instructor: '',
					leaveId: '',
					majorId: '',
					majorName: '',
					name: '',
					phone: '',
					reason: '',
					region: '',
					startTime: '',
					state: '',
					teacherAccount: '',
					teacherName: '',
					type:'',
					time:''
				},
			}
		},
		methods:{
			resetForm(formName) {
				this.$refs[formName].resetFields();
			},
			handleEdit(index, row) {
				console.log(row)
				this.temp.academy = row.academy
				this.temp.academyandclass = row.academyName+"-"+row.majorName+"-"+row.className
				this.temp.account = row.account
				this.temp.address = row.address
				this.temp.contacts = row.contacts
				this.temp.leaveId = row.leaveId
				this.temp.name = row.name
				this.temp.phone = row.phone
				this.temp.reason = row.reason
				this.temp.region = row.region
				this.temp.time = row.startTime+"-"+row.endTime
				this.temp.state = row.state
				this.temp.teacherAccount = row.teacherAccount
				this.temp.teacherName = row.teacherName
				this.temp.type = row.type
				this.dialogStatus = 'update'
				this.dialogFormVisible = true
			},
			handleFilter() {
				this.currentPage = 1;
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
					leaveApi.searchunion(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
					})
				} else if (typeof(searchValue) != "undefined" && searchValue != "" && typeof(academyKey) == "undefined") {
					let data = {
						page,
						pageSize,
						searchValue
					};
					leaveApi.leaveSeach(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
					})
				} else if (typeof(academyKey) != "undefined" && academyKey != "" && typeof(searchValue) == "undefined") {
					let data = {
						page,
						pageSize,
						academyKey
					};
					leaveApi.getAcademyBylLeaveSeach(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
					})
				} else {
					let data = {
						page,
						pageSize
					};
					leaveApi.pageList(data).then(res => {
						this.total = res.data.total;
						this.tableData = res.data.items;
						console.log(res)
					})
				}
				setTimeout(() => {
					this.listLoading = false
				}, 800)
			},
			handleSizeChange(val) {
				this.pageSize = val;
				this.getList(this.currentPage, this.pageSize, this.searchValue, this.academy);
			},
			handleCurrentChange(val) {
				this.currentPage = val;
				this.getList(this.currentPage, this.pageSize, this.searchValue, this.academy);
			},
			clearAcademy(){
				this.academy=undefined
			}
		},
		created() {
			this.$store.dispatch('academy/getAcademy')
			this.calendarTypeOptions =this.$store.getters.academyList
			this.getList(this.currentPage, this.pageSize);
		}
	}
</script>

<style>
</style>
