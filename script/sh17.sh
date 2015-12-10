#!bin/bash
# function
# 时间：2015年12月10日13:03:58

network="192.168.1"
for sitenu in $(seq 1 100)
do
	ping -c 1 -w 1 ${network}.${sitenu} &> /dev/null && result=0 || result=1
	if [ "$result" == 0 ]; then
		echo "服务器 ${network}.${sitenu} 是启动的"
	else
		echo "服务器 ${network}.${sitenu} 没启动"
	fi
done
