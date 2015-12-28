#!/bin/bash
#
#-----------------版权--------------------
# 名称：抓取一元夺宝数据
# 版本：1.0
# 语言：bash shell
# 日期：2015年12月28日11:38:10
# 作者：ljk
# 邮件：1013939150@qq.com
#-----------------环境--------------------
# Linux 3.13.0
# GNU Bash 4.3.11

#-----------------常量--------------------
prefixUrl="http://1.163.com/goods/getPeriod.do?gid=898&navigation=-1"
varPeriod="&period="
timestamp="&t="$(date +%s)
varToken="&token="

#-----------------变量--------------------
period=""
token="eba2fa19-8f82-4fca-b4fe-f1476f75988e"

#-----------------数组--------------------

#-----------------方法--------------------
function queryUrl(){
    if [[ $1 == "" ]]; then
        echo "期号不能为空！"
        exit 0;
    fi

    echo ${prefixUrl}${varPeriod}$1${timestamp}${varToken}${token}
}

#-----------------main--------------------

period=$1
if [[ $period == "" ]]; then
    period=212273829
fi

num=0
while [[ ${num} -lt 2 ]]; do
    echo "第 ${num} 次请求！"
    url=$(queryUrl ${period})
    result=$(curl -s ${url})

    #使用 jq 进行各种过滤
    period=$(echo $result | jq ".result.periodWinner.period")

    #TODO 数据入库！

    echo $period
    ((num=num+1))
done


#curl -s 'http://1.163.com/goods/getPeriod.do?gid=898&period=212273829&navigation=-1&t=1451265961395&token=eba2fa19-8f82-4fca-b4fe-f1476f75988e' |jq "."
#curl -s 'http://1.163.com/goods/getPeriod.do?gid=898&period=212273829&navigation=-1&t=1451265961395&token=eba2fa19-8f82-4fca-b4fe-f1476f75988e' |jq ". | {period: .result.periodWinner.period, cid:.result.periodWinner.owner.cid, uid:.result.periodWinner.owner.uid}"







#:<<!
#建表语句：
#CREATE DATABASE one DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
#
#use one;
#
#CREATE TABLE `user` (
#  `id` bigint(20) NOT NULL AUTO_INCREMENT,
#  `uid` bigint(20) DEFAULT NULL,
#  `avatarName` varchar(45) DEFAULT NULL,
#  `freeCoin` varchar(45) DEFAULT NULL,
#  `IPAddress` varchar(500) DEFAULT NULL,
#  `isFirstLogin` varchar(45) DEFAULT NULL,
#  `nickname` varchar(45) DEFAULT NULL,
#  `coin` varchar(45) DEFAULT NULL,
#  `IP` varchar(45) DEFAULT NULL,
#  `avatarPrefix` varchar(45) DEFAULT NULL,
#  `cid` varchar(45) DEFAULT NULL,
#  `bonusNum` varchar(45) DEFAULT NULL,
#  `mobile` varchar(45) DEFAULT NULL,
#  PRIMARY KEY (`id`),
#  KEY `uni_uid` (`uid`)
#) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
#
#CREATE TABLE `period_winner` (
#  `id` bigint(20) NOT NULL AUTO_INCREMENT,
#  `lucky_code` varchar(45) DEFAULT NULL,
#  `owner_cost` varchar(45) DEFAULT NULL,
#  `status` varchar(45) DEFAULT NULL,
#  `duobao_time` varchar(45) DEFAULT NULL,
#  `owner_uid` bigint(20) DEFAULT NULL,
#  `goods_id` bigint(20) DEFAULT NULL,
#  `calc_time` varchar(45) DEFAULT NULL,
#  `period` bigint(20) DEFAULT NULL,
#  `cost` varchar(45) DEFAULT NULL,
#  PRIMARY KEY (`id`),
#  KEY `uni_period` (`period`)
#) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
#!
