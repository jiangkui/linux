#!bin/bash
# function
# 时间：2015年12月10日13:03:58

read -p "请输入一个号码 计算累加值：" nu

s=0
for ((i=1; i<=$nu; i++))
do
	s=$(($s+$i))
done
echo " 1+...$s 的和是： $s"
