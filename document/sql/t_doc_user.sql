/*
Navicat MySQL Data Transfer

Source Server         : doc
Source Server Version : 50709
Source Host           : localhost:3306
Source Database       : doc

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2016-04-17 14:05:47
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `t_doc_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_doc_user`;
CREATE TABLE `t_doc_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_doc_user
-- ----------------------------
INSERT INTO `t_doc_user` VALUES ('151', '李四', null);
INSERT INTO `t_doc_user` VALUES ('152', '王五', null);
INSERT INTO `t_doc_user` VALUES ('153', '田六', null);
INSERT INTO `t_doc_user` VALUES ('154', '王麻子', null);
INSERT INTO `t_doc_user` VALUES ('155', '蒋二娃', null);
INSERT INTO `t_doc_user` VALUES ('156', '廖大娃', null);
INSERT INTO `t_doc_user` VALUES ('157', '张三', null);
INSERT INTO `t_doc_user` VALUES ('158', '李四', null);
INSERT INTO `t_doc_user` VALUES ('159', '王五', null);
INSERT INTO `t_doc_user` VALUES ('160', '田六', null);
INSERT INTO `t_doc_user` VALUES ('161', '王麻子', null);
INSERT INTO `t_doc_user` VALUES ('162', '蒋二娃', null);
INSERT INTO `t_doc_user` VALUES ('163', '廖大娃', null);
INSERT INTO `t_doc_user` VALUES ('164', '五四', '五四五四');
INSERT INTO `t_doc_user` VALUES ('165', '天气', '天天');
INSERT INTO `t_doc_user` VALUES ('166', 'eeee', null);
INSERT INTO `t_doc_user` VALUES ('167', 'safasf', null);
INSERT INTO `t_doc_user` VALUES ('168', 'erewr', null);
