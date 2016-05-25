/*
Navicat MySQL Data Transfer

Source Server         : doc
Source Server Version : 50709
Source Host           : localhost:3306
Source Database       : doc

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2016-04-17 14:05:35
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `t_doc_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_doc_info`;
CREATE TABLE `t_doc_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doc_name` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `lend_type` varchar(10) DEFAULT NULL,
  `money` varchar(50) DEFAULT NULL,
  `record_user` varchar(50) DEFAULT NULL,
  `record_time` timestamp NULL DEFAULT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_doc_info
-- ----------------------------
