/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50626
 Source Host           : localhost
 Source Database       : fasttabla

 Target Server Type    : MySQL
 Target Server Version : 50626
 File Encoding         : utf-8

 Date: 10/08/2015 10:00:10 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `tasks`
-- ----------------------------
DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `task` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
