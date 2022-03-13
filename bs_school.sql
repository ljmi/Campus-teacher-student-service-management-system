
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

drop database  IF EXISTS bs_school;
create database bs_school CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';
use bs_school;

-- ----------------------------
-- Table structure for tb_academy
-- ----------------------------
DROP TABLE IF EXISTS `tb_academy`;
CREATE TABLE `tb_academy`  (
  `academyId` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` char(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`academyId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_academy
-- ----------------------------
INSERT INTO `tb_academy` VALUES ('01', '宝石与艺术设计学院');
INSERT INTO `tb_academy` VALUES ('02', '外国语学院');
INSERT INTO `tb_academy` VALUES ('03', '商学院');
INSERT INTO `tb_academy` VALUES ('04', '机械与材料工程学院、化学工程与资源再利用学院');
INSERT INTO `tb_academy` VALUES ('05', '教师教育学院');
INSERT INTO `tb_academy` VALUES ('06', '大数据与软件工程学院');
INSERT INTO `tb_academy` VALUES ('07', '电子与信息工程学院');
INSERT INTO `tb_academy` VALUES ('08', '文学与传媒学院');
INSERT INTO `tb_academy` VALUES ('09', '法学与公共管理学院');
INSERT INTO `tb_academy` VALUES ('10', '马克思主义学院');
INSERT INTO `tb_academy` VALUES ('11', '继续教育学院、高等职业技术学院');

-- ----------------------------
-- Table structure for tb_admin
-- ----------------------------
DROP TABLE IF EXISTS `tb_admin`;
CREATE TABLE `tb_admin`  (
  `adminId` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '123456',
  `name` char(6) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `headImg` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `mail` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sex` enum('男','女') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `createTime` datetime(0) NOT NULL,
  `phone` char(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `jurisdiction` int(1) NOT NULL,
  PRIMARY KEY (`adminId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_admin
-- ----------------------------
INSERT INTO `tb_admin` VALUES (2, '002', '$2a$10$FPn1svr3646A/qrZUhRWMuhD4HF2npZ2fjlEWeS6QbVKuuS9yQOp.', '高亭', '', '', '', '女', '2021-08-31 21:58:49', '', 1);
INSERT INTO `tb_admin` VALUES (3, '004', '$2a$10$wyumbwbwJDnBSI0vAaHSPeHxY1KpLXgZ5gYEcLdG7DAUDL9vEbjca', '高亭亭', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', '', '', '女', '2021-08-31 22:45:20', '', 1);
INSERT INTO `tb_admin` VALUES (4, '006', '$2a$10$vcQN2f3ScSAP7UBA5NSR4uzKCnUtmUNTm/ykv7H9EZH4fMh5JJ4EC', '高不', '', '', '', '男', '2021-08-31 22:47:59', '', 2);
INSERT INTO `tb_admin` VALUES (11, '9527', '$2a$10$lD3sJO6qcIhy2KcSIPCr3OXzo83NOw/la.48xyo/90gjaL8Zc6DH.', '李小明', '', '', '', '男', '2021-11-08 20:42:14', '', 1);
INSERT INTO `tb_admin` VALUES (12, '9557', '$2a$10$hnSyBWlKU1gZDhmzrSIwne2mNQ2q6QFurEm8bTFOljY2I9dvjIzH.', '王小川', '', '', '', '女', '2022-01-02 15:00:42', '', 2);
INSERT INTO `tb_admin` VALUES (13, '8557', '$2a$10$JnKNhwJZ02Gkbk9Eo0b9ZO5rot6G5ODJ5OPHrUYmFbvQhjSSMmp/K', '侯孝贤', '', '', '', '男', '2022-01-07 23:25:39', '', 2);

-- ----------------------------
-- Table structure for tb_class
-- ----------------------------
DROP TABLE IF EXISTS `tb_class`;
CREATE TABLE `tb_class`  (
  `classId` char(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` char(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `academyId` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `majorId` char(4) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`classId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_class
-- ----------------------------
INSERT INTO `tb_class` VALUES ('2020010101', '2020级产品设计1班', '01', '0101');
INSERT INTO `tb_class` VALUES ('2020010102', '2020级产品设计2班', '01', '0101');
INSERT INTO `tb_class` VALUES ('2020020101', '2020级英语1班', '02', '0201');
INSERT INTO `tb_class` VALUES ('2020040101', '2020级林产化工1班', '04', '0401');
INSERT INTO `tb_class` VALUES ('2020050101', '2020级小学教育1班', '05', '0501');
INSERT INTO `tb_class` VALUES ('2020060101', '2020级软件工程1班', '06', '0601');
INSERT INTO `tb_class` VALUES ('2020070101', '2020级电子信息工程1班', '07', '0701');
INSERT INTO `tb_class` VALUES ('2020080101', '2020级汉语言文学1班', '08', '0801');
INSERT INTO `tb_class` VALUES ('2020090101', '2020级法学1班', '09', '0901');
INSERT INTO `tb_class` VALUES ('2020100101', '2020级哲学1班', '10', '1001');
INSERT INTO `tb_class` VALUES ('2021010101', '2021级产品设计1班', '01', '0101');

-- ----------------------------
-- Table structure for tb_healthy
-- ----------------------------
DROP TABLE IF EXISTS `tb_healthy`;
CREATE TABLE `tb_healthy`  (
  `healthyId` int(11) NOT NULL AUTO_INCREMENT,
  `account` char(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `temperature` float(3, 1) NOT NULL,
  `region` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `createTime` date NOT NULL,
  `sex` enum('男','女') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `category` enum('研究生','本科生','专科生/高职生','留学生','其他') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `school` enum('是','否') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `cough` enum('有','无') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `weakness` enum('有','无') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `symptom` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `time` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`healthyId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_healthy
-- ----------------------------
INSERT INTO `tb_healthy` VALUES (5, '202010010102', 36.1, '广西壮族自治区-梧州市-万秀区', '2021-10-31', '男', '本科生', '15277886787', '是', '无', '无', '', '2021-10-09');
INSERT INTO `tb_healthy` VALUES (9, '202010010102', 36.5, '广西壮族自治区-梧州市-万秀区', '2021-11-01', '男', '本科生', '15277886787', '是', '无', '无', '', '2021-10-10');
INSERT INTO `tb_healthy` VALUES (10, '202010010102', 36.6, '广西壮族自治区-梧州市-万秀区', '2021-11-01', '男', '本科生', '15277886787', '是', '无', '无', '', '2021-10-11');
INSERT INTO `tb_healthy` VALUES (11, '202010010102', 36.7, '广西壮族自治区-梧州市-万秀区', '2021-11-01', '男', '本科生', '15277886787', '是', '无', '无', '', '2021-10-12');
INSERT INTO `tb_healthy` VALUES (12, '202010010102', 36.5, '广西壮族自治区-梧州市-万秀区', '2021-11-01', '男', '本科生', '15277886787', '是', '无', '无', '', '2021-10-13');
INSERT INTO `tb_healthy` VALUES (13, '202010010102', 36.5, '广西壮族自治区-梧州市-万秀区', '2021-11-01', '男', '本科生', '15277886787', '是', '无', '无', '', '2021-10-14');
INSERT INTO `tb_healthy` VALUES (14, '202010010102', 36.6, '广西壮族自治区-梧州市-万秀区', '2021-11-01', '男', '本科生', '15277886787', '是', '无', '无', '', '2021-10-15');
INSERT INTO `tb_healthy` VALUES (15, '202010010102', 36.6, '广西壮族自治区-梧州市-万秀区', '2021-11-01', '男', '本科生', '15277886787', '是', '无', '无', '', '2021-10-16');
INSERT INTO `tb_healthy` VALUES (16, '202010010102', 36.7, '广西壮族自治区-梧州市-万秀区', '2021-11-01', '男', '本科生', '15277886787', '是', '无', '无', '', '2021-10-17');
INSERT INTO `tb_healthy` VALUES (17, '202008010101', 36.5, '广西壮族自治区-梧州市-万秀区', '2021-11-16', '男', '本科生', '15277899865', '是', '无', '无', '', '2021-11-16');
INSERT INTO `tb_healthy` VALUES (18, '202009010101', 36.0, '广西壮族自治区-梧州市-万秀区', '2022-01-08', '男', '本科生', '15277887878', '是', '无', '无', '', '2022-01-07');
INSERT INTO `tb_healthy` VALUES (19, '202009010101', 36.0, '广西壮族自治区-梧州市-万秀区', '2022-01-08', '男', '本科生', '16277886789', '是', '无', '无', '', '2022-01-07');
INSERT INTO `tb_healthy` VALUES (20, '202009010101', 37.0, '广西壮族自治区-梧州市-万秀区', '2022-01-08', '男', '本科生', '16277887876', '是', '无', '无', '', '2022-01-07');
INSERT INTO `tb_healthy` VALUES (21, '202009010101', 37.0, '广西壮族自治区-梧州市-万秀区', '2022-01-08', '男', '本科生', '16277887876', '是', '无', '无', '', '2022-01-07');
INSERT INTO `tb_healthy` VALUES (22, '202009010102', 36.0, '广西壮族自治区-梧州市-万秀区', '2022-01-08', '男', '本科生', '15277998765', '是', '无', '无', '', '2022-01-07');
INSERT INTO `tb_healthy` VALUES (23, '202009010101', 37.0, '广西壮族自治区-梧州市-万秀区', '2022-01-08', '男', '本科生', '16277887876', '是', '无', '无', '', '2022-01-08');

-- ----------------------------
-- Table structure for tb_leave
-- ----------------------------
DROP TABLE IF EXISTS `tb_leave`;
CREATE TABLE `tb_leave`  (
  `leaveId` int(11) NOT NULL AUTO_INCREMENT,
  `account` char(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` char(6) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `classId` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `majorId` char(4) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `academyId` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `reason` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `startTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `endTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('外出','非外出事假','非外出病假') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `address` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `contacts` char(6) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` char(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `createTime` datetime(0) NOT NULL,
  `teacherAccount` char(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `region` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `instructor` enum('通过','不通过') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `academy` enum('通过','不通过') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` enum('待审批','审批中','不通过','已通过','已结束') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`leaveId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_leave
-- ----------------------------
INSERT INTO `tb_leave` VALUES (12, '202006010102', '绪康德', '2020060101', '0601', '06', '出去玩儿', '2021-11-05', '2021-11-05', '外出', '梧州市万秀区富民二路', '陈晓东', '15277998754', '2021-11-04 22:32:10', '2020060003', '广西壮族自治区-梧州市-万秀区', NULL, NULL, '不通过');
INSERT INTO `tb_leave` VALUES (13, '202006010103', '鲜千叶', '2020060101', '0601', '06', '肚子疼', '2021-11-05', '2021-11-05', '非外出病假', NULL, NULL, NULL, '2021-11-04 23:44:22', '2020060004', NULL, NULL, NULL, '待审批');
INSERT INTO `tb_leave` VALUES (14, '202007010101', '剧震博', '2020070101', '0701', '07', '肚子痛啊啊啊啊', '2021-11-05', '2021-11-05', '非外出病假', NULL, NULL, NULL, '2021-11-05 13:49:20', '2020070005', NULL, NULL, NULL, '已通过');
INSERT INTO `tb_leave` VALUES (15, '202007010101', '剧震博', '2020070101', '0701', '07', '去看医生', '2021-11-06', '2021-11-06', '外出', '梧州市万秀区工人医院', '李晓东', '15277998745', '2021-11-05 14:09:44', '2020070007', '广西壮族自治区-梧州市-万秀区', NULL, NULL, '待审批');
INSERT INTO `tb_leave` VALUES (16, '202008010101', '赖阳辉', '2020080101', '0801', '08', '出去玩儿', '2021-11-20', '2021-11-21', '外出', '梧州市万秀区白云山', '赖甲', '18077678756', '2021-11-16 16:54:41', '2020080004', '广西壮族自治区-梧州市-万秀区', NULL, NULL, '已通过');
INSERT INTO `tb_leave` VALUES (17, '202008010102', '胡正初', '2020080101', '0801', '08', '肚子痛', '2021-11-17', '2021-11-17', '外出', '广西梧州工人医院', '胡伟', '18898765677', '2021-11-16 23:23:35', '2020080005', '广西壮族自治区-梧州市-万秀区', NULL, NULL, '待审批');
INSERT INTO `tb_leave` VALUES (18, '202006010105', '逮天心', '2020060101', '0601', '06', '外出有事', '2021-12-04', '2021-12-05', '外出', '工人医院', '查小欣', '15277889876', '2021-12-03 21:10:51', '', '广西壮族自治区-梧州市-万秀区', NULL, NULL, '待审批');
INSERT INTO `tb_leave` VALUES (19, '202008010101', '赖阳辉', '2020080101', '0801', '08', '生病了', '2021-12-07', '2021-12-07', '非外出事假', NULL, NULL, NULL, '2021-12-06 23:39:00', '', NULL, NULL, NULL, '待审批');
INSERT INTO `tb_leave` VALUES (20, '202008010101', '赖阳辉', '2020080101', '0801', '08', '受不了了', '2021-12-08', '2021-12-09', '非外出病假', NULL, NULL, NULL, '2021-12-06 23:39:33', '', NULL, NULL, NULL, '待审批');
INSERT INTO `tb_leave` VALUES (21, '202009010101', '夫温书', '2020090101', '0901', '09', '去医院', '2022-01-09', '2022-01-09', '外出', '梧州市工人医院', '夫未战', '16678676655', '2022-01-08 08:46:32', '2020090004', '广西壮族自治区-梧州市-万秀区', NULL, NULL, '已通过');
INSERT INTO `tb_leave` VALUES (22, '202009010102', '赏鸿畅', '2020090101', '0901', '09', '肚子痛', '2022-01-08', '2022-01-08', '非外出病假', NULL, NULL, NULL, '2022-01-08 09:35:26', '2020090004', NULL, NULL, NULL, '已通过');
INSERT INTO `tb_leave` VALUES (23, '202009010101', '夫温书', '2020090101', '0901', '09', '去医院', '2022-01-08', '2022-01-08', '外出', '梧州市工人医院', '无锡哎', '15578445122', '2022-01-08 13:07:03', '2020090004', '广西壮族自治区-梧州市-万秀区', NULL, NULL, '已通过');

-- ----------------------------
-- Table structure for tb_major
-- ----------------------------
DROP TABLE IF EXISTS `tb_major`;
CREATE TABLE `tb_major`  (
  `majorId` char(4) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `specialtyCode` char(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` char(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `academyId` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`majorId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_major
-- ----------------------------
INSERT INTO `tb_major` VALUES ('0101', '130504', '产品设计(侧重珠宝首饰设计)', '01');
INSERT INTO `tb_major` VALUES ('0102', '130505', '服装与服饰设计', '01');
INSERT INTO `tb_major` VALUES ('0103', '130502', '视觉传达设计', '01');
INSERT INTO `tb_major` VALUES ('0104', '130503', '环境设计', '01');
INSERT INTO `tb_major` VALUES ('0105', '130508', '数字媒体艺术', '01');
INSERT INTO `tb_major` VALUES ('0201', '050201', '英语', '02');
INSERT INTO `tb_major` VALUES ('0202', '050261', '翻译', '02');
INSERT INTO `tb_major` VALUES ('0203', '050262', '商务英语', '02');
INSERT INTO `tb_major` VALUES ('0401', '082403', '林产化工', '04');
INSERT INTO `tb_major` VALUES ('0402', '081302', '制药工程', '04');
INSERT INTO `tb_major` VALUES ('0403', '090107T', '茶学', '04');
INSERT INTO `tb_major` VALUES ('0404', '081303T', '资源循环科学与工程', '04');
INSERT INTO `tb_major` VALUES ('0405', '082701', '食品科学与工程', '04');
INSERT INTO `tb_major` VALUES ('0406', '080202', '机械设计制造及其自动化', '04');
INSERT INTO `tb_major` VALUES ('0407', '080801', '自动化', '04');
INSERT INTO `tb_major` VALUES ('0408', '080205', '工业设计', '04');
INSERT INTO `tb_major` VALUES ('0409', '080203', '材料成型及控制工程', '04');
INSERT INTO `tb_major` VALUES ('0410', '560301', '机电一体化技术', '04');
INSERT INTO `tb_major` VALUES ('0501', '040107', '小学教育', '05');
INSERT INTO `tb_major` VALUES ('0502', '040106', '学前教育', '05');
INSERT INTO `tb_major` VALUES ('0503', '130202', '音乐学', '05');
INSERT INTO `tb_major` VALUES ('0504', '130205', '舞蹈学', '05');
INSERT INTO `tb_major` VALUES ('0505', '670102K', '学前教育', '05');
INSERT INTO `tb_major` VALUES ('0601', '080902', '软件工程', '06');
INSERT INTO `tb_major` VALUES ('0602', '080910T', '数据科学与大数据技术', '06');
INSERT INTO `tb_major` VALUES ('0603', '080905', '物联网工程', '06');
INSERT INTO `tb_major` VALUES ('0604', '080906', '数字媒体技术', '06');
INSERT INTO `tb_major` VALUES ('0605', '080901', '计算机科学与技术', '06');
INSERT INTO `tb_major` VALUES ('0606', '070101', '数学与应用数学', '06');
INSERT INTO `tb_major` VALUES ('0607', '070102', '信息与计算科学', '06');
INSERT INTO `tb_major` VALUES ('0608', '510201', '计算机应用技术专业', '06');
INSERT INTO `tb_major` VALUES ('0701', '080701', '电子信息工程', '07');
INSERT INTO `tb_major` VALUES ('0702', '080803T', '机器人工程', '07');
INSERT INTO `tb_major` VALUES ('0703', '080702', '电子科学与技术', '07');
INSERT INTO `tb_major` VALUES ('0704', '080703', '通信工程', '07');
INSERT INTO `tb_major` VALUES ('0705', '080705', '光电信息科学与工程', '07');
INSERT INTO `tb_major` VALUES ('0706', '070202', '应用物理学', '07');
INSERT INTO `tb_major` VALUES ('0707', '510103', '应用电子技术', '07');
INSERT INTO `tb_major` VALUES ('0801', '050101', '汉语言文学', '08');
INSERT INTO `tb_major` VALUES ('0802', '050301', '新闻学', '08');
INSERT INTO `tb_major` VALUES ('0803', '050103', '汉语国际教育', '08');
INSERT INTO `tb_major` VALUES ('0901', '030101K', '法学', '09');
INSERT INTO `tb_major` VALUES ('0902', '120402', '行政管理', '09');
INSERT INTO `tb_major` VALUES ('0903', '120401', '公共事业管理', '09');
INSERT INTO `tb_major` VALUES ('1001', '010101', '哲学', '10');
INSERT INTO `tb_major` VALUES ('1101', '123456', '测试', '11');

-- ----------------------------
-- Table structure for tb_notice
-- ----------------------------
DROP TABLE IF EXISTS `tb_notice`;
CREATE TABLE `tb_notice`  (
  `noticeId` int(255) NOT NULL AUTO_INCREMENT,
  `title` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `content` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `createTime` datetime(0) NOT NULL,
  `classes` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`noticeId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_notice
-- ----------------------------
INSERT INTO `tb_notice` VALUES (4, '锦瑟无端五十弦', '<p>一弦一柱思华年</p>', '2021-12-04 21:36:36', NULL);
INSERT INTO `tb_notice` VALUES (5, '庄生晓梦迷蝴蝶', '<p>望帝春心托杜鹃</p>', '2021-12-04 21:37:55', NULL);
INSERT INTO `tb_notice` VALUES (6, '沧海月明珠有泪', '<p>蓝田日暖玉生烟</p>', '2021-12-04 21:38:35', NULL);
INSERT INTO `tb_notice` VALUES (7, '有同学丢失东西', '<p>在大苏打大苏打撒飞洒三年发生的快捷回复那就是的那款十大科技</p>', '2022-01-07 23:31:52', NULL);

-- ----------------------------
-- Table structure for tb_settings
-- ----------------------------
DROP TABLE IF EXISTS `tb_settings`;
CREATE TABLE `tb_settings`  (
  `settingsId` int(11) NOT NULL AUTO_INCREMENT,
  `switch` tinyint(4) NOT NULL DEFAULT 1,
  `ruleName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`settingsId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_settings
-- ----------------------------
INSERT INTO `tb_settings` VALUES (3, 0, '啊大苏打', '1');
INSERT INTO `tb_settings` VALUES (4, 0, '阿松大', NULL);
INSERT INTO `tb_settings` VALUES (5, 1, '123131', NULL);
INSERT INTO `tb_settings` VALUES (9, 0, '定时获取数据', '禹州市\",\"communitys\":[\"夏都街道\",\"火龙镇郭楼村\",\"梁北镇郭村\",\"颍川街道寨子社区南市场北四路\",\"钧台街道花城社区四季花城西院\"]},{\"type\":\"2\",\"province\":\"广东省\",\"city\":\"深圳市\",\"county\":\"罗湖区\",\"area_name\":\"广东省 深圳市 罗湖区\",\"communitys\":[\"清水河街道鹤围村58栋\",\"清水河街道鹤围村64栋\"]},{\"type\":\"2\",\"province\":\"广东省\",\"city\":\"珠海市\",\"county\":\"香洲区\",\"area_name\":\"广东省 珠海市 香洲区\",\"communitys\":[\"南屏镇将军山榕园小区2栋\",\"南屏镇十二村成丰园中45号\",\"南屏镇广生一街73号\"]},{\"type\":\"2\",\"province\":\"广东省\",\"city\":\"中山市\",\"county\":\"坦洲镇\",\"area_name\":\"广东省 中山市 坦洲镇\",\"communitys\":[\"国际花城一期第41栋\"]}]},\"code\":0,\"msg\":\"查询成功\"}');

-- ----------------------------
-- Table structure for tb_student
-- ----------------------------
DROP TABLE IF EXISTS `tb_student`;
CREATE TABLE `tb_student`  (
  `studentId` int(11) NOT NULL AUTO_INCREMENT,
  `account` char(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` char(6) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '123456',
  `headImg` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `mail` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sex` enum('男','女') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `classId` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `createTime` datetime(0) NOT NULL,
  `phone` char(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `loginTime` datetime(0) DEFAULT NULL,
  `majorId` char(4) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `academyId` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `instructorId` int(11) DEFAULT NULL,
  PRIMARY KEY (`studentId`) USING BTREE,
  UNIQUE INDEX `account`(`account`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 657 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_student
-- ----------------------------
INSERT INTO `tb_student` VALUES (320, '202006010101', '鲁雯华', '$2a$10$EsEkSWKlWKx1ddD2HGIJB.2P6TMBpB1ME72J5z7Vw7RIc76z2Qmga', 'null', '', '', '男', '2020060101', '2021-11-04 16:06:10', '', NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (321, '202006010102', '绪康德', '$2a$10$1ZzX4hz26y1Ezh6rODGBSu.d2cAbuZNU8EgailqtHThjzrHQvzWzS', 'null', '', '', '男', '2020060101', '2021-11-04 16:06:10', '', NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (322, '202006010103', '鲜千叶', '$2a$10$/A86gD.xhBMZ0flTj1iUMerL0MCTV4Uf3HTpKqJbRkVqBfCkNrYNu', 'null', '', '', '男', '2020060101', '2021-11-04 16:06:10', '', NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (323, '202006010104', '焦令梓', '$2a$10$ieEVYO462FN2Jzv6IThFKOF8DwHsCXKi9rZ/swUXQTa7SUV5rqZlm', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:11', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (324, '202006010105', '逮天心', '$2a$10$jnHW5eDl5b/qT8Nj/qkHbOq3TwiiB6/8O9L7I4fxfMG/w.ZfEFG46', 'https://ljm-bsimg.oss-cn-guangzhou.aliyuncs.com//img/1641228085853mvc4mtr9ge', '', '', '女', '2020060101', '2021-11-04 16:06:11', '', NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (325, '202006010106', '庹欣跃', '$2a$10$uxTppqqCvGw9.WfhwUwNoO3GfwAmmiZ1etzz.FpgIdlh/F0oVaxTm', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:11', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (326, '202006010107', '晏晶辉', '$2a$10$v43HYluf5ulUMCXQ3jLUKuBVWlp2O1rcCmYAH3BIXJEc6fm2sgsji', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:12', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (327, '202006010108', '位靖易', '$2a$10$wCawIIpRAkY8lpoJwGFwCuus3IAgPYY4ghKhQRPARkbjplK/yOGca', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:12', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (328, '202006010109', '老婉君', '$2a$10$ZTni1.oZuA87JVLJKUOiP.4AMxKYLy9Z4oGpWULkXcDhlM.ubgDPq', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:12', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (329, '202006010110', '箕子楠', '$2a$10$IMXSmgkirwrCX2pyxPJie.6Ye0Am/F4ABuQVrmauYUotgi4GsJPBK', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:12', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (330, '202006010111', '福高逸', '$2a$10$aJ46/tAcfVIpByn5/k7iL.KBpSZhmbpG1/QVaIADpwb/hf0OYTPxW', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:13', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (331, '202006010112', '傅茂德', '$2a$10$MOaTnBF1HeG6Udr10Y1qT.3f5pmG6O2PzjWeJA7tt2U9tlECv0NIa', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:13', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (332, '202006010113', '青颖然', '$2a$10$QKXBNM7lFmGh7cfPHGashefGk2US/zQDY/B92.orBdGKyrCuEcEEW', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:13', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (333, '202006010114', '尾尔槐', '$2a$10$1HGpgvvIuTqSBoMt4AhrXePxXOsPitaWFdzYsptzGXYPp.lPMSP3m', NULL, NULL, NULL, '男', '2020060101', '2021-11-04 16:06:13', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (334, '202006010115', '幸晶茹', '$2a$10$/n4/aFYAI45QlOA/LKurf.Xjm7Uj7kh4jeweg4zfDmNsjhn00KHha', NULL, NULL, NULL, '男', '2020060101', '2021-11-04 16:06:15', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (335, '202006010116', '东明珠', '$2a$10$Dp.FnyHOP26J5/jQGCsLBOZzqUedJF41NTP4Cpo7xGoPFff9yWEve', NULL, NULL, NULL, '男', '2020060101', '2021-11-04 16:06:15', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (336, '202006010117', '剧慧英', '$2a$10$4ieynHyMDxXFzPE8hhO8Der3BnF6.ZYw4reKR/9.9DkeH1ks5Mvsm', NULL, NULL, NULL, '男', '2020060101', '2021-11-04 16:06:15', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (337, '202006010118', '介痴凝', '$2a$10$UCT/hEz2bzA6kzUpUjGFY.mGxAn9AVWqzal1yOxWQXr6v6NMr.eRm', NULL, NULL, NULL, '男', '2020060101', '2021-11-04 16:06:15', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (338, '202006010119', '毕云英', '$2a$10$TBOOWP72EEZbOQ6VYY2jcuvUU9eirkWi/FdLHbsYKuHZZoF3bv1qm', NULL, NULL, NULL, '男', '2020060101', '2021-11-04 16:06:16', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (339, '202006010120', '牢米雪', '$2a$10$WHIuQbOOEtgfkP.XrEmiPuvyprEMuDbQg5R/TrIicsjrVOC.RsTnG', NULL, NULL, NULL, '男', '2020060101', '2021-11-04 16:06:16', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (340, '202006010121', '偶冷松', '$2a$10$7msAtrHe1635pMY.2gxVpuPtLjVo3E4PGR/snkDJb3SSr/Hb8V2TO', NULL, NULL, NULL, '男', '2020060101', '2021-11-04 16:06:16', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (341, '202006010122', '旷娴雅', '$2a$10$1R0KojQGjMyUUt9U.VHu0.mKZZP.cf/Q9t1Qy0Cps.guwwymRG8Ne', NULL, NULL, NULL, '男', '2020060101', '2021-11-04 16:06:16', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (342, '202006010123', '隆飞槐', '$2a$10$AUli6J499Lu/iVRMg1bGfuDsE1QfdHI0oE7c8urGk.icMZ2ZE0esK', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:17', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (343, '202006010124', '瑞恨瑶', '$2a$10$Y99Ba7oT4mKhhQ9u7NwzruKbC7XCKijzTMn72UwX6uSjpard0oVNC', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:17', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (344, '202006010125', '漆经略', '$2a$10$XuEVkjrNDlPjPi10gH.Cju2LzDZHQXleh6sLleiPqJWAjEMe3XnBG', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:17', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (345, '202006010126', '娄运晟', '$2a$10$hjcL/mICUQ0Jg9X4Scg3outP8KYT9s/OQfm03R7oPC4D1VK/cyzem', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:17', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (346, '202006010127', '浑恬静', '$2a$10$EJiGAG.m.mANLP/NeudwButNOZZ9Bnz1DGdCTomHtTICQ5fYIv07.', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:17', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (347, '202006010128', '允平萱', '$2a$10$KQCkDFxs0/MnSaONRZ5/..dM8CwgU1DMwdk5oRqNmX3224mta0rZm', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:18', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (348, '202006010129', '巩德明', '$2a$10$RVOTGNEgqHMAPaO7Qwli2OuL6RuJmV9GLuhTpfUMXm9vW1DrcIbrW', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:18', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (349, '202006010130', '辜婉仪', '$2a$10$HdyKRRejVkz0n8hssun/VeILs8ibcDDsJrNetFMSCPyCJQfELrO.6', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:18', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (350, '202006010131', '经修明', '$2a$10$Y.L.K70htQuYExTwOGC7Ouy2KNh6D2hOOY3SlgHLhG3TdUvPgCQCG', NULL, NULL, NULL, '女', '2020060101', '2021-11-04 16:06:19', NULL, NULL, '0601', '06', NULL);
INSERT INTO `tb_student` VALUES (351, '202005010101', '慈雪瑶', '$2a$10$Zu7reyQKw91/0PBldHV8beAkNR1BI/UIPGag4C7FhvbrymCPmDJu.', NULL, NULL, NULL, '男', '2020050101', '2021-11-04 16:11:25', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (352, '202005010102', '冷芸芸', '$2a$10$HAH55BDaSY7Mhcjt5nW5r.4AO61ioPyVFd3sB1AKeuL.2dwKycsmG', NULL, NULL, NULL, '男', '2020050101', '2021-11-04 16:11:25', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (353, '202005010103', '艾从冬', '$2a$10$ASiFQu4K4Z5CKlMLqE.rVOgIasmVjwxWzekzoMNtosU2Bhdey2kBe', NULL, NULL, NULL, '男', '2020050101', '2021-11-04 16:11:26', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (354, '202005010104', '律丹秋', '$2a$10$VjpU5c8ugKvqLHAnXFdpeu8ombSDi4wGsEiti85rnlADzUWFbac3u', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:26', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (355, '202005010105', '蔡永年', '$2a$10$vvZjORrvFMLifZ2xAFIyKO4tLTnYz9QQZ0uKNvq4p8lMa5luGXqF2', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:26', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (356, '202005010106', '娄雍雅', '$2a$10$aw3WyUC.KoQ/ZbEe9FiksuzHioT5INoc2lNE0RKWT9eYbPCFTVek2', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:26', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (357, '202005010107', '麦叶芳', '$2a$10$Yj9HezzGWxHaoPFmpf.awORSGvWhp.4c9WObIWnKTck9wnPR4ComW', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:26', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (358, '202005010108', '第熙怡', '$2a$10$AYKbL51H8OfXgHCVP68tWOwCdqRUliWab8b8xf17fpSSzLFAV1CaG', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:27', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (359, '202005010109', '邵正卿', '$2a$10$Sp8Nb7.jLt5RzVAu7ru4t.q8cNUjte3czRDhvpIDdGe0dT.EUBuJi', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:27', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (360, '202005010110', '路春英', '$2a$10$1QLcjewJwjsgzfaHTmmPyeFBEF1ZBBOjs2REI/Jp797mWKaWoDdfi', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:27', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (361, '202005010111', '郭思雨', '$2a$10$9uDGXeVRnr4qoG9/NPf6buAASO2B6NlKjwxRBNrHi31YofbwpW3A.', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:27', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (362, '202005010112', '枚雅静', '$2a$10$bGUcrG0nij/TRv1HxKwqzeD6hXUk7onvsxCyQVNijmYxQKIARgBXW', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:28', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (363, '202005010113', '金子帆', '$2a$10$oUjLPsRaHPoojcsirms/TOWLgSowoHy6tAm1uaGp50Rr0EabmTTiy', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:28', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (364, '202005010114', '郁瑜英', '$2a$10$Zes2eVvqCaLJvrrNuFRiFOwfw778u4.7mle7Bkvevq65gCbrMzCDS', NULL, NULL, NULL, '男', '2020050101', '2021-11-04 16:11:28', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (365, '202005010115', '青以晴', '$2a$10$QEULvhsEVzEsGmZJT.tA8uQnMshuehcEnQk5QFT8cf32BYZFXHPu2', NULL, NULL, NULL, '男', '2020050101', '2021-11-04 16:11:28', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (366, '202005010116', '印晨希', '$2a$10$zpA1zv6LneZcEhmPL4zcruC6OxznkpK.RC/Pr5GT0UXTcgvXsagg2', NULL, NULL, NULL, '男', '2020050101', '2021-11-04 16:11:29', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (367, '202005010117', '米淑贞', '$2a$10$D.M2sdHAp.cYGDEciaE3LO.xGBAGX7kZNrz.XrBe.3pL5RFxCwORa', NULL, NULL, NULL, '男', '2020050101', '2021-11-04 16:11:29', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (368, '202005010118', '曾慈心', '$2a$10$OHlXenTqqL0Mr7CH7Ygy5eW.fZHlyFFltoFIU2bKUt.UMghvu2csi', NULL, NULL, NULL, '男', '2020050101', '2021-11-04 16:11:29', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (369, '202005010119', '延聪慧', '$2a$10$i9RPzRaorYRJF1CYeop0qeKBPgVOBjDfKma8xRb1ACWHoblXutqYS', NULL, NULL, NULL, '男', '2020050101', '2021-11-04 16:11:29', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (370, '202005010120', '瓮贤惠', '$2a$10$T0aSUh4mKmvdKrN8S83p/e1NZXBc.fbgIoyrIsUfEYrhgm5tPHfNC', NULL, NULL, NULL, '男', '2020050101', '2021-11-04 16:11:29', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (371, '202005010121', '么新美', '$2a$10$zBXG/VLAJbqs6cJ5OSOrc.oHQ6AQSjx14LyxpKmbAItnUBIvqrs76', NULL, NULL, NULL, '男', '2020050101', '2021-11-04 16:11:30', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (372, '202005010122', '石新雪', '$2a$10$sx6U4USlXKFkSuMl48rMZuX/dqobRTm51WrU76zkelFk0TiSuRfd.', NULL, NULL, NULL, '男', '2020050101', '2021-11-04 16:11:30', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (373, '202005010123', '乌茜茜', '$2a$10$0h2Hv291evl2xX5Ir9VeuObMDR4hmwea5Z4MN8vJ4c7lqpIlJZc7S', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:30', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (374, '202005010124', '荆虹星', '$2a$10$jF0RqMPGdD3oa6jSpsJeQ.BK3zGWVWKux.yWaDa16.lXGXyTd4TD.', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:30', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (375, '202005010125', '藏雪羽', '$2a$10$gPJ3ekbU.3BGwPWYnRRWKOaAeCGDF29VCjUu3CiC7576M41gYp3ZC', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:31', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (376, '202005010126', '素山彤', '$2a$10$2Mp6Lfc9Ze7W7eaH/N5BGeUVjjlWvosgfq1Om2/KP1RyfVLFLc2ui', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:31', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (377, '202005010127', '母奇逸', '$2a$10$MBW0HwjYSZ29CWzDx5gaD.v9VbrvX2hYoFj/iBCzGEMXRFnEoBC/G', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:31', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (378, '202005010128', '羽曼语', '$2a$10$fQmdlNzeooETVbXr.AXzQuJ8Z0V/z5tvvM5w4A.nPT7miPjsHj1cW', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:31', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (379, '202005010129', '璩叶丰', '$2a$10$LkGtSZabqimfa/WR0HcqEONfOCTj04VzcER5g/ETo5z/NjlaqRNxe', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:32', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (380, '202005010130', '道雅韵', '$2a$10$MLWmnez/1F36jx9RFxNsUeiOuGCMJxZsujYydyzz5uxEwoIKvUbOS', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:32', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (381, '202005010131', '桥安阳', '$2a$10$tMRVh0YCMMMnUeq8dqg70uoPdUwwcuTNZsHnvIGP602uuCvmpN0Cy', NULL, NULL, NULL, '女', '2020050101', '2021-11-04 16:11:32', NULL, NULL, '0501', '05', NULL);
INSERT INTO `tb_student` VALUES (382, '202004010101', '毛玉珂', '$2a$10$baWn8Z9fxemNd8K/yw3Dkuo2iLuQxRXtWZIBkWBlweMTyayjM18ie', NULL, NULL, NULL, '男', '2020040101', '2021-11-04 16:32:38', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (383, '202004010102', '温代芙', '$2a$10$/.R1Iw1UUPgFOKYkxBUlGOhObAhKmRaGB7PmTIKTwuhfpG7zlBi2O', NULL, NULL, NULL, '男', '2020040101', '2021-11-04 16:32:38', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (384, '202004010103', '枝惠丽', '$2a$10$ivuAwDs3EtHxS1lV6WhX0uTF2GmijNX/j3kq49Bloz5d2c9qqyvqS', NULL, NULL, NULL, '男', '2020040101', '2021-11-04 16:32:38', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (385, '202004010104', '国凌寒', '$2a$10$2tLLjX53A7ldzHLgbbwzpuyDhri6wfSQTxU4wRrqJROq/SgYRAHoO', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:38', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (386, '202004010105', '清慕卉', '$2a$10$Q03QxO1zy/9q3Jodgv.87eg/AeNUWmBsb0ogBZFAvoGbaypsGfyC2', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:38', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (387, '202004010106', '竺晴岚', '$2a$10$TdTwVfCPU6aNYlRQozRv8u4GFEDYptV1ptjRTi4wIWdIWo22JmsiW', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:38', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (388, '202004010107', '夏寄波', '$2a$10$v4sFSdphSQ0RyL.qvMLGjeZUisiBWP/7SQVFDiOvjqy7r4MtXHaRa', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:39', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (389, '202004010108', '柔致萱', '$2a$10$du8mjS7GUtOc27.NNV7UOuZZc.eM5HVs.bv6L5mW35/uqc/8gcTCK', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:39', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (390, '202004010109', '锺德宇', '$2a$10$6ftunhNtw20PrcFYzLwhFuDzPxTrI8BUDJ9gsQ5VPSVgHQrpODge6', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:39', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (391, '202004010110', '诸高韵', '$2a$10$/nWqY3B5b3xvoXPYvW3TkOTRsD0Qwr8KrnSdc0uL174v/0XiPbzlC', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:39', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (392, '202004010111', '勾初蝶', '$2a$10$u7C6mDSswVMZO64TvK5cQeNAMXRw9tM.oXGEOE7RuKYCm6MCPuN6i', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:39', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (393, '202004010112', '高惠然', '$2a$10$l/YX3C31fgjSQ4ZcSJxuDuH6GAuB4HBWQ8CqXR00doBrWmYRBvYVi', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:40', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (394, '202004010113', '买灵萱', '$2a$10$iRkHCFbsVoly7L5SjgEha.GHljDM3gNiOAruU5yDoKDZuZQdnoI4m', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:40', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (395, '202004010114', '门蕙芸', '$2a$10$UMG/PmTXOwBc4gg.KvKXcuK3wB13ZSKQU.fzMWFk92mnGzVtIhKZC', NULL, NULL, NULL, '男', '2020040101', '2021-11-04 16:32:40', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (396, '202004010115', '钱笑旋', '$2a$10$xZc9NqYHQdPqCXLZlCfSxutllX4AnIeObksclWvjNO/rhTX0ZwWXG', NULL, NULL, NULL, '男', '2020040101', '2021-11-04 16:32:40', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (397, '202004010116', '貊清宁', '$2a$10$gSgGShqlQBaBv2XtmMfV9ux3plyVOkuMzSO1iCb00PEJ3juWeBEu2', NULL, NULL, NULL, '男', '2020040101', '2021-11-04 16:32:40', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (398, '202004010117', '果海逸', '$2a$10$X0OjoITicNRZ6oDoGiehnupgdmRMY9xlUIczKqX/hNoDlY3pl/vvC', NULL, NULL, NULL, '男', '2020040101', '2021-11-04 16:32:40', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (399, '202004010118', '姬鸿运', '$2a$10$yDxDA5PF3n1L3ACJPRwzseabqqdYKgDnitY47I59HtUs0LfAvTKva', NULL, NULL, NULL, '男', '2020040101', '2021-11-04 16:32:41', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (400, '202004010119', '永采文', '$2a$10$yUFXwaZnjT2CjVkIoICy..t3jCFmptygzuwQlZsu4avHOtN5K4xpa', NULL, NULL, NULL, '男', '2020040101', '2021-11-04 16:32:41', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (401, '202004010120', '伍鸿彩', '$2a$10$idDy5tJkV6v/tWNg20m/..scSLmLexseOmjwyRSQG7jCSBYU1vZ3.', NULL, NULL, NULL, '男', '2020040101', '2021-11-04 16:32:41', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (402, '202004010121', '侍佩玉', '$2a$10$pQOnlq4ivlzCUW7YHwIae.Hp5L10ekitSBWq/8YAoTLHr.lW42Z3K', NULL, NULL, NULL, '男', '2020040101', '2021-11-04 16:32:41', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (403, '202004010122', '剑语山', '$2a$10$NswzI5irxLeDkt5DVKmeeeWXAM2o7C5tGF5sjql2yM/6hK0sITzJ2', NULL, NULL, NULL, '男', '2020040101', '2021-11-04 16:32:41', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (404, '202004010123', '操昊然', '$2a$10$4Zhcqgssbf7lXE6tFipbdOEak4TOoz9d6AMVrNUwlxhfkDBAFntPa', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:42', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (405, '202004010124', '喻飞兰', '$2a$10$hynCD1AE3wIOcRrlELIZzeqImRmSgWcVIskKAjX1XxIcEMQ9nsuiO', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:42', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (406, '202004010125', '奈雪容', '$2a$10$K5/5WE2NNibKrXvZDHcP2.NN3CD86OdaFw0GWzlQ9oG4nSeQgXKay', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:42', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (407, '202004010126', '金振博', '$2a$10$0pVdgYe8Uyfi3/OeHeCKnuftaZBHKG63Dxqt/wLkcExBPyT.mZB9a', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:42', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (408, '202004010127', '利梦菲', '$2a$10$aqH1JQ.WeNy3KLXnwvhpNOd6DgUfQwFY.A.WzN7vWjiauQtye4KZ.', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:42', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (409, '202004010128', '应俊雄', '$2a$10$u6hyhiy/El/deCd2PxB4WO4h75uL6mZa4vyBSBSZbNv.R8dgAmUgu', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:43', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (410, '202004010129', '锁安易', '$2a$10$VztOBc9UAO3kRadeOJXhH.0ug6C8BqBk6JXjNm1G8o.yu2FDCOeAC', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:43', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (411, '202004010130', '藩鸿风', '$2a$10$ywaRz4RDzJRlv9jp5Om6UOjsxYhv1HInwXKSG5mXF99.CZ/yAw8dK', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:43', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (412, '202004010131', '登成双', '$2a$10$nG2VZunVy/JTcSoylcPLw.HnFzEgh2tcl7qfX6Psj5Sjm0LqyFlba', NULL, NULL, NULL, '女', '2020040101', '2021-11-04 16:32:43', NULL, NULL, '0401', '04', NULL);
INSERT INTO `tb_student` VALUES (413, '202003010101', '苟以柳', '$2a$10$itgeZ8F0zzgt1ssE4rwAQOJBje2yyZam9wwPSbcfIODJpBkDPWzLq', NULL, NULL, NULL, '男', '2020030101', '2021-11-04 16:33:45', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (414, '202003010102', '将嘉石', '$2a$10$JehsIeRe.8m/2Utfy8cDWeBIDbYltGP2C28vyCOzep2P/Or/tMk6S', NULL, NULL, NULL, '男', '2020030101', '2021-11-04 16:33:45', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (415, '202003010103', '寸淑然', '$2a$10$4tpt2Rqy13z7VUfecpsEOOk2HFWGelq8tngcKVgIwtcRuWAjarOw2', NULL, NULL, NULL, '男', '2020030101', '2021-11-04 16:33:45', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (416, '202003010104', '零熙怡', '$2a$10$avdrfz8YxAhiH/2EXpGe1O7MqCHaOmRKOuRbi3Hc/x8LgysHDlNFy', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:46', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (417, '202003010105', '纳灿灿', '$2a$10$9rL./v5FI20vLnhIUPv6qeD2qGTjzOU6LumayFv0Dw6B6b83Ulwqi', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:46', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (418, '202003010106', '羊念之', '$2a$10$E6AiIrCTGGc33Ul4npCGVOo/4ytzBEn370Iq.0e62LLoe7TMKeegO', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:46', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (419, '202003010107', '千听南', '$2a$10$RQZ/CA8UhhpnY0XYaoiY7eOO8EVv.f89OQrVRJLGOXStUuU6Lu1Ai', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:46', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (420, '202003010108', '环良平', '$2a$10$pGftHD2CuO7iRvg3AswEUOAS2Qmk/scoufrDuQxr8lX3ArVI/oyja', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:46', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (421, '202003010109', '乌怀山', '$2a$10$g6Dn8rA.vMvkeWjfzmMI5Oje4LJwDzNIpR9BBlbET3uOqLF5fFZ3y', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:47', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (422, '202003010110', '璩半槐', '$2a$10$EbPgJfXs9rItMTvx7qSKce1yFXdL3MRYxn2wbcDQBrG7VoQBQeg.u', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:47', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (423, '202003010111', '布骞魁', '$2a$10$vWQRsbVcKiRCOGUBL4JMA.xmDsnYe3K5gKDdz.ESGtle6lls0ptvK', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:47', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (424, '202003010112', '塔柔丽', '$2a$10$rGlcMU5mDNu9Mj3G8358YOy0rwhtdjvT43QhUCwmBvcELTJRViWkS', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:47', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (425, '202003010113', '竺琼怡', '$2a$10$R/c.8MgYfTfc37gIrR2Jdev.TcP.uMYS4XpDTqztzZgWd0LXSn/wC', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:47', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (426, '202003010114', '叶宏远', '$2a$10$Z6KilKr2y3OTO/vC04qSUeuLo9Ws2NNiLY30y691f51F.2pBJYJ0W', NULL, NULL, NULL, '男', '2020030101', '2021-11-04 16:33:47', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (427, '202003010115', '海友桃', '$2a$10$2m9WyQvP6qh0ThGxHFkH.u2NWZvWvpAiHnIEgsovE57WDfR9tb5ba', NULL, NULL, NULL, '男', '2020030101', '2021-11-04 16:33:48', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (428, '202003010116', '栗骊红', '$2a$10$1.Zt0QYahUoz1ulWqTPZFuIyzZ9Ww0c2tJ9S1o8kg5Qo6W/5g9tD.', NULL, NULL, NULL, '男', '2020030101', '2021-11-04 16:33:48', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (429, '202003010117', '泉温文', '$2a$10$zJyZ00V.OChzMd6JPLpb8eW9NXsz6vOWt31flnk27BXP6h3Ya1ifu', NULL, NULL, NULL, '男', '2020030101', '2021-11-04 16:33:48', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (430, '202003010118', '井梓露', '$2a$10$dZCFnhmL5FggGhrfn0EUgu6bUopEaEL.Dt72JcIJeKMg7G79qwWkS', NULL, NULL, NULL, '男', '2020030101', '2021-11-04 16:33:48', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (431, '202003010119', '功新柔', '$2a$10$XAPMrlbYG/yutiEuW0gN8ubaG3wEGblxkaLI50I0V5bANmMXO2Dr.', NULL, NULL, NULL, '男', '2020030101', '2021-11-04 16:33:48', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (432, '202003010120', '度巧云', '$2a$10$mejL7Oxv5Wg5r8d2RDBUtOt.HW.21LC1drr5iVIWTQcLfJCelYkVW', NULL, NULL, NULL, '男', '2020030101', '2021-11-04 16:33:49', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (433, '202003010121', '冒咏志', '$2a$10$v7rB/DfpWR4dzim0yaeAiOdr6z40bw/CgTEJZamgUgSroAOtmrrJy', NULL, NULL, NULL, '男', '2020030101', '2021-11-04 16:33:49', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (434, '202003010122', '黄迎丝', '$2a$10$DmYY6iTEb.sX1fzwdAFu4OlmWod/wAZzHJCumVbQZOH2fcOb1QQpC', NULL, NULL, NULL, '男', '2020030101', '2021-11-04 16:33:49', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (435, '202003010123', '廖艳蕙', '$2a$10$ddYqRs12RSdUDlnokQuNkuX4PLKhl524e66jYBkrM/CXihQQsg8/u', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:49', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (436, '202003010124', '楚香天', '$2a$10$L.zHkE2CKyMj4BtUVK0ytOdT5Hs0ORLoLChi3noN1Yp2UE3mO95m.', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:49', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (437, '202003010125', '沐光临', '$2a$10$cv/X4srVJEVuPW7i7wiDVuGrG722yL6QTHjfaBdBlzpijzmd2.CAm', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:50', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (438, '202003010126', '缪志明', '$2a$10$uXiPpBzWymQ7dRvhEcrVtOmZIKhU32MPBgz.Ks/TAQzSVhYu/BdS6', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:50', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (439, '202003010127', '邗淳雅', '$2a$10$49Yu.PhaVN2.r0s5h11WI.P4yCIuNpyqD2twZBMKJnuUQlKbi1fB.', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:50', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (440, '202003010128', '独静柏', '$2a$10$BqjZb2qjAMQUaKF99hoe1eWekC5WCUVn8W0kmmCFLfxCxGtoqwLIO', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:50', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (441, '202003010129', '文珺琪', '$2a$10$K0yfvpzvrtNNvxnzZ4yN6ufLe4KyT2WfgsuLkLOYowWwpGLn//I9K', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:50', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (442, '202003010130', '越梦槐', '$2a$10$pHkQUaNUzxwuYQweQARcL.NTQP7tKVLbDPkuICw98l2iiye/QndkG', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:50', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (443, '202003010131', '权半凡', '$2a$10$dErwUQ.ADnWPxWKu4mR7pe/Z0Wr3JiOOCjJOkuJpTXIXk/mLY71Hq', NULL, NULL, NULL, '女', '2020030101', '2021-11-04 16:33:51', NULL, NULL, '0301', '03', NULL);
INSERT INTO `tb_student` VALUES (444, '202002010101', '蒲又青', '$2a$10$nT2Fznp.1wGX8tmJ30oEquwniznabDV9wBUFF/nCVzrMwtnqUZrTe', NULL, NULL, NULL, '男', '2020020101', '2021-11-04 16:35:00', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (445, '202002010102', '保馨荣', '$2a$10$xs14bfn032aFG.k060FLxOjgOWAUCLSNmmXxeV62cxk3a4.7jiacW', NULL, NULL, NULL, '男', '2020020101', '2021-11-04 16:35:00', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (446, '202002010103', '衣骏逸', '$2a$10$OY2HZ27J8q3pz1.fZbIrQu2VOBVDYcOar8mVTTjNcVV9EBybKChVq', NULL, NULL, NULL, '男', '2020020101', '2021-11-04 16:35:00', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (447, '202002010104', '孛刚豪', '$2a$10$z6lCE.EmF99ITVdIJYp83ekUH2ciQWqneC.9N/sy3ZXX4cz3nt15u', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:00', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (448, '202002010105', '洛香天', '$2a$10$HjcLh0O1oaMhf8tCskxOC.iJPZu9hk9Qx9Lxu4NUl.Ih/4BIEoaBi', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:01', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (449, '202002010106', '承春芳', '$2a$10$Rkogc1/EmBGVG3nW.nXf/Org5M7zJ4fWxItLYKQvYIUzt8SZ/fIXG', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:01', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (450, '202002010107', '燕红螺', '$2a$10$VVYuI6s4nsCWfK0396iCsOfEPscGtK0t20SJKUbM0UeedNdcZD3dW', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:01', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (451, '202002010108', '有依云', '$2a$10$e.smoJ.wFqaibakfuFhPK.zksSSaGt.C4l4Me6KVPp8CWTgBmX50u', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:01', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (452, '202002010109', '盛书萱', '$2a$10$CYGSPx4a5OcQQv.X9QrqxOF4xT04bQl5VRrVXZFY.N/2YfBtzsk/y', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:01', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (453, '202002010110', '郁思柔', '$2a$10$iC.1f4y5WjiNqwIYSPaaMurLHmvLXQRIdAFmt3E1A2qDmAS2vzAyK', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:02', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (454, '202002010111', '茂国安', '$2a$10$TT1aPXIyM5sNScey69KrIOunYsZCjwHI9qd3OGENHDq511OG0b/cG', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:02', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (455, '202002010112', '米怡嘉', '$2a$10$LdiUfCCxoZcaVMW60xwipOEoCkdoK9RY/gISC.nD6vQejg1GpA5/u', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:02', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (456, '202002010113', '笪云韶', '$2a$10$Q0K4CF7pHX1My2aAzkzhqeMDH6FU5chFhP7Yu01DieuYBC8NGB1du', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:02', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (457, '202002010114', '钭春梅', '$2a$10$yEyghV.OOXQlBiE/7jAGV.wXBTILiSvf./ZMh2qk4DPasdBcQgKpK', NULL, NULL, NULL, '男', '2020020101', '2021-11-04 16:35:02', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (458, '202002010115', '脱思洁', '$2a$10$lbJ1V2CXcMntIJQegbgb7uobXHQ25ti3EKRj2YATxg5hvrZzLaNnW', NULL, NULL, NULL, '男', '2020020101', '2021-11-04 16:35:02', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (459, '202002010116', '速英纵', '$2a$10$twsjf.Pec/1aQiINrnlWCepb8jMMte4UJAJXrTF2GLbTfMyWXUBeq', NULL, NULL, NULL, '男', '2020020101', '2021-11-04 16:35:03', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (460, '202002010117', '长平绿', '$2a$10$To8sPjmjQ2pwGw7yWuMaTeXWr/9DmtVWwSzn0UFyge1vkeHe4hTNW', NULL, NULL, NULL, '男', '2020020101', '2021-11-04 16:35:03', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (461, '202002010118', '赤顺美', '$2a$10$lAZKUWsBI/xKmaV/qsr1MO/nQPiR2H5Ypf15lg0NGaMQ7bQzQ8wiC', NULL, NULL, NULL, '男', '2020020101', '2021-11-04 16:35:03', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (462, '202002010119', '畅华容', '$2a$10$jhA8LoQyO9MWWrR/LJkIRO1a7NBlJ3wAc2FdaQRepuD9CMCLORivO', NULL, NULL, NULL, '男', '2020020101', '2021-11-04 16:35:03', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (463, '202002010120', '史宏邈', '$2a$10$91Pxe9hZHyi4GytfFDUYhuE9SOcMXgsQC75pUYMwAHbw4NXcYgYui', NULL, NULL, NULL, '男', '2020020101', '2021-11-04 16:35:03', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (464, '202002010121', '池子民', '$2a$10$GgnxpjrrHxgYA9KKK9ZgVuPaIIV6.f6AOnjUWGV.t7ZYmXCd..jpO', NULL, NULL, NULL, '男', '2020020101', '2021-11-04 16:35:04', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (465, '202002010122', '费绮怀', '$2a$10$DWKcwdcN06P8/GsKEK68eO4jRX/xKW2MH0a0vvstnwZQSBk9Q/Xbe', NULL, NULL, NULL, '男', '2020020101', '2021-11-04 16:35:04', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (466, '202002010123', '柯未央', '$2a$10$eooA3R.C3Z9/ZKCqh6PN7OwMkbamdPdARNhOIlU3co8N.5jcXJKTy', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:04', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (467, '202002010124', '潮嘉福', '$2a$10$KEc6wM3mAaevmkK5A1NJ4..tUQvINMjDOOGYXgpc/eHonArzXFYu.', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:04', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (468, '202002010125', '蓟阳飙', '$2a$10$ErI.WqubePfrw/NDDWVqfeCNhbEuaN.qVQTV6JvBd2KB25YPas3kK', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:04', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (469, '202002010126', '茅又松', '$2a$10$XQM2ZaWPK44chV5RqwQJreVotWjUETlgxPToS3ZDKyhKGPMldFFNS', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:05', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (470, '202002010127', '徐听安', '$2a$10$umXY4vrDhtFSUfnVCBNOFeohYUhfXfytmbMKaHYaGSaF4DVo2opbO', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:05', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (471, '202002010128', '阿娅欣', '$2a$10$/b3xJTH5h02ynHxJHZx9M.2iTh.FTA0KiTIzIus1RKUiEBYsryc16', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:05', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (472, '202002010129', '冀忆安', '$2a$10$CRdmnmNnU5ffpPuRuWudd.3gxj65qCEdtba..BjcgHJ1pqeoOOo.G', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:05', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (473, '202002010130', '戊岚翠', '$2a$10$.ScZVhSeQ1zHXB.NRvNiaODsyhbsiyqu173ionodQnwnfDURkFVBO', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:05', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (474, '202002010131', '隽千柔', '$2a$10$P7Sdia82AGk/JpXPk07WDe6BZfxHv32FKA6CoKCiXdCpTvPH1VCqS', NULL, NULL, NULL, '女', '2020020101', '2021-11-04 16:35:06', NULL, NULL, '0201', '02', NULL);
INSERT INTO `tb_student` VALUES (475, '202001010101', '顾建木', '$2a$10$7NUcbvgwzhlT7LBv8Ivosur9K06vjmpcSWkLcDhSXSv9QrkyCSyq6', 'null', 'null', 'null', '男', '2020010101', '2021-11-04 16:37:12', 'null', NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (476, '202001010102', '香涵蕾', '$2a$10$.veOChT9W6dBsOpxOcsNMeOwO76NvuoO2A7Md1oyv.OHiJlDPn5Xm', NULL, NULL, NULL, '男', '2020010101', '2021-11-04 16:37:12', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (477, '202001010103', '黄丽芳', '$2a$10$DlMzDGhoVgbtHYHdrHSCjuq9mwnQBJmNFKNFhuadibXOCi/QKi5DC', NULL, NULL, NULL, '男', '2020010101', '2021-11-04 16:37:12', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (478, '202001010104', '危贞怡', '$2a$10$Tp2JpadMn5QhMADoq55UgOMth5Rfmg9BfWA.PdBtM0oTk1hUMSOFy', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:12', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (479, '202001010105', '靳寒梅', '$2a$10$J1vM5Fv1ifLXWlswve2K6OpPL2vF5xEPRRa1t75PBt3Mvxj9vkE4G', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:12', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (480, '202001010106', '干春冬', '$2a$10$xlB4AOF0q8pEHli8rK4LQO9Xxesv7vfhC29iWooMJOZ8wenkvIAD6', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:13', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (481, '202001010107', '凤笑翠', '$2a$10$Y5NZUitXugMgz8ZyURrZOeo65/yjqnO8v9UQZqKghJYPItUrYG14q', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:13', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (482, '202001010108', '芒惜玉', '$2a$10$VbGkzkL1/.cDs1IUzYgqnu0GpvTIJKbijy2dO8nUu9xIOIGvf5eba', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:13', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (483, '202001010109', '逯惠君', '$2a$10$fHRbMJ.80GfjEiwG5IWBG.LpIPTY.1rrhKiwO/5jYP5Uf7YyNjR5i', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:13', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (484, '202001010110', '罕星河', '$2a$10$HVppElLFCoSW.L1akNjR5u54GSojx4WNSTDgrw2rIhP2SOr4oHp26', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:13', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (485, '202001010111', '裴惜蕊', '$2a$10$IvIqlpfWWWr.necLc/HHT.DpSksf5DoF.RS6PzzBQ/Jjr6vwpC3IO', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:14', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (486, '202001010112', '摩云飞', '$2a$10$YPb9h4LPtYqq6yVI5frE7.Tea.byZZ1yqyK1MpbS9Ishp.d2Rng.q', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:14', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (487, '202001010113', '龚灵阳', '$2a$10$hyipkpYv4RgPBdM.HyNbiu180zQobkV3SV7JP9YQ0NmHueYwQFRlm', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:14', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (488, '202001010114', '臧飞跃', '$2a$10$j.vUpJQT.BWlA9lSvOakXOedfnVpAdAxKbNBh.h/BXj2/Y56n33vy', NULL, NULL, NULL, '男', '2020010101', '2021-11-04 16:37:14', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (489, '202001010115', '詹清华', '$2a$10$DxU9etGGl86pjD/RXfIK7e1vTJSD3aV696W18A07dQmxb2AVGdMa6', NULL, NULL, NULL, '男', '2020010101', '2021-11-04 16:37:14', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (490, '202001010116', '斋诗霜', '$2a$10$Yx4/hO4Qhb38FJq8iVA0QeMBKBcO6DQzi2VtyxSS7I5aBpwgZr3ZK', NULL, NULL, NULL, '男', '2020010101', '2021-11-04 16:37:15', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (491, '202001010117', '暨智明', '$2a$10$m5QksHwA5tUOKaKV5yXi7ufIKrhT/R67oygIB30pF/xJ6xlIAjA/y', NULL, NULL, NULL, '男', '2020010101', '2021-11-04 16:37:15', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (492, '202001010118', '文夜卉', '$2a$10$AvgM65qqB6viGQjz4HLgGuGOBsNqTqWnVQuYgeipuXlK3ntpmfuqq', NULL, NULL, NULL, '男', '2020010101', '2021-11-04 16:37:15', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (493, '202001010119', '侨元绿', '$2a$10$JnB6E7jbSgyro8aJ4Xrxy.GlbtX75F6R0V11LscRNyxA6.L9ztIsy', NULL, NULL, NULL, '男', '2020010101', '2021-11-04 16:37:15', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (494, '202001010120', '缪浩漫', '$2a$10$mx0vqNnT/J.iqqsf/qCeueR01G5068ACMHvjDbehLOj0aMIVCRIfG', NULL, NULL, NULL, '男', '2020010101', '2021-11-04 16:37:15', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (495, '202001010121', '招兴旺', '$2a$10$7.MZKsz3Wgw6WJM1ckFIDueep6Nagjm8uDPtprMT7alRTv903nlrq', NULL, NULL, NULL, '男', '2020010101', '2021-11-04 16:37:15', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (496, '202001010122', '智飞虎', '$2a$10$X3pPQTnJK/sKG7p01NqdjuzQcs6F90S.KTLHu19/G29RL6XSqLpdS', NULL, NULL, NULL, '男', '2020010101', '2021-11-04 16:37:16', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (497, '202001010123', '告绮玉', '$2a$10$rzdXOLnZ8dAOnpbZ0j/ZoeyYKtJqZu44ar8ZxtVq4wdBwd.3042se', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:16', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (498, '202001010124', '蹉婉仪', '$2a$10$7Ek09hbrqtslJXnEpwn0LuuK54XcDu0AQineY/pbasVgpmlJiPimO', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:16', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (499, '202001010125', '章丹彤', '$2a$10$oRQWywVBQGmdMPtxNFb/pu1DKFG3gyCOfl5bsZzuq4FA/CYJ8VqQe', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:16', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (500, '202001010126', '希天曼', '$2a$10$5CtQC0wNuBvy0eB.QwSWTuVH5Y3rJpPholVHoOasZqcbNC1wlTw3.', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:16', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (501, '202001010127', '繁雅柔', '$2a$10$7vfFvmcrmthTYnjGkNZLGOn3QRDyBB0qS5GQgQ/bz08tvGQs/2aoS', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:17', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (502, '202001010128', '钦雅彤', '$2a$10$jlSBV15G5/SSbIlGOTKT0ucnp4gGJf.1tkyvfNMdo32OBKnWYl2Bi', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:17', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (503, '202001010129', '莘云亭', '$2a$10$BncHR88NjIUb1jlqll6Hp.p7iWT0BbqQelPTKHQ63mmo5QZwqRwXy', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:17', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (504, '202001010130', '麻晓灵', '$2a$10$pipjjOj/eFbTqjkbRn4PouuIUt7GJVgtb46HmP3TaqvCsPM1oj00u', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:17', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (505, '202001010131', '喻文轩', '$2a$10$BscIcRuAgQUM0PIjamqd4uC7u3y5hSH/cRWXgeYeH0kezJJYvnKeC', NULL, NULL, NULL, '女', '2020010101', '2021-11-04 16:37:17', NULL, NULL, '0101', '01', NULL);
INSERT INTO `tb_student` VALUES (506, '202007010101', '剧震博', '$2a$10$A4Vqy0k6d7sMOZUq/EbJ1Ot/9VdrGf7rgXb7V1mBVs8BjTrFOx0Jm', 'https://ljm-bsimg.oss-cn-guangzhou.aliyuncs.com//img/1646127137048bbtc9sb5ih', '', '', '男', '2020070101', '2021-11-04 16:39:01', '', NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (507, '202007010102', '邢项禹', '$2a$10$jo2G7D8jKFVR4KttPNAXEeSFxGbu/5xJWtdu0.y4sYvZ2bcYDxiiy', NULL, NULL, NULL, '男', '2020070101', '2021-11-04 16:39:01', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (508, '202007010103', '逄霞绮', '$2a$10$8Sba/WOTkYrH59mGk5KTwu9nNg382OeUMALXVIbF7DLx19eA1/CLW', NULL, NULL, NULL, '男', '2020070101', '2021-11-04 16:39:02', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (509, '202007010104', '偶智敏', '$2a$10$8OSrffJeVVdIX8MTWrV8ouRfkYYe0KxwWXBKHVVMDDa9AjyOvxxau', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:02', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (510, '202007010105', '邓灵安', '$2a$10$MxhU.xqWAOwgj.eG3/B5duIIsg9v8PZsxl.qG2rcEMi2WQIwqaXjO', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:03', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (511, '202007010106', '资信鸥', '$2a$10$0KppdtnhvaEPRIrpJ2O6MOl0sDl7qyuOdyf2rVWTR4.o6kiW7QT42', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:08', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (512, '202007010107', '隐卿云', '$2a$10$G/cu0HFqFwWq0wAAMOXlIOAYiqP/lbrBH8.Lh4Mxbmt7dnqoUqVru', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:08', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (513, '202007010108', '奕语梦', '$2a$10$r0CFORnKhCw3Kyob3gVf2ek0KdM5fnS8sUSsYsEOxgRd.YLj3rxmK', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:08', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (514, '202007010109', '奇灵萱', '$2a$10$/y7PelumWWRP/NDIs3XXcOkuP.sOiLVVSID3/BXekM4ZbFDeNj/ri', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:12', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (515, '202007010110', '操幼仪', '$2a$10$w9uRXCB25Pv8AAQ9QOrGU.pXQ1.JU0CsfXC7Kg2D1aRDcEbro52Vm', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:12', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (516, '202007010111', '军欣嘉', '$2a$10$smaQ0YubFA97enyKXGhgCugtPhRKmYLHqmoN4NyC.uLoCA4rDTI8e', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:14', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (517, '202007010112', '宗诗蕊', '$2a$10$Ii8IjAhvoh5msA8iBBcosOw7v1gB2o5lARB3d4u7nQRCIibQ8qIPq', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:14', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (518, '202007010113', '丹初曼', '$2a$10$.9Ql3pC3mi/yqX8ICPWiaeTxraVN1ZZzOhWxBt7HLmnlcgVEysPZa', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:14', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (519, '202007010114', '俞荌荌', '$2a$10$sW/AZmUMpW21KJ8K0Aw/HOPMUzGbKccw2HJfymjvAWF1bDaEUysp6', NULL, NULL, NULL, '男', '2020070101', '2021-11-04 16:39:15', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (520, '202007010115', '干念真', '$2a$10$ogekfWSLmgsPawfVL5lE9e7UGjQdV0Cw8jXnXsnzGKHcwag1leBDm', NULL, NULL, NULL, '男', '2020070101', '2021-11-04 16:39:15', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (521, '202007010116', '庹丽泽', '$2a$10$bFOYyOysVL.9w7WUGYMtWu12EC/4NgR8o.munS.EcuD0Px6bPKo5i', NULL, NULL, NULL, '男', '2020070101', '2021-11-04 16:39:15', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (522, '202007010117', '俎颖然', '$2a$10$Q2yu6d6wA1hRAZfpAqVjjevZeYW.iyKEzzOqpM2kxEZ2JXSpOidZS', NULL, NULL, NULL, '男', '2020070101', '2021-11-04 16:39:15', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (523, '202007010118', '敬颖颖', '$2a$10$DKCstFS4QsI5bxCwm7yCyO53vn/G6LGs9VAatxOaIPT2b3fwQbKl2', NULL, NULL, NULL, '男', '2020070101', '2021-11-04 16:39:15', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (524, '202007010119', '莱浩博', '$2a$10$SNQDqWQtZSfCOFfVf3USQuwfljEgQ0jnQ6kLcKSMeboU2K4g.rts2', NULL, NULL, NULL, '男', '2020070101', '2021-11-04 16:39:15', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (525, '202007010120', '盍修贤', '$2a$10$2vgfEvux5M8BAJg5YwETb.alT/yywD6X8k8/dVg4tLt5OCTZCKNNK', NULL, NULL, NULL, '男', '2020070101', '2021-11-04 16:39:16', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (526, '202007010121', '展冰冰', '$2a$10$fE/pTq8DKmjJq34q9fztPeSCsKBwXnRRVBIgaYhNv1VaGOU.SAx9q', NULL, NULL, NULL, '男', '2020070101', '2021-11-04 16:39:16', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (527, '202007010122', '镜宛秋', '$2a$10$cExdTsqsu.upv3zot0/cfOvO7.TunkoA/aThZBX6m3UeLZV8Ceh8m', NULL, NULL, NULL, '男', '2020070101', '2021-11-04 16:39:17', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (528, '202007010123', '蔺曼丽', '$2a$10$aEW7caVZt6ilJiRQDjAvjucbvOWY1tgLZSUasBBNGOo4tdNJ11cXa', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:17', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (529, '202007010124', '管伟泽', '$2a$10$mIOHILtKmXmFTF7GMHvs8.G7MdUeqiKCuNbBMFsyNBWZI3f/FT.IO', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:17', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (530, '202007010125', '允斐斐', '$2a$10$caQxaHvrpcSHKR0mlTSPkut2E2tIurs9gC0TnYDnG/sQf71CbeyDa', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:18', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (531, '202007010126', '尉孤云', '$2a$10$9gdJYdy28n4sUBrcUImWkeO13oeJX.VJpzo0KMf0X2Ker44UewUkC', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:18', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (532, '202007010127', '员沛凝', '$2a$10$P9.PRTvbjMD4QdUTwnXdfu.2muZ7vAMpCmIuSJzYwaC2PVouCAkge', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:22', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (533, '202007010128', '戎正雅', '$2a$10$toC8ABVXXBjTy0Jqp0lmZuRHYaUi5ytmUoIYlfEzady6IqihH9LQS', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:22', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (534, '202007010129', '信涵菱', '$2a$10$XMfXVeRlIB/pEP9BNKWwnuK5hMPl1n1SnvSzua6E6q6YIMu9BzK3u', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:22', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (535, '202007010130', '柔念蕾', '$2a$10$b0ROf0A5vShpzYzRc4/VIO04Jjg26oXr4oXU03YGvt1fq9htNX5d6', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:22', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (536, '202007010131', '鄢静涵', '$2a$10$gitQJ9etZcEbOafaLSQzFOeRnKDDd/r/BvXU/m/GiGMSrCPZSsLsW', NULL, NULL, NULL, '女', '2020070101', '2021-11-04 16:39:22', NULL, NULL, '0701', '07', NULL);
INSERT INTO `tb_student` VALUES (537, '202008010101', '赖阳辉', '$2a$10$RcjBx5NpvZZZz9rWbKQaHOgoikkhJVyxTrRc6snlNyS0GvXlKQtlW', 'null', 'null', 'null', '男', '2020080101', '2021-11-04 16:40:26', 'null', NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (538, '202008010102', '胡正初', '$2a$10$moHK2l2j1lK6Hz0QKUwaAerciO.KDp9bbUqTVPyQyzLBn5IJbWc4W', 'null', '', '', '男', '2020080101', '2021-11-04 16:40:27', '', NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (539, '202008010103', '闳韶阳', '$2a$10$zu2l6NDM79JmCC6VkZ475uvegalz4ZJcTKKrD9.cCR.z0CSTFjUIa', NULL, NULL, NULL, '男', '2020080101', '2021-11-04 16:40:27', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (540, '202008010104', '豆向晨', '$2a$10$yihtNszKvtI4A2hYHAhyheu65mjsDFGASjQeb42hKLVUBMBnumCNK', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:27', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (541, '202008010105', '却友菱', '$2a$10$ZRDNfiGUDcvFIw0CcI5oxu3i9CmTafcpdYN2C4uk3vApKfEvKlIga', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:27', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (542, '202008010106', '郎听双', '$2a$10$uioCYiBqBkKbMhyML94oD.ns8HPmSBErYb1inNi2d/dgC7eKgje2y', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:27', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (543, '202008010107', '滕醉香', '$2a$10$hR8dQ6ybyXnnfsQ7EQBymueHpPkscs7Jy2RHn3s40eG6flxb48cDO', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:27', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (544, '202008010108', '璩君昊', '$2a$10$D39DJLMa9SVE0iiZ6wYAB.evsm0wogsxRe7LVZPpvZ5WSa5ltDrlq', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:28', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (545, '202008010109', '独竹月', '$2a$10$Qe3/k5KvzkLfyUlt6ZMDe.A0f9vSR2pWeXru0I4TkvDdGTLArtQEq', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:28', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (546, '202008010110', '沈晏然', '$2a$10$5j/QiYIZBuSqFqP3i7D/J.u9SKBauGr.Oh2D9AkMytg867CJbu1sq', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:28', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (547, '202008010111', '袭安娴', '$2a$10$8rSfQmZ.w.tSC9ew6lcrM.uXTdwpT090mz.4RBw4Tl8wNEsUzMIf2', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:28', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (548, '202008010112', '衣雁卉', '$2a$10$LYkyfHqcXAU52VMABGVqIufzgWc4ysYxHwzzh0HISqjYTwxMmNP/u', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:28', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (549, '202008010113', '卑醉波', '$2a$10$HtsVfwBA0RuLup/AnTpj9.zHl8ZKzzGjL1xvp4WySTKLij4eQM8Me', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:29', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (550, '202008010114', '褚娜兰', '$2a$10$49TtXFJgXUkXrjPoGV6lzuz3ECJfwKPvn77PkeoEMayBGIsOZBs0G', NULL, NULL, NULL, '男', '2020080101', '2021-11-04 16:40:29', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (551, '202008010115', '俟晗昱', '$2a$10$JFbO3ipAURrn7P2GQxBlFO5llpdwbkPAD..OUQcA/zwspJDjrnbFW', NULL, NULL, NULL, '男', '2020080101', '2021-11-04 16:40:29', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (552, '202008010116', '羿倩语', '$2a$10$MDw9pKJgZQsa4o2X9xyHnewBcz0ZAOfjLDtkQKCHdLEz2.i6D/XBu', NULL, NULL, NULL, '男', '2020080101', '2021-11-04 16:40:29', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (553, '202008010117', '蒯惜玉', '$2a$10$WqWjq.5Af9QgVTLf3gOhx.wDMgjHBU3ftNYT5PXnPJPAP4UC9pfZK', NULL, NULL, NULL, '男', '2020080101', '2021-11-04 16:40:29', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (554, '202008010118', '于悦怡', '$2a$10$6YxdpDtG8/9caXkjxz96cO3q7Q4ERgfhx3y2RC/ZQnz.U9hvmzJVy', NULL, NULL, NULL, '男', '2020080101', '2021-11-04 16:40:29', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (555, '202008010119', '夏沙羽', '$2a$10$QQvMHRjRvvTHEolZI0pBkuqMnH.SQ1XmX5lAez9egrELLzOY7LoUG', NULL, NULL, NULL, '男', '2020080101', '2021-11-04 16:40:30', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (556, '202008010120', '粘晓丝', '$2a$10$kIYcSIWCJj3.tuqZWnWH3OBGpAqlyyjm2oUcY6n1MNQr0VzGsY2Xa', NULL, NULL, NULL, '男', '2020080101', '2021-11-04 16:40:30', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (557, '202008010121', '伦莺韵', '$2a$10$aMapMCOkdOrcnrZJuB19/.UrvzHveibhtXdnPGNmLdWmNf.voh17G', NULL, NULL, NULL, '男', '2020080101', '2021-11-04 16:40:30', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (558, '202008010122', '锺巍奕', '$2a$10$UHsYrGtYuB0HaqQHN3Ic8.OIEpr0mOtBl/hQXpWruYMCXpacZm9XG', NULL, NULL, NULL, '男', '2020080101', '2021-11-04 16:40:30', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (559, '202008010123', '延流婉', '$2a$10$kcVn06BIEK20LXc6ns/VFOcTpksCxglqQumHBCpygVNqGAEzrAEKq', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:30', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (560, '202008010124', '野芳菲', '$2a$10$hjqashSRRJ51ePAZ9.rrNe8O/NGu6VsaQYqkAwL/WnTw2nEpM8epa', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:31', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (561, '202008010125', '仆秋英', '$2a$10$8BVRXHv/lDo3zoBkeZ32xODa/FvxsUKHyWQ9mFS/Lpb9OQ6wsYsbC', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:31', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (562, '202008010126', '悟梦月', '$2a$10$rpTtJLs8ayH1KREopnDl2.3ydYBtF2IokPWLvoGeBJusYBckvfNTi', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:31', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (563, '202008010127', '初夏菡', '$2a$10$zyRf8bHRH0rh4Id0yM/jg.kFajAqeSovH.z1k/tVqpOqTBywwt42C', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:31', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (564, '202008010128', '粟虹颖', '$2a$10$9I/1648Ji1Cfy5PqmkyUKunnlroYaRV5y5gwy4lLL79ahPDD6Ss/y', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:31', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (565, '202008010129', '九欣欣', '$2a$10$LyH2TQpaVa8VIVIZH863Gey1aqWRnZX2sgLky3o6xm1Qt/fkCaFVa', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:32', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (566, '202008010130', '李心慈', '$2a$10$SFesihWH46Iwx0241dv5EOLFs.nWvPiIhxSZ/cDzC/D.LYF34ttiG', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:32', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (567, '202008010131', '谏含芙', '$2a$10$gOnywe6rqaPhTlFNSb1D4e2X4.Rc8F8071WvggK.hZuLDVViybiEa', NULL, NULL, NULL, '女', '2020080101', '2021-11-04 16:40:32', NULL, NULL, '0801', '08', NULL);
INSERT INTO `tb_student` VALUES (568, '202009010101', '夫温书', '$2a$10$Fi/E1AH2m0.OivsZKAR5xuWq6k9TNKyWtIJcuBwg5OrpOToMQtb5e', 'https://ljm-bsimg.oss-cn-guangzhou.aliyuncs.com//img/1641602570241oxtyj2zxo9.jpg', '', '', '男', '2020090101', '2021-11-04 16:41:35', '', NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (569, '202009010102', '赏鸿畅', '$2a$10$jLTaiPmF/l8QLArzXRv17.EYstm6n24orszN7XQSuS4Z.M0qygaQe', 'null', 'null', 'null', '男', '2020090101', '2021-11-04 16:41:35', 'null', NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (570, '202009010103', '袁逸馨', '$2a$10$npNXjHPw0A8QNgbZulD9QOJNs9RBCooHo.l7kzbkw.ApKPOKpyoO.', NULL, NULL, NULL, '男', '2020090101', '2021-11-04 16:41:35', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (571, '202009010104', '庄念巧', '$2a$10$hfeNrEngH0P/1J0WngECOehz66WmAL19megcUStqUYRYafRodiZzS', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:35', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (572, '202009010105', '廖灵安', '$2a$10$F/ejrsJVcti9vKCUY6QwSexfzKXpTx9gqTZskzJS.ptywz0PigT6.', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:35', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (573, '202009010106', '瑞光耀', '$2a$10$.BIUGIpnbXpOhrck1X3AHuAQjqqW4junVfFHPYh7Ch2DVXZcNwvKe', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:35', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (574, '202009010107', '才曼语', '$2a$10$3mgQwAeQKGQ1Kegv6NAnqOJsuD8tW8Xf2k19SpTzF2u2TyY9PQq6q', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:36', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (575, '202009010108', '牵盼芙', '$2a$10$fP9Ogx8jn1RK2TKde70FuOUUM64uhMMi8VTSmvySPm87msO0MpRTm', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:36', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (576, '202009010109', '郎望雅', '$2a$10$Q2XkSAHmXb2zs1TBtcpx1.zqBtnoM/G57YvJdamrnRqqgPkr/iyp6', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:36', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (577, '202009010110', '说多思', '$2a$10$fxVcya1puRef00Xie5kSvOeimtgjGQ33EfJWfSwjK0rCBZ9s8kGwa', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:36', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (578, '202009010111', '寸和悌', '$2a$10$3nGt8KbtUt.8tu1femGBLuCFjz79EemQIx.yRNudvEtwfgRRGE.yG', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:37', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (579, '202009010112', '城智志', '$2a$10$sBNGij2myuFz9FKxmIiiAeIAWbY9kzrvnJYw42Nbspw69SRLD/z8q', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:37', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (580, '202009010113', '解雪卉', '$2a$10$FN8iE/ACpsO0B1N3S9XKh.3zHIqPsamP3YgaXJV2p7sBCWT9MP2gC', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:37', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (581, '202009010114', '硕绍晖', '$2a$10$.WuPWb5fSuTE4ngAOHROTOi0QShfh59GLCyhWqTt7Dsecfe1S0/Ru', NULL, NULL, NULL, '男', '2020090101', '2021-11-04 16:41:37', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (582, '202009010115', '岑幼枫', '$2a$10$4T7b2KuD6nJSwrAycurjeOFX5DfugJLV69ymTQE/1toU0unodQvRG', NULL, NULL, NULL, '男', '2020090101', '2021-11-04 16:41:37', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (583, '202009010116', '独安安', '$2a$10$qoPbJPIXSAoAvB04t2zynOgQpqbzSkEH2BrdcmdO7mPh1d.QDTLxe', NULL, NULL, NULL, '男', '2020090101', '2021-11-04 16:41:38', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (584, '202009010117', '焦玮艺', '$2a$10$LGUjtt6KkA8MhFKjwpcXP.OZ1hFIHUZG5f07zB2WRMqMreK/bb1.a', NULL, NULL, NULL, '男', '2020090101', '2021-11-04 16:41:38', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (585, '202009010118', '傅良弼', '$2a$10$V61qGod3wHphMlNQNivgCu/4Ul6F6WMoH8j0rrMDNd3Glov/a2p1S', NULL, NULL, NULL, '男', '2020090101', '2021-11-04 16:41:38', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (586, '202009010119', '己曼寒', '$2a$10$Pyj2uVL4XPGOGTn4Txjos.d.LdJByaF3pqK84fcYoVYUXDq3qar3K', NULL, NULL, NULL, '男', '2020090101', '2021-11-04 16:41:38', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (587, '202009010120', '益莹琇', '$2a$10$W.kTzzd/72/IjRw8wBqrJOK6GjW7FQ.yHvknv9U78/9f.swsUqFQ6', NULL, NULL, NULL, '男', '2020090101', '2021-11-04 16:41:38', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (588, '202009010121', '爱浩皛', '$2a$10$B9fPG6hWXRO1WATjPE/fbuIIYUkxxaWUes/J4xMJvGn6v6rzEA7xm', NULL, NULL, NULL, '男', '2020090101', '2021-11-04 16:41:39', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (589, '202009010122', '亢痴柏', '$2a$10$uCQqw9pnBNF05F8BTgYDB.oHIFyb2YJPL0XPYLI.n133wWB5NaFA2', NULL, NULL, NULL, '男', '2020090101', '2021-11-04 16:41:39', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (590, '202009010123', '法沛珊', '$2a$10$VOT4HX5ZmYSmBEhoro0CYO1MP7Ec86Vv.aP8urB1PLozSw6j0RfnS', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:39', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (591, '202009010124', '庾恬美', '$2a$10$LpthGGFxEhvdQtW/ORRGp.i83k.kBDlc.FyZQfOlmWG8dwO8UdFk6', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:39', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (592, '202009010125', '针芷天', '$2a$10$8.NaCIuzdPZ6CCnoZ6Rnruh9IiRVUuFWfbITImRFqv8mwgNPOAkD6', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:39', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (593, '202009010126', '桂代柔', '$2a$10$165v9jj2u3rdpRW5/IwHQulJYeR2WTNE2T23ogk1oQhPji1Wj9K5K', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:39', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (594, '202009010127', '苦司晨', '$2a$10$7ToPvdvj./q71GME6CihaewdJWP3GxF1/EPF9d6Gx05I7soagMW4O', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:40', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (595, '202009010128', '萨佩珍', '$2a$10$347fpkzsf7Wpw3pYmQVU2ecaZJk5ajrsoZhTUwEyat2FiQpWh24lq', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:40', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (596, '202009010129', '招静槐', '$2a$10$kjfalgASkPE25q3.Q8SQDO8wmI5qGe6oqtqADLScAkoUSUtXLAayi', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:40', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (597, '202009010130', '樊又莲', '$2a$10$OF8GFcRQ1FqCCpOYSRAs/u.6jgpt5kwB8nx0UfZSAUltH7ik9I81e', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:40', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (598, '202009010131', '首若云', '$2a$10$jaK10Sr7sBzpZE9btCZFD.HXkKjsfCYpXahx42V1mdMJGVf/OWydS', NULL, NULL, NULL, '女', '2020090101', '2021-11-04 16:41:40', NULL, NULL, '0901', '09', NULL);
INSERT INTO `tb_student` VALUES (599, '202010010101', '营泽恩', '$2a$10$MMr2dAaui4.ImjLBaTYJaOSK7YFciQ.lUsdrEzlXHY3SFA09wtQsy', NULL, NULL, NULL, '男', '2020100101', '2021-11-04 16:43:17', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (600, '202010010102', '梁白夏', '$2a$10$lag1WCiF6wotfEs1w66V1.k3yVpyPDjByRgtzgPwHEyiAJ407pxFm', NULL, NULL, NULL, '男', '2020100101', '2021-11-04 16:43:18', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (601, '202010010103', '双以冬', '$2a$10$bSUGspi7Eu/1wRpoV1Tr7OdQj3tvr4Rhcd1.Z9cirafefS/Haz6Le', NULL, NULL, NULL, '男', '2020100101', '2021-11-04 16:43:18', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (602, '202010010104', '班清佳', '$2a$10$nvRvWDRFscCkmYG7SeTOneaXBVH7s6.9oIhSeSTXup7Rewj4y/K/u', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:18', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (603, '202010010105', '达浩壤', '$2a$10$gAHvZ3qa4CNfgfMf0KFEqe88xeuWhNG/g6b5WIVqY3ehQmH42T/4e', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:18', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (604, '202010010106', '项雪翎', '$2a$10$mB/qqiIJH7/S4Nu/3xkrqOQOwMLh9gyvZ9TNIlnACKissHEgqnmWm', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:18', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (605, '202010010107', '缑清霁', '$2a$10$Z0BuYDdW6jbPZeXY9gmnVOZXgQ6/ecEqTcU7dihUEQWRTCG87JmS6', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:19', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (606, '202010010108', '节喜儿', '$2a$10$oojx5r97E.BLGbE3SqLRLOeQx9IaLgujrFMVaDBQvVaVgXgj0ZpEW', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:19', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (607, '202010010109', '宰香天', '$2a$10$T1u9cfPm8kXSRQdf2ENAQeOM.6VXDK9ciXTIxji6aQsK.zXOGWB82', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:19', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (608, '202010010110', '泣如云', '$2a$10$4WIOXbA5nAmaTrf8D8nG6uUtyhdKvT.Tna2u0RkyuLPrSzukSxG4a', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:19', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (609, '202010010111', '端雅唱', '$2a$10$z20OzSDTVDRgCVPbWUqrsOmfwpvL8IVkA2Ge6yRJkQB5d/71mPtPi', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:19', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (610, '202010010112', '悟康泰', '$2a$10$h7MSkV5lgGaxQyGxzesXhONxPm5oTtMX.FRorBO0zJrldGXr/EJzi', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:19', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (611, '202010010113', '凌湛蓝', '$2a$10$9/XQ9HPojHEND07dsVeKGOKbmIPs6R.CsSsVtKv3yW.LcchVupOHS', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:20', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (612, '202010010114', '俟飞双', '$2a$10$YEpNloPPgiAOmM3I7j6pEu3tVDh2jZawQ9m/BvjFaCog4izgAEVhK', NULL, NULL, NULL, '男', '2020100101', '2021-11-04 16:43:20', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (613, '202010010115', '漫博厚', '$2a$10$UrXnIdwctNaPcx.pt/Nhhu0vZDUq1lMOjUGvVNa4TeNEgAVRtaHku', NULL, NULL, NULL, '男', '2020100101', '2021-11-04 16:43:20', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (614, '202010010116', '訾凡巧', '$2a$10$ZBiuSRfgsSZbg9PBAcLMpehjNpJb.DqjtJm490LtFdHDERTX.yaKq', NULL, NULL, NULL, '男', '2020100101', '2021-11-04 16:43:20', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (615, '202010010117', '泰良策', '$2a$10$0JkL/MYrNLt7yWU6KeU4q.ly9hGtR5u7dM1acWH9p41XqdUmUQA3q', NULL, NULL, NULL, '男', '2020100101', '2021-11-04 16:43:20', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (616, '202010010118', '弥凌青', '$2a$10$0Daf0FguiwLDx/1YxiE3b.PZEOm4sYVMWbVXTO3uvSZM99nObXyVu', NULL, NULL, NULL, '男', '2020100101', '2021-11-04 16:43:21', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (617, '202010010119', '段驰月', '$2a$10$2Xv76NB6ePn0doEYXIkzZOs5WztATCr1CVj381CVACXVABMjRPeii', NULL, NULL, NULL, '男', '2020100101', '2021-11-04 16:43:21', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (618, '202010010120', '相兴昌', '$2a$10$CxrREjRRErDm9PxGCQlFr.rEgmwykbXONcPBCMKbqPaEgFTDc0Gj2', NULL, NULL, NULL, '男', '2020100101', '2021-11-04 16:43:21', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (619, '202010010121', '召妍晨', '$2a$10$iDan5dKRyc81HgYs3K40H.mCdcz05jTae2L5cn19I7trLYem4AriS', NULL, NULL, NULL, '男', '2020100101', '2021-11-04 16:43:21', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (620, '202010010122', '是嘉淑', '$2a$10$ELe9hEjEQ9p0J8r/SsJThu/ngr4wYbQ8cJNejpYQUso9F2AozZY3O', NULL, NULL, NULL, '男', '2020100101', '2021-11-04 16:43:21', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (621, '202010010123', '石浩歌', '$2a$10$JzXNhRKm8wztWS01KrBYDOtHOfPbzbtlS49n6RQWL5bGM59AcL74S', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:22', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (622, '202010010124', '仪凯复', '$2a$10$P98CFnnVecg7/C.HnMoAzeJLdzxUEURw/5Mc1Vv9Jw3idTbOZum86', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:22', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (623, '202010010125', '鲜弘致', '$2a$10$nvAx.d6HCf2J.p7o1UvJhuFOjTV7yRTQSxuHf/OqnzNZMH9zDnmZ6', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:22', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (624, '202010010126', '戴巧夏', '$2a$10$YtjPWe76UPLcGy8YuFJ4Key8So6hJxqo80up/PqzJd.cRwsPV9ofC', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:22', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (625, '202010010127', '佛梦秋', '$2a$10$DwGKnUmKAnkxU.rHlf8Nc.uw4AwA/PBLKh5XFf2Z7fravlZRu6sBK', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:22', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (626, '202010010128', '戏流逸', '$2a$10$WsAHge9xPhHYA8OQvAcCs.KrE.IZZhyY9fyzbMASJNPBk1s6VOZDe', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:22', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (627, '202010010129', '刑雨兰', '$2a$10$zBv.Bmrez3rUA2tQ6bLde.h20ewnMYEAz0oaw/rxRh58pVFTckDFC', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:23', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (628, '202010010130', '伊访风', '$2a$10$qcxu.4jh8dObBt9Ny9IfsOStZhwlmadZMXKUk.lUeCM63wHNvQOvW', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:23', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (629, '202010010131', '宣凌雪', '$2a$10$MQnfplR9eK9n9LTzq5S2reTRua.N2FKLJWTrGnUlapZD9gBt6I0zG', NULL, NULL, NULL, '女', '2020100101', '2021-11-04 16:43:23', NULL, NULL, '1001', '10', NULL);
INSERT INTO `tb_student` VALUES (656, '202001010132', '撒擦', '$2a$10$W4e1Qt9qa9pC/OO5RMabCOkJi/EnOut8rJim0UGD9ntqDDwYBhVxK', '', '', '', '男', '2020010101', '2022-01-08 12:08:34', '', NULL, '0101', '01', NULL);

-- ----------------------------
-- Table structure for tb_teacher
-- ----------------------------
DROP TABLE IF EXISTS `tb_teacher`;
CREATE TABLE `tb_teacher`  (
  `teacherId` int(11) NOT NULL AUTO_INCREMENT,
  `account` char(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` char(6) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `headImg` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `mail` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sex` enum('男','女') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `classId` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `createTime` datetime(0) NOT NULL,
  `phone` char(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `loginTime` datetime(0) DEFAULT NULL,
  `academyId` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('教职工','辅导员') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`teacherId`) USING BTREE,
  UNIQUE INDEX `account`(`account`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 155 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_teacher
-- ----------------------------
INSERT INTO `tb_teacher` VALUES (48, '2020060001', '封书文', '$2a$10$csFjlCy9cXXEjqVyI0KEg.dWHjEnUvn/KVdgw3kGuNtKjPjLu9Yxa', 'https://ljm-bsimg.oss-cn-guangzhou.aliyuncs.com//img/164146041543879e6928y0k', '', '', '男', '2020060101,2020070101', '2021-11-04 16:53:15', '', NULL, '06', '辅导员');
INSERT INTO `tb_teacher` VALUES (49, '2020060002', '库访曼', '$2a$10$ifMmoHwCZSkcTg43.hF7b.Kq07eHdGwK1Q93o9mnni8BhGTafg/Hu', 'null', 'null', 'null', '男', '', '2021-11-04 16:53:15', 'null', NULL, '06', '教职工');
INSERT INTO `tb_teacher` VALUES (50, '2020060003', '韩嘉怡', '$2a$10$5RTRNApUuz7c8y3jUV22LOsbqA5A7wPefL6ymI7XlUO5fxTeDANa6', 'null', '', '', '女', '', '2021-11-04 16:53:15', '', NULL, '06', '教职工');
INSERT INTO `tb_teacher` VALUES (51, '2020060004', '让承宣', '$2a$10$2ErPAs/MYP012joD7FrpeOzc6VMMDih43u3W1UVcImpZBNgzmsbP6', 'null', '', '', '男', '', '2021-11-04 16:53:15', '', NULL, '06', '教职工');
INSERT INTO `tb_teacher` VALUES (52, '2020060005', '栾英资', '$2a$10$kmkfrKh5.JXXNhNi4c3rmuLxR/VXiH7v5npOwNRlsNNWSFzKLyzMu', 'null', '', '', '男', '', '2021-11-04 16:53:16', '', NULL, '06', '教职工');
INSERT INTO `tb_teacher` VALUES (53, '2020060006', '满朗然', '$2a$10$gsKwjsYo4GhgdnyZjxrIzeJumiKUtg20a4hKceRgqDSOr.McFUrdi', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:53:16', NULL, NULL, '06', '教职工');
INSERT INTO `tb_teacher` VALUES (54, '2020060007', '关晓蕾', '$2a$10$1S33dqsOZEF2KcO.g0Q2euonS3Jp7jGjzcureMj.lc36WxbY0.gKK', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:53:16', NULL, NULL, '06', '教职工');
INSERT INTO `tb_teacher` VALUES (55, '2020060008', '霍雪瑶', '$2a$10$AJ.nKSR4P84yCNdIxNj5uOXeyqnwaalCQ9bSmdfOB4KMGpJBziCwS', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:53:16', NULL, NULL, '06', '教职工');
INSERT INTO `tb_teacher` VALUES (56, '2020060009', '韶湛芳', '$2a$10$3bHu89danqsDZpAI0VQb8Om9PnR0nM4Blglg43pFcqQph77J/QKEy', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:53:16', NULL, NULL, '06', '教职工');
INSERT INTO `tb_teacher` VALUES (57, '2020060010', '续鹏煊', '$2a$10$UyBFRC/U9863r06Lrw/6T.RAoOyeS5tYId5GeV67DE0opz.gLcXmC', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:53:16', NULL, NULL, '06', '教职工');
INSERT INTO `tb_teacher` VALUES (58, '2020050001', '厉俊远', '$2a$10$vNrkLSbkw1qAoy3rnvVQZ.ReiGGQinbO/WKjoBMaBANFtd2feMvke', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:55:05', NULL, NULL, '05', '辅导员');
INSERT INTO `tb_teacher` VALUES (59, '2020050002', '华兰芝', '$2a$10$pEyuTuLBwYaPtIgE6K4e7uHJ1x1H33TAGLImetnelCkgAoEqWsqAO', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:55:06', NULL, NULL, '05', '教职工');
INSERT INTO `tb_teacher` VALUES (60, '2020050003', '申岚风', '$2a$10$9vqPfAwaAXld6IBkPCkAoeZZBEsNd.e0U/47RwTyj4ldplYb56oQm', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:55:06', NULL, NULL, '05', '教职工');
INSERT INTO `tb_teacher` VALUES (61, '2020050004', '晁初柳', '$2a$10$euoLf2t3gQvgTsTXGZ4odOs.Alibqk30XDbWHuKD95.DXAoPJCKX2', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:55:06', NULL, NULL, '05', '教职工');
INSERT INTO `tb_teacher` VALUES (62, '2020050005', '胡文林', '$2a$10$iKtCw.Jrlxxfvvy9Qg42X.bs7HAHiwwSK4RZ3FvfpKuM4yxEEl19K', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:55:06', NULL, NULL, '05', '教职工');
INSERT INTO `tb_teacher` VALUES (63, '2020050006', '守秀越', '$2a$10$8S0mGrjOyy9Aeu1wN1xJMuuOTM6/fS9wIk8oDMxvZECSxtIvhpzLW', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:55:06', NULL, NULL, '05', '教职工');
INSERT INTO `tb_teacher` VALUES (64, '2020050007', '本君丽', '$2a$10$02nzLj.HtFMjJRWAaCSP2uMpqq689.LU8V8Fc6BpshSlx2EGuL7bm', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:55:06', NULL, NULL, '05', '教职工');
INSERT INTO `tb_teacher` VALUES (65, '2020050008', '析曼容', '$2a$10$YQngZOLqwAZzfVba7y6i6u6DwjIR2vMbpCCEOxYS81c4tN5KldbxO', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:55:07', NULL, NULL, '05', '教职工');
INSERT INTO `tb_teacher` VALUES (66, '2020050009', '崔芷雪', '$2a$10$OUCXnj1XC0bcFUxKv72XwuVsBAMTZnULozScUr9afCCVR0C.jnH.G', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:55:07', NULL, NULL, '05', '教职工');
INSERT INTO `tb_teacher` VALUES (67, '2020050010', '伟傲松', '$2a$10$dqQJQbBkbOPiN9XfBMGLkeTp2oP3eYs2Lg0vzh65j2bu3j1L36bvm', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:55:07', NULL, NULL, '05', '教职工');
INSERT INTO `tb_teacher` VALUES (68, '2020040001', '厉俊远', '$2a$10$7Nl/dMgUiMf39MHT1NGF1.Z5Dcv/SPh949BWxcq24TM3Dp3i5j7gW', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:55:27', NULL, NULL, '04', '辅导员');
INSERT INTO `tb_teacher` VALUES (69, '2020040002', '华兰芝', '$2a$10$OZDVH0/54g9y.KZzMZimtONSdOarZd/DXR/LHHplLoCGvsZzkK3vu', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:55:27', NULL, NULL, '04', '教职工');
INSERT INTO `tb_teacher` VALUES (70, '2020040003', '申岚风', '$2a$10$sOtZFjgKdRjWpt0YnMTcb.I0rFyPkZ4O5EYDkQFCVj8zxEjGvNOWO', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:55:27', NULL, NULL, '04', '教职工');
INSERT INTO `tb_teacher` VALUES (71, '2020040004', '晁初柳', '$2a$10$ubth9gHsyXPW3ry89pS5yu2KlBFQmSR9/FR4unQG0jV7e.7EsQpxm', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:55:28', NULL, NULL, '04', '教职工');
INSERT INTO `tb_teacher` VALUES (72, '2020040005', '胡文林', '$2a$10$nVEoTpV7Wj54NmbZfai.Qu78WKv575F0/zogh5smP/gFIjb2pDY0W', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:55:28', NULL, NULL, '04', '教职工');
INSERT INTO `tb_teacher` VALUES (73, '2020040006', '守秀越', '$2a$10$r7jhljPK34shpMdnpiPbnuxzZsq0sxUS8mwWFkzO4jbtnoUWLnc2y', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:55:28', NULL, NULL, '04', '教职工');
INSERT INTO `tb_teacher` VALUES (74, '2020040007', '本君丽', '$2a$10$Mu3SZ9u3EL9475WmMAbOFOj0Z1EjOnCqQ/bfPImozWgF5UXt0orR6', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:55:28', NULL, NULL, '04', '教职工');
INSERT INTO `tb_teacher` VALUES (75, '2020040008', '析曼容', '$2a$10$JIR2BBKPH0A3OiUcGUDqy.lNRYLuPgRN4t4/6J72KdpnYqN8Ppi.S', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:55:28', NULL, NULL, '04', '教职工');
INSERT INTO `tb_teacher` VALUES (76, '2020040009', '崔芷雪', '$2a$10$quv/M/oepGFDVQE726ahaOOBZUh740gFXs.aiJSsyF20OPr6k9hDO', 'null', 'null', 'null', '女', '2020020101', '2021-11-04 16:55:28', 'null', NULL, '04', '教职工');
INSERT INTO `tb_teacher` VALUES (77, '2020040010', '伟傲松', '$2a$10$vaUu4BwdMwlbshmdwMnFBOYM3aP6xJgcfrTNW.FCMBrp7b3wiziKS', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:55:29', NULL, NULL, '04', '教职工');
INSERT INTO `tb_teacher` VALUES (78, '2020030001', '荀华婉', '$2a$10$OXpi1jmNYq6NQLM43x6WG.FcHtRcegkxuMnYiCEt0QQVCeFzAqSQy', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:56:24', NULL, NULL, '03', '辅导员');
INSERT INTO `tb_teacher` VALUES (79, '2020030002', '封丁兰', '$2a$10$bmNt4gdaB6aw9YqjCUSCz.JhdrXfgK91I8.oSWEabFn3UHyaIvo0a', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:56:24', NULL, NULL, '03', '教职工');
INSERT INTO `tb_teacher` VALUES (80, '2020030003', '涂采枫', '$2a$10$fWhj74fWYQRHNvRz6hfolerhBlCHy294HdraVYMjW1zte5jYbyxoG', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:56:24', NULL, NULL, '03', '教职工');
INSERT INTO `tb_teacher` VALUES (81, '2020030004', '栋和悦', '$2a$10$qLxtIz0Bk4/8iDcTPwxcGuYt5DvPg2jQu4C4PYpo.0qAx3ZnWBznG', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:56:25', NULL, NULL, '03', '教职工');
INSERT INTO `tb_teacher` VALUES (82, '2020030005', '扈高朗', '$2a$10$Xj12OErnjKg.3xmIKVKQkOEC/gErZTAMw0owc3PrQ1IE3w6E0zSOe', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:56:25', NULL, NULL, '03', '教职工');
INSERT INTO `tb_teacher` VALUES (83, '2020030006', '沈恨风', '$2a$10$rh1q9IrhQKt39mZDXYSFhebIxnXxWYaMXVt5xDNpMa4lCxFAymCSi', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:56:25', NULL, NULL, '03', '教职工');
INSERT INTO `tb_teacher` VALUES (84, '2020030007', '禾景平', '$2a$10$t599TiPCEIQkmBChc8x1kOjjEYQHfV1ilcujh/v9uSYEarrPLPFl.', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:56:25', NULL, NULL, '03', '教职工');
INSERT INTO `tb_teacher` VALUES (85, '2020030008', '叶念桃', '$2a$10$QVUBY2drV19tkekItM.SvOHTUtY2Zv.i0pCSUa8FbtVXVJKO5a8n.', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:56:25', NULL, NULL, '03', '教职工');
INSERT INTO `tb_teacher` VALUES (86, '2020030009', '汲乐珍', '$2a$10$aWNx/rRIpj9AgR9p2SoxcuMm12hrmcbIrgHS9I91IOKZusHezHzMO', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:56:25', NULL, NULL, '03', '教职工');
INSERT INTO `tb_teacher` VALUES (87, '2020030010', '顿茹云', '$2a$10$SYdHcBZxPh9.Pf1tYKmNUeUWg8joySQEVoWS0shKcNBvI2V/7HeUS', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:56:26', NULL, NULL, '03', '教职工');
INSERT INTO `tb_teacher` VALUES (88, '2020020001', '杜宇荫', '$2a$10$nKeb.3kGOEXj5CsL6emHQuS6eIT1EwMUeKCyPR05q.vpFNoC0FcMq', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:57:12', NULL, NULL, '02', '辅导员');
INSERT INTO `tb_teacher` VALUES (89, '2020020002', '红暄和', '$2a$10$WsLCFDRFksF9BXP9fcsH3ux45LOUj0kkfrQZCFjlEhZ58/WKIDpTa', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:57:12', NULL, NULL, '02', '教职工');
INSERT INTO `tb_teacher` VALUES (90, '2020020003', '旷天巧', '$2a$10$ffuC5XEwbvNpnxS3sYnOreCm1t8miDJYSPsfgYbaQLlgG6bEWef0.', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:57:12', NULL, NULL, '02', '教职工');
INSERT INTO `tb_teacher` VALUES (91, '2020020004', '艾千柳', '$2a$10$K.CQ1hYrCXNGhx36T/QS5eBhq/UK5fEePMpjC1TCpNPWLTYi1igge', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:57:12', NULL, NULL, '02', '教职工');
INSERT INTO `tb_teacher` VALUES (92, '2020020005', '展格格', '$2a$10$poivnGSBuTLnJ.pxtIFPJeJ5K5nK076QqF6HYZYoQaBGyo12OMvwW', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:57:13', NULL, NULL, '02', '教职工');
INSERT INTO `tb_teacher` VALUES (93, '2020020006', '荣腾骏', '$2a$10$xv71g44NfzMM2AUTo4jn5ePoamXtURrMYg3JhxdUmyt39x19ROCte', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:57:13', NULL, NULL, '02', '教职工');
INSERT INTO `tb_teacher` VALUES (94, '2020020007', '竹觅松', '$2a$10$pxG2Ya479VXCvyKkwFm68uxodacB03FQQXz3L7SMYn5GJKWapCKS2', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:57:13', NULL, NULL, '02', '教职工');
INSERT INTO `tb_teacher` VALUES (95, '2020020008', '叶代桃', '$2a$10$jQ8hb1x4VCEj3XSgTW9wpuVqoinxpSCGexS.vFCdAKlReQcO5BD9K', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:57:13', NULL, NULL, '02', '教职工');
INSERT INTO `tb_teacher` VALUES (96, '2020020009', '宦初柳', '$2a$10$GU6PRVMnoV87nVKHAjKzL.pLHjITqRV2TgSrUDbxou3BQuwmJY1zW', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:57:13', NULL, NULL, '02', '教职工');
INSERT INTO `tb_teacher` VALUES (97, '2020020010', '奇灵卉', '$2a$10$bv68RvvgkIm9kYRdJQmQhu0jlcJSEzRN98piPijPfjIO.Alxn8m0G', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:57:14', NULL, NULL, '02', '教职工');
INSERT INTO `tb_teacher` VALUES (98, '2020010001', '查天元', '$2a$10$bzqavI2H/SdWmeKgh.aZAuTKHGrrU44s/7SsTbTHuvObGuUCWb9Ue', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:57:56', NULL, NULL, '01', '辅导员');
INSERT INTO `tb_teacher` VALUES (99, '2020010002', '幸悦心', '$2a$10$RHmUopf7t1AILC2jj4cYgerVf5joW0wZanOuYNgND7lygJU9CZ2Mq', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:57:56', NULL, NULL, '01', '教职工');
INSERT INTO `tb_teacher` VALUES (100, '2020010003', '吕迎天', '$2a$10$FW6HwExF885stWnfs3dT6.jeAjrCw457X8fYiCJXOnlPPT4RphB2y', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:57:56', NULL, NULL, '01', '教职工');
INSERT INTO `tb_teacher` VALUES (101, '2020010004', '善元恺', '$2a$10$/iAPB3ETe0kv5/IKaYiG7u7wA6rdI6BUotIi7n9Y8bEbtuBvHlJUm', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:57:56', NULL, NULL, '01', '教职工');
INSERT INTO `tb_teacher` VALUES (102, '2020010005', '栋书蝶', '$2a$10$boBmxyNF7wTIkKbYUHJnle3VLmc0z7r5rzVRTETtgUT53Yp.aVgpq', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:57:57', NULL, NULL, '01', '教职工');
INSERT INTO `tb_teacher` VALUES (103, '2020010006', '剧访文', '$2a$10$0GAYYVsDKfHYjet0.NVsce7PIOSlJKo9v3OnSx4S5bszZIttuXuTy', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:57:57', NULL, NULL, '01', '教职工');
INSERT INTO `tb_teacher` VALUES (104, '2020010007', '韶千风', '$2a$10$zJXEF4Qtn/VqYiW0WqztGudm3ImwNIW4HqlC3d/f6sRHKVKHMPjQC', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:57:57', NULL, NULL, '01', '教职工');
INSERT INTO `tb_teacher` VALUES (105, '2020010008', '殷春华', '$2a$10$gHIXA4n4qhN81Pg9jAo9b.wq7FoQBoHgQ4eGLYg4SeoUwhs2tkfNG', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:57:57', NULL, NULL, '01', '教职工');
INSERT INTO `tb_teacher` VALUES (106, '2020010009', '席以寒', '$2a$10$pKpEAaWBQtliZAWMR61ylO7T6jQPJ/jpEsLPkDFIhBRaSjD/13LnC', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:57:57', NULL, NULL, '01', '教职工');
INSERT INTO `tb_teacher` VALUES (107, '2020010010', '宋天欣', '$2a$10$QClFKf9Vi8QuDwuN6gYqWerAcAapqkZN750TWiY4Iu8CsLJ02eUPK', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:57:58', NULL, NULL, '01', '教职工');
INSERT INTO `tb_teacher` VALUES (108, '2020070001', '闪曼寒', '$2a$10$gTy8mmL.RXDRnuflYIfsJeYJVaB9dOnA1RbrvA.enycOOHwoaXKz6', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:58:42', NULL, NULL, '07', '辅导员');
INSERT INTO `tb_teacher` VALUES (109, '2020070002', '宝惜玉', '$2a$10$g6fjLClrDW8MoYi7QS9fLuLMVzkhrzdrB8EKFh4jvQGxYpOQUF0qe', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:58:42', NULL, NULL, '07', '教职工');
INSERT INTO `tb_teacher` VALUES (110, '2020070003', '泣伶伶', '$2a$10$fDV5Qt0Y9wvSa/FKJAtTMOGVPxSSZcl5xJr7CTirPA9I9j/YoWNBq', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:58:43', NULL, NULL, '07', '教职工');
INSERT INTO `tb_teacher` VALUES (111, '2020070004', '姚秋巧', '$2a$10$fxIZ.JX9Ez2c7HbGB1o8C.5ibInovoZVpb7/QCul43lRpLYQ68aqu', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:58:43', NULL, NULL, '07', '教职工');
INSERT INTO `tb_teacher` VALUES (112, '2020070005', '茂蔚星', '$2a$10$NHVFWdCX0aqt4isClstlS.7iKNuHwr4alz.D9fCsWuaouTRBIMNq2', 'null', '', '', '男', '', '2021-11-04 16:58:43', '', NULL, '07', '教职工');
INSERT INTO `tb_teacher` VALUES (113, '2020070006', '卷童欣', '$2a$10$atsoUnbkc7IZQpGMC1Gc3upoWwPM8PJxzbiFZbA7iYGE.hYkcDldm', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:58:43', NULL, NULL, '07', '教职工');
INSERT INTO `tb_teacher` VALUES (114, '2020070007', '扶方雅', '$2a$10$J0xLRnf910qwWMbI2WACve9SxWYx/rs2Pd5vLHA/N0VoosLQVVNJe', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:58:43', NULL, NULL, '07', '教职工');
INSERT INTO `tb_teacher` VALUES (115, '2020070008', '辟元龙', '$2a$10$X31KB3e6qtUjSzmKg30dxOyNSQvaYf.t/anwpAoV1XzPI0y2tIDgu', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:58:44', NULL, NULL, '07', '教职工');
INSERT INTO `tb_teacher` VALUES (116, '2020070009', '薄娟丽', '$2a$10$i8zPXwBfDAl.5CkBG5am4e2giABEGgI8u5wx1Y8ayZqE1NMkedFvy', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:58:44', NULL, NULL, '07', '教职工');
INSERT INTO `tb_teacher` VALUES (117, '2020070010', '吾夏旋', '$2a$10$cuW6Nr.q8DN02rAgoo7e6eOLWc3/A0hII1yzyZqND.xn52XxQd6bq', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:58:44', NULL, NULL, '07', '教职工');
INSERT INTO `tb_teacher` VALUES (118, '2020080001', '仁琼音', '$2a$10$xRIBPJ4APLaDZYWacn6FmeV3qsLPcudpqNJBb4uqSGNZX6P.Qs8Wy', 'null', '', '', '男', '2020080101', '2021-11-04 16:59:24', '', NULL, '08', '辅导员');
INSERT INTO `tb_teacher` VALUES (119, '2020080002', '焉乐蕊', '$2a$10$CdMcs.Gm0yQgWfw5Ptq8ROwkFs//ly08MwfQn6dqYm/fj88sHCZ4e', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:59:24', NULL, NULL, '08', '教职工');
INSERT INTO `tb_teacher` VALUES (120, '2020080003', '汲德曜', '$2a$10$M5gpkLtCb.lQOiSXrYRuU.Z.aw4s1pEeEalhn1peRCYXdg/lybCVq', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:59:25', NULL, NULL, '08', '教职工');
INSERT INTO `tb_teacher` VALUES (121, '2020080004', '出清绮', '$2a$10$..duIjBKBzZ/rTfw2xlGluqhfRZVu1JWMjC7d/GJmQTLOitDwy3WW', 'null', '', '', '男', '', '2021-11-04 16:59:25', '', NULL, '08', '教职工');
INSERT INTO `tb_teacher` VALUES (122, '2020080005', '束孤萍', '$2a$10$KPkrS/KmbNrd6kDilheVMuZkAsIPb0jDE1EvuertvRIKpipPASi6.', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:59:25', NULL, NULL, '08', '教职工');
INSERT INTO `tb_teacher` VALUES (123, '2020080006', '昌惜芹', '$2a$10$OtpJ7rF3h7KyrIStEwOdR.WIIlHDCw4oXhh7vooyy5fiaJ5JjwcS6', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:59:25', NULL, NULL, '08', '教职工');
INSERT INTO `tb_teacher` VALUES (124, '2020080007', '奈念巧', '$2a$10$Dy5LGIGhHCW.KWGqDdJbDee/iQpKgDSs6dk4ZaBXTkRQpuu.LJ1uK', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:59:25', NULL, NULL, '08', '教职工');
INSERT INTO `tb_teacher` VALUES (125, '2020080008', '晁欣愉', '$2a$10$MGxZ5TMDVGPVT6RAx4ndGOFDhsIDEz/A7dJgf.8pVtRTgV5h8VH6q', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:59:26', NULL, NULL, '08', '教职工');
INSERT INTO `tb_teacher` VALUES (126, '2020080009', '夫忆曼', '$2a$10$Ebucoyw3d5jeRxx0LobDm.tfCMQ2n.qjMI/fMucL2lRtb1qQQ1U0O', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:59:26', NULL, NULL, '08', '教职工');
INSERT INTO `tb_teacher` VALUES (127, '2020080010', '蔡宏博', '$2a$10$AbM57NoKVIPqgr50q3K23eucp/rWrOM2g67JRAYWgspft.jGmyD5a', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:59:26', NULL, NULL, '08', '教职工');
INSERT INTO `tb_teacher` VALUES (128, '2020090001', '势怀芹', '$2a$10$2U2gSsEovT7X7VGOKASL3u4hJqrGCaO3waMXSczBnP5obeWhVw1EC', 'null', '', '', '男', '2020090101', '2021-11-04 16:59:57', '', NULL, '09', '辅导员');
INSERT INTO `tb_teacher` VALUES (129, '2020090002', '闻之云', '$2a$10$i8hqHDCwMaTg4h06tMxuneyOKFY3QP/a3m9.lqXziUA2rZUxUVIdS', 'null', '', '', '男', '2020090101', '2021-11-04 16:59:58', '', NULL, '09', '教职工');
INSERT INTO `tb_teacher` VALUES (130, '2020090003', '字听筠', '$2a$10$DBUb1083SvM/qZSS6x./2.13anqVbSFpZNDXTg5EEbc.9E.fOskAK', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:59:58', NULL, NULL, '09', '教职工');
INSERT INTO `tb_teacher` VALUES (131, '2020090004', '古淼淼', '$2a$10$8HLPSpAMSbeqmh9ULt.WneZ7nO0HOZe9gi1LnFjr0RbpcHllasRzC', 'null', 'null', 'null', '男', '2020090101', '2021-11-04 16:59:58', 'null', NULL, '09', '教职工');
INSERT INTO `tb_teacher` VALUES (132, '2020090005', '位康安', '$2a$10$UYjpyvJvkIui4Nk.qCUkgO1/8DOFhwPj/aFqFZVheFamM9j.AVM/2', NULL, NULL, NULL, '男', NULL, '2021-11-04 16:59:58', NULL, NULL, '09', '教职工');
INSERT INTO `tb_teacher` VALUES (133, '2020090006', '务湘云', '$2a$10$DPe3zXWO7CByNuzTGytDTePI/iBTvu8FWsTBvPrUcG0/iOzHUE9kS', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:59:58', NULL, NULL, '09', '教职工');
INSERT INTO `tb_teacher` VALUES (134, '2020090007', '雪涵涵', '$2a$10$tooEUNAQmPFN2cQX8q/bheoEHli/GNxPcd2vtpGIKVMF3jQX7TyPi', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:59:59', NULL, NULL, '09', '教职工');
INSERT INTO `tb_teacher` VALUES (135, '2020090008', '仇佑运', '$2a$10$elKioB48RERg25tWcdwSo.XqRPh1Uc8LFdEVjsDqeVJ4uyrGavz5S', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:59:59', NULL, NULL, '09', '教职工');
INSERT INTO `tb_teacher` VALUES (136, '2020090009', '告文景', '$2a$10$JV9CowDj.TYKvcBDYVAuze4cUeGCvo2CGAWZuLQVvYP9KE6VJ0PGK', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:59:59', NULL, NULL, '09', '教职工');
INSERT INTO `tb_teacher` VALUES (137, '2020090010', '庄才捷', '$2a$10$EAePQkhaNjj7RcHMg7roNOpj0DliLsokUF/rlQp.btIJnFhXArecO', NULL, NULL, NULL, '女', NULL, '2021-11-04 16:59:59', NULL, NULL, '09', '教职工');
INSERT INTO `tb_teacher` VALUES (138, '2020100001', '孔痴灵', '$2a$10$LFI5UowAI3oKLR0f3UMYg.VBwDvYArNfkwlc/CS55i4KryxKfmZ2.', NULL, NULL, NULL, '男', NULL, '2021-11-04 17:00:31', NULL, NULL, '10', '辅导员');
INSERT INTO `tb_teacher` VALUES (139, '2020100002', '汤溪蓝', '$2a$10$pv.5vSt8dsvvmaJE7v0RTOL9uVKdheRXNqLXCSIXEgog6.tdA8dpO', NULL, NULL, NULL, '男', NULL, '2021-11-04 17:00:31', NULL, NULL, '10', '教职工');
INSERT INTO `tb_teacher` VALUES (140, '2020100003', '傅曼安', '$2a$10$G.bacADqP.Yk1Ply/EZF8.Xz./nMsEF/jvaQX5/NtfNj6kcwRMZRi', NULL, NULL, NULL, '男', NULL, '2021-11-04 17:00:31', NULL, NULL, '10', '教职工');
INSERT INTO `tb_teacher` VALUES (141, '2020100004', '全晗玥', '$2a$10$w.sGSnkzQcWIHU/gxFaOweuLpZwa/CtuTy10ylDZBgumDcNhaaA2C', NULL, NULL, NULL, '男', NULL, '2021-11-04 17:00:31', NULL, NULL, '10', '教职工');
INSERT INTO `tb_teacher` VALUES (142, '2020100005', '伏蕴秀', '$2a$10$3GIzijFoz.xf5VGQUCP20.qGksrmDKF4W4BiQFpsT2mWU3/7xA.u2', NULL, NULL, NULL, '男', NULL, '2021-11-04 17:00:32', NULL, NULL, '10', '教职工');
INSERT INTO `tb_teacher` VALUES (143, '2020100006', '綦思真', '$2a$10$gn9xQF3FDug4LKaMkgIa/OKtCkE3MweYFHBUdyZdaQNFhn/AqNC16', NULL, NULL, NULL, '女', NULL, '2021-11-04 17:00:32', NULL, NULL, '10', '教职工');
INSERT INTO `tb_teacher` VALUES (144, '2020100007', '栋景铄', '$2a$10$v5AUbZNeT3VpOR4TocGD3Ox8YVO92EpGaeRU2H62.T39lCYqEjKhu', NULL, NULL, NULL, '女', NULL, '2021-11-04 17:00:32', NULL, NULL, '10', '教职工');
INSERT INTO `tb_teacher` VALUES (145, '2020100008', '浮梓暄', '$2a$10$4KWMpzEwgPcDZDoETjWTkeSNBFIE.dpxSb7DDuc8UsFRbgNLG63xm', NULL, NULL, NULL, '女', NULL, '2021-11-04 17:00:32', NULL, NULL, '10', '教职工');
INSERT INTO `tb_teacher` VALUES (146, '2020100009', '怀春冬', '$2a$10$niBptFbsv9BPZmORVlYWT.mWY4vp3pYi49xgFP53mKKcjlkWtwM4K', NULL, NULL, NULL, '女', NULL, '2021-11-04 17:00:32', NULL, NULL, '10', '教职工');
INSERT INTO `tb_teacher` VALUES (147, '2020100010', '姓海宁', '$2a$10$MVf3y1N8m1UFqrCedxzK6.GbDxVWcudn/OfavzmKO28RORuoUeLvS', NULL, NULL, NULL, '女', NULL, '2021-11-04 17:00:33', NULL, NULL, '10', '教职工');
INSERT INTO `tb_teacher` VALUES (148, '2020020011', '很相似', '$2a$10$FZy97d5YfSmH5ev7rsi23.5vT1DL17glQUd.28zi.a/0EOOE4p9rS', '', '', '', '男', '', '2022-01-08 12:10:00', '', NULL, '02', '教职工');
INSERT INTO `tb_teacher` VALUES (152, '2022100001', '浮梓暄', '$2a$10$1PdQM6Vul3kBbtya1aYX9OJIuzHSHrUUA6FFkPurY3RY4VTuR0sge', NULL, NULL, NULL, '男', NULL, '2022-01-08 12:29:25', NULL, NULL, '10', '辅导员');
INSERT INTO `tb_teacher` VALUES (153, '2022100002', '怀春冬', '$2a$10$SFEIuLkh0ztLWNfmrxC1suNzqo1Hy8trgFSJlj/TAmlBaQmMvD4mG', NULL, NULL, NULL, '男', NULL, '2022-01-08 12:29:26', NULL, NULL, '10', '教职工');
INSERT INTO `tb_teacher` VALUES (154, '2022100003', '姓海宁', '$2a$10$T0HM5a2FB1XWMHAhqktsA.Iu/kubqJdlRfIiLVo0/kikGC5gZ7Eea', NULL, NULL, NULL, '男', NULL, '2022-01-08 12:29:26', NULL, NULL, '10', '教职工');

SET FOREIGN_KEY_CHECKS = 1;
