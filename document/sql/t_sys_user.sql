/*
Navicat MySQL Data Transfer

Source Server         : doc
Source Server Version : 50709
Source Host           : localhost:3306
Source Database       : doc

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2016-05-18 11:06:07
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `t_sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user`;
CREATE TABLE `t_sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_code` varchar(20) DEFAULT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `user_pwd` varchar(30) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sys_user
-- ----------------------------
INSERT INTO `t_sys_user` VALUES ('1', 'test@test.com', '张三', '123', '3', '7', ' ');
INSERT INTO `t_sys_user` VALUES ('2', 'ganli@gm.com', '李四', 'ddd', null, null, ' ');
INSERT INTO `t_sys_user` VALUES ('3', 'test2@test.com', '王五4', '123', '3', '8', ' ');
INSERT INTO `t_sys_user` VALUES ('4', 'ganli@ccc.com', '阿大', '12', null, null, ' ');
INSERT INTO `t_sys_user` VALUES ('5', '12@ga.com', '阿二', '111', '1', '8', ' ');
INSERT INTO `t_sys_user` VALUES ('16', 'ganli@ddd.com', '订单', 'asdfasdfa', null, null, null);
INSERT INTO `t_sys_user` VALUES ('17', 'dd@gm.com', '订单', '11', null, null, null);
INSERT INTO `t_sys_user` VALUES ('18', 'ganli@gmail.com', '甘力', '123', '5', '10', null);
INSERT INTO `t_sys_user` VALUES ('19', null, '阿萨德', null, null, null, '  ');
