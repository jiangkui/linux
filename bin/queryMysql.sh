#!/bin/bash
#
#-----------------版权--------------------
# 名称: 查询 mysql demo
# 版本：1.0
# 语言：bash shell
# 日期：2015年12月23日07:19:05
# 作者：ljk
# 邮件：1013939150@qq.com
#-----------------环境--------------------
# Linux 3.13.0
# GNU Bash 4.3.11

#-----------------常量--------------------
USER=root
PASSWORD=ljk
DB=travel

#-----------------变量--------------------
COMMAND="select id,city_name,city_spell from city_spell limit 10" #要执行的 sql 语句

#-----------------数组--------------------

#-----------------方法--------------------

#-----------------main--------------------

result=$(mysql -u${USER} -p${PASSWORD} -D ${DB} -e "${COMMAND}");

echo "${result}" > ~/desktop/aa.txt

#注意：带引号与不带引号的区别
#可参见：http://bbs.chinaunix.net/forum.php?mod=viewthread&tid=218853&page=4#pid1511745
#echo ${result}


