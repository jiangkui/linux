#!/bin/bash

arrays=(1 2 3 4 5 6)

echo ${arrays[0]}

echo ${arrays[*]}
echo ${arrays[@]}
echo ${#arrays[@]}

#列出数组索引
echo ${!arrays[*]}


#声明关联数组
declare -A ass_array

ass_array=([name]="zhangsan" [age]="25")

echo ${ass_array[name]}

#列出数组索引
echo ${!ass_array[*]}

