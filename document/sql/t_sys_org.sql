/*
Navicat MySQL Data Transfer

Source Server         : doc
Source Server Version : 50709
Source Host           : localhost:3306
Source Database       : doc

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2016-04-21 20:59:05
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `t_sys_org`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_org`;
CREATE TABLE `t_sys_org` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `org_name` varchar(50) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sys_org
-- ----------------------------
INSERT INTO `t_sys_org` VALUES ('7', '南充XX站点', null);
INSERT INTO `t_sys_org` VALUES ('8', '达州XX站点5', null);
INSERT INTO `t_sys_org` VALUES ('9', '徐州XX站点', null);
INSERT INTO `t_sys_org` VALUES ('10', '成都XX站点34', null);
INSERT INTO `t_sys_org` VALUES ('11', '双流XX站点', null);
INSERT INTO `t_sys_org` VALUES ('12', '宜宾XX站点', null);
