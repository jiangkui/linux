建表语句：
CREATE DATABASE one DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

use one;

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cid` bigint(20) DEFAULT NULL COMMENT '用户id',
  `uid` varchar(100) DEFAULT NULL COMMENT '用户账号',
  `nickname` varchar(500) DEFAULT NULL COMMENT '昵称',
  `IPAddress` varchar(500) DEFAULT NULL COMMENT 'ip地址',
  `avatarName` varchar(100) DEFAULT NULL COMMENT '头像名称',
  `avatarPrefix` varchar(500) DEFAULT NULL COMMENT '头像前缀',
  `IP` varchar(100) DEFAULT NULL COMMENT 'IP',
  `mobile` varchar(100) DEFAULT NULL COMMENT '手机号',
  `freeCoin` varchar(100) DEFAULT NULL,
  `isFirstLogin` varchar(100) DEFAULT NULL,
  `coin` varchar(100) DEFAULT NULL,
  `bonusNum` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cid_UNIQUE` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

 CREATE TABLE `period_winner` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `period` bigint(20) DEFAULT NULL COMMENT '期号',
  `cid` bigint(20) DEFAULT NULL COMMENT '用户id',
  `goods_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `owner_cost` varchar(45) DEFAULT NULL COMMENT '本期参与次数',
  `lucky_code` varchar(45) DEFAULT NULL COMMENT '幸运号码',
  `duobao_time` datetime DEFAULT NULL COMMENT '夺宝时间',
  `calc_time` datetime DEFAULT NULL COMMENT '揭晓时间',
  `status` varchar(45) DEFAULT NULL COMMENT '状态',
  `cost` varchar(45) DEFAULT NULL COMMENT 'cost',
  PRIMARY KEY (`id`),
  UNIQUE KEY `period_UNIQUE` (`period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;