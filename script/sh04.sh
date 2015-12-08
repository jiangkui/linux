#!bin/bash
#说明：简单的加减乘除
#时间：2015-12-08

echo -e "输入两个数字 \n"
read -p "第一个：" firstnu
read -p "第二个：" secnu
total=$(($firstnu * $secnu))

echo -e "\n两数($firstnu,$secnu)相乘的结果是 ==> $total"
