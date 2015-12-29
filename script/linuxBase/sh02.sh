#!/bin/bash
# Program:
#       一个简单的交互程序
# Date：
#       2015-12-07 22:57:59
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

read -p "请输入你的名字：" name
read -p "请输入你的年龄：" age
echo "\n你的名字：$name 年龄 $age"