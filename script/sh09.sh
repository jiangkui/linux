#!/bin/bash
# 简单的小程序
# 时间：2015-12-09 09:12:36

if [ "$1" == "hello" ]; then
	echo "Hello, how are you?"
elif [ "$1" == "" ]; then
	echo "你必须输入一个值 ex> {$0 someword}"
else 
	echo "The only parameter is 'hello', ex> {$0 hello}"
fi
