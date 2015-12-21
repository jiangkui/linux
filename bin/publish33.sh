#!/bin/bash
#
#-----------------版权--------------------
# 名称: 登陆内网
# 版本：1.0
# 语言：bash shell
# 日期：2015年12月21日17:29:45
# 作者：ljk
# 邮件：1013939150@qq.com
#-----------------环境--------------------
# Linux 3.13.0
# GNU Bash 4.3.11

#-----------------常量--------------------

#-----------------变量--------------------
project="/home/jiangkui/IdeaProjects/money"
server="192.168.1.33"
user="root"
testServer=${user}@${server}
localFile=${project}"/target/ROOT.war"
testServerFilePath=${testServer}":/data/work/tomcat/webapps"

#-----------------数组--------------------

#-----------------方法--------------------
function printLog(){
    echo "================================================"
    echo $1
    echo "================================================"
}

#-----------------main--------------------
#1. 打包
printLog "1. 打 war 包"
#cd ${project}
#mvn clear
#mvn package

#2. 停止 tomcat
printLog "2. 停止 tomcat"
#ssh ${testServer} "jerrymouse"

#3. 拷贝 war
printLog "3. 上传 war 包"
scp ${localFile} ${testServerFilePath}
echo "已经拷贝到:"${testServerFilePath}

#4. 重启 tomcat
printLog "4. 重启 tomcat"
ssh root@$server "/data/work/tomcat/bin/restart.sh"
ssh root@$server "/root/bin/vtlog"


