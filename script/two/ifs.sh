#!/bin/bash

data="name,sex,rollno,location"


#$IFS 是存储定界符的环境变量。他是当前shell环境使用的默认定界字符串。
#IFS 默认值为 空白字符（换行、制表、或空格）

oldIFS=$IFS
IFS=,
for item in $data;
do
    echo Item: $item
done

IFS=$oldIFS