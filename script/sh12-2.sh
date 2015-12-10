#!bin/bash
# function
# 时间：2015-12-10 09:13:20


function printit(){
	echo -n "你选择了 "
}

echo "请输入选项"
case $1 in
	"one")
		printit; echo $1 
		;;
	"two")
		printit; echo $1 | tr 'a-z' 'A-Z'
		;;
	"three")
		printit; echo $1 | tr 'a-z' 'A-Z'
		;;
	*)
		printit; echo $1 | tr 'a-z' 'A-Z'
		;;
esac
