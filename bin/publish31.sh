#!/bin/bash
#
#-----------------版权--------------------
# 名称: 自动发布到31
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
localProject="/home/jiangkui/IdeaProjects/money"
localFile=${localProject}"/target/ROOT.war"

userName="root"
serverIp="192.168.1.31"
serverUser=${userName}@${serverIp}

serverTomcatHome=/data/work/tomcat/
serverFilePath=${serverTomcatHome}webapps
serverFile=${serverFilePath}"/ROOT"
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
cd ${localProject}
mvn clean
mvn package -Dmaven.test.skip=true

#2. 停止 tomcat
printLog "2. 停止 tomcat"
ssh ${serverUser} "/data/work/tomcat/bin/stop.sh"

#3. 拷贝 war
printLog "3. 上传 war 包"
echo "执行 scp ${localFile} ${serverUser}":"${serverFilePath}"
scp ${localFile} ${serverUser}":"${serverFilePath}

ssh ${serverUser} "rm -rf ${serverFile}"
echo "删除原 ${serverFile} 文件"

#4. 重启 tomcat
printLog "4. 重启 tomcat"
ssh ${serverUser} "/data/work/tomcat/bin/restart.sh"
ssh ${serverUser} "cd ${serverTomcatHome}/logs ; tail -f catalina.out"

