/*
Navicat MySQL Data Transfer

Source Server         : doc
Source Server Version : 50709
Source Host           : localhost:3306
Source Database       : doc

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2016-05-18 11:05:56
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `t_sys_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_role_menu`;
CREATE TABLE `t_sys_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sys_role_menu
-- ----------------------------
INSERT INTO `t_sys_role_menu` VALUES ('2', '2');
INSERT INTO `t_sys_role_menu` VALUES ('2', '3');
INSERT INTO `t_sys_role_menu` VALUES ('2', '4');
INSERT INTO `t_sys_role_menu` VALUES ('2', '5');
INSERT INTO `t_sys_role_menu` VALUES ('2', '6');
INSERT INTO `t_sys_role_menu` VALUES ('3', '2');
INSERT INTO `t_sys_role_menu` VALUES ('3', '3');
INSERT INTO `t_sys_role_menu` VALUES ('3', '4');
INSERT INTO `t_sys_role_menu` VALUES ('3', '6');
INSERT INTO `t_sys_role_menu` VALUES ('5', '4');
INSERT INTO `t_sys_role_menu` VALUES ('5', '6');
INSERT INTO `t_sys_role_menu` VALUES ('5', '9');
