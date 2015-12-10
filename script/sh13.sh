#!bin/bash
# function
# 时间：2015-12-10 09:22:13

while [ "$yn" != "yes" -a "$yn" != "YES" ]
do	
	read -p "输入 yes/YES 才能停止!" yn
done
echo "ok，已经停了!"
