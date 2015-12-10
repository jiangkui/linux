#!bin/bash
# function
# 时间：2015-12-10 22:42:47

read -p "输入累加终点: " nu

s=0
for ((i=1; i<=$nu; i++))
do
	s=$(($s+$i))
done
echo "从 1...+$nu 的和为：$s"	
