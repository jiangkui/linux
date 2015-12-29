#!/bin/bash

a=2;
b=6;

#注意 let 在 bash 中能执行，在 sh 中没有
#所以该脚本应该这么执行：bash shuxue.sh
let c=a+b
echo $c

let c++
echo $c

c=$[a * b]
echo $c

c=$((a * b + a))
echo $c

c=`expr 3 + 4`
echo $c

#这种方式不行
c=`expr 3+4`
echo $c

#以上方法只能用与整数计算，不能用于浮点数
############################################

echo "4 * 0.56" | bc

no=53
result=`echo "$no * 1.5" | bc`
echo $result

#设定小数精度
echo "scale=2; 3/8" | bc

#进制转换
no=100
echo "obase=2; $no" | bc

#计算平方根
echo "sqrt(100)" | bc
echo "10^10" | bc