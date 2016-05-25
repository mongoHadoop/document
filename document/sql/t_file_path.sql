/*
Navicat MySQL Data Transfer

Source Server         : doc
Source Server Version : 50709
Source Host           : localhost:3306
Source Database       : doc

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2016-04-17 14:06:05
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `t_file_path`
-- ----------------------------
DROP TABLE IF EXISTS `t_file_path`;
CREATE TABLE `t_file_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doc_id` varchar(50) DEFAULT NULL,
  `file_path` varchar(100) DEFAULT NULL,
  `file_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_file_path
-- ----------------------------
INSERT INTO `t_file_path` VALUES ('22', '12', '201604/201604_id_89c09249b790469581ed890064c154c2.png', '1');
INSERT INTO `t_file_path` VALUES ('23', '12', '201604/201604_id_de0a587390ab4d38a6e28d88c04f3d94.png', '1');
