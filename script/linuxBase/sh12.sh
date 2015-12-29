#!/bin/basth
# case esac 测试
# 时间：2015-12-10 08:58:49

case $1 in 
	"hello")
		echo "Hello, how are you"
		;;
	"")
		echo "请输入一个值"
		;;
	*) #相当于通配符
		echo "$0 {hello}"
		;;
esac
