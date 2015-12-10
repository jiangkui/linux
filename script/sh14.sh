#!bin/bash
# function
# 时间：2015-12-10 09:13:20

s=0
i=0
while [ "$i" != "100" ]
do
	i=$(($i+1))
	s=$(($s+$i))
done

echo "1累加到 100 的和是：$s"
