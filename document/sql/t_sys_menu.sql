/*
Navicat MySQL Data Transfer

Source Server         : doc
Source Server Version : 50709
Source Host           : localhost:3306
Source Database       : doc

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2016-05-23 10:46:24
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `t_sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_menu`;
CREATE TABLE `t_sys_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(50) DEFAULT NULL,
  `url` varchar(50) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sys_menu
-- ----------------------------
INSERT INTO `t_sys_menu` VALUES ('2', '凭证录入', 'manager/doInitDocInfo.action', '凭证录入');
INSERT INTO `t_sys_menu` VALUES ('3', '凭证上传', 'manager/doComfirmDocList.action', '附件上传');
INSERT INTO `t_sys_menu` VALUES ('4', '凭证查看', 'manager/doDocListView.action', '凭证查看');
INSERT INTO `t_sys_menu` VALUES ('5', '科目设置', 'doc_subject.jsp', '科目类型管理');
INSERT INTO `t_sys_menu` VALUES ('6', '系统人员', 'sys_user.jsp', '系统人员');
INSERT INTO `t_sys_menu` VALUES ('9', '组织机构', 'sys_org.jsp', '组织机构管理');
INSERT INTO `t_sys_menu` VALUES ('10', '系统菜单', 'sys_menu.jsp', '菜单管理');
INSERT INTO `t_sys_menu` VALUES ('11', '系统角色', 'sys_role.jsp', null);
INSERT INTO `t_sys_menu` VALUES ('12', '凭证复核', 'manager/doAuditDocInfo.action', '总会计审核');
INSERT INTO `t_sys_menu` VALUES ('13', '表报查询', 'chart/report_month.html', null);
INSERT INTO `t_sys_menu` VALUES ('14', '填单人员', 'manager7/doDocUserlist.action', null);
