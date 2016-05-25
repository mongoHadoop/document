/*
Navicat MySQL Data Transfer

Source Server         : doc
Source Server Version : 50709
Source Host           : localhost:3306
Source Database       : doc

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2016-05-18 11:05:48
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `t_sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_role`;
CREATE TABLE `t_sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(20) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sys_role
-- ----------------------------
INSERT INTO `t_sys_role` VALUES ('2', '总公司会计', '23');
INSERT INTO `t_sys_role` VALUES ('3', '站点会计', '23');
INSERT INTO `t_sys_role` VALUES ('4', '普通人员', null);
INSERT INTO `t_sys_role` VALUES ('5', '超级管理员', '12');
