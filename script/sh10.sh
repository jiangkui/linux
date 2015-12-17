#!/bin/bash
# 检测常用的网络端口
# 时间：2015-12-09 09:18:48

echo "现在我将要监听一些常见的服务"
echo "包括 www, ftp, ssh, mail \n"

testing=$(netstat -tuln | grep ":80" ) # 检测 80端口是否存在
if [ "$testing" != "" ]; then
	echo "WWW 服务已经运行"
fi

testing=$(netstat -tuln | grep ":22" ) # 检测 22端口是否存在
if [ "$testing" != "" ]; then
	echo "SSH 服务已经运行"
fi

testing=$(netstat -tuln | grep ":21" ) # 检测 21端口是否存在
if [ "$testing" != "" ]; then
	echo "FTP 服务已经运行"
fi

testing=$(netstat -tuln | grep ":25" ) # 检测 25端口是否存在
if [ "$testing" != "" ]; then
	echo "Mail 服务已经运行"
fi
