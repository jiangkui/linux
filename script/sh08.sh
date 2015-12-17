#!/bin/bash
# shift 的用法
# 时间：2015-12-09 08:57:25

echo "参数数量 ==>$#"
echo "全部的参数 ==>$@"
shift #进行第一次 一个变量的 shift

echo "参数数量 ==>$#"
echo "全部的参数 ==>$@"
shift 3 #进行第二次 三个变量的 shift

echo "参数数量 ==>$#"
echo "全部的参数 ==>$@"
