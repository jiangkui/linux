#!bin/bash
# 计算退伍日期的小程序
# 时间：2015-12-09 23:42:12

read -p "请输入退伍日期 (YYYYMMDD)：" date2

date_d=$(echo $date2 | grep '[0-9]\{8\}') #正则匹配下输入是否正确
if [ "$date_d" == "" ]; then
	echo "输入有误"
	exit 1
fi

# 计算日期
declare -i date_dem=`date --date="$date2" +%s`
declare -i date_now=`date +%s`
declare -i date_total_s=$(($date_dem-$date_now))
declare -i date_d=$(($date_total_s/60/60/24)) 

if [ "$date_total_s" -lt "0" ]; then
	echo  $((-1*$date_d))
else 
	declare -i date_h=$(($(($date_total_s-$date_d*60*60*24))/60/60))
	echo "你将在 $date_d 天 $date_h 小时后退役"
fi
