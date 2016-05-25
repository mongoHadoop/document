/*
Navicat MySQL Data Transfer

Source Server         : doc
Source Server Version : 50709
Source Host           : localhost:3306
Source Database       : doc

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2016-04-17 14:05:40
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `t_doc_subject`
-- ----------------------------
DROP TABLE IF EXISTS `t_doc_subject`;
CREATE TABLE `t_doc_subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(50) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_doc_subject
-- ----------------------------
