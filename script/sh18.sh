#!/bin/bash
# function
# 时间：2015年12月10日13:03:58

read -p "请输入一个目录：" dir

if [ "$dir" == "" -o ! -d "$dir" ]; then
	echo "这个目录是空的"
	exit 1
fi

filelist=$(ls $dir)
for filename in $filelist
do
	perm=""
	test -r "$dir/$filename" && perm="$perm 可读"
	test -w "$dir/$filename" && perm="$perm 可写"
	test -x "$dir/$filename" && perm="$perm 可执行"
	echo "这个文件 $dir/$filename 有这些权限 $perm"
done
