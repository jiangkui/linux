#!/bin/bash
#
#-----------------版权--------------------
# 名称：登陆内网
# 版本：1.0
# 语言：bash shell
# 日期：2015年12月17日20:28:10
# 作者：ljk
# 邮件：1013939150@qq.com
#-----------------环境--------------------
# Linux 3.13.0
# GNU Bash 4.3.11

#-----------------常量--------------------

#-----------------变量--------------------

#-----------------数组--------------------

#-----------------方法--------------------

#-----------------main--------------------


abc="one_dial_prize_list_124"

id=$(echo "${abc##*\_}")

((bb=id%3))

echo $id" "$bb
