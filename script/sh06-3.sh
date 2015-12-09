#!bin/bash
#说明：学习使用中括号来判断
#时间：2015-12-09 09:06:21

read -p "输入 (y/n)" yn
if [ "$yn" == "y" ] || [ "$yn" == "Y" ]; then
	echo "Ok"
	exit 0
elif [ "$yn" == "n" ] || [ "$yn" == "N" ]; then
	echo "Oh,N"
	exit 0
else echo "我不知道你输入了什么" && exit 0
fi
