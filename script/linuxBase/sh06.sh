#!/bin/bash
#说明：学习使用中括号来判断
#时间：2015-12-08

read -p "输入 (y/n)" yn
[ "$yn" == "Y" -o "$yn" == "y" ] && echo "OK,continue" && exit 0

