#!/bin/bash
#
#-----------------版权--------------------
# 名称: 自动发布到33
# 版本：1.0
# 语言：bash shell
# 日期：2015年12月21日17:29:45
# 作者：ljk
# 邮件：1013939150@qq.com
#-----------------环境--------------------
# Linux 3.13.0
# GNU Bash 4.3.11

#-----------------常量--------------------
localProject="/home/jiangkui/IdeaProjects/one_yuan"
localFile=${localProject}"/test/ROOT.war"

userName="root"
serverIp="192.168.1.33"

#关不掉tomcat时，默认等待5秒，之后kill
defaultWaitTime=5

#-----------------变量--------------------
serverUser=${userName}@${serverIp}

serverTomcatHome=/data/work/tomcat
serverFilePath=${serverTomcatHome}/webapps
serverFile=${serverFilePath}"/ROOT"

bin=${serverTomcatHome}/bin
#-----------------数组--------------------


#-----------------方法--------------------

#打印日志
function printLog(){
    echo "================================================"
    echo $1
    echo "================================================"
}

function remoteExecute(){
    ssh ${serverUser} $1
}

#统计 java 进程数量
function processCount(){
    remoteExecute "ps -ef | grep -e 'bootstrap\.jar' -c"
}

#杀掉 Java 进程
function killProcess(){
    #此处不能使用 remoteExecute 方法
    tomcatId=$(ssh ${serverUser} ps -ef | awk '/bootstrap\.jar/ {print $2}')

    echo "准备 kill tomcat 进程     "

    if test -z ${tomcatId}; then
        echo "进程id为空，跳过       "
        return
    fi
    echo "干掉 $tomcatId 进程    "
    remoteExecute "kill -9 ${tomcatId}"
}

function stopTomcat(){
    count=`processCount`
    if [ ${count} -gt 0 ]; then
        remoteExecute ${bin}/shutdown.sh

        sleepSecond=0
        while [[ ${count} -gt 0 ]]; do
            echo "正在停止tomcat，已等待"${sleepSecond}

            if [[ ${sleepSecond} -gt ${defaultWaitTime} ]]; then
                killProcess
                sleepSecond=0
            fi

            sleepSecond = ${sleepSecond} + 1
            sleep 1
            ${count} = `processCount`
        done
    fi
}
#-----------------main--------------------

#打包
printLog "打 war 包"
cd ${localProject}
mvn clean
mvn package -Dmaven.test.skip=true -Ptest

#停止 tomcat
printLog "停止 tomcat"
stopTomcat

#上传 war
printLog "上传war包 ${localFile} 到 ${serverUser}:${serverFilePath}"
scp ${localFile} ${serverUser}":"${serverFilePath}

#删除 server 上的 ROOT包
printLog "删除原 ${serverFile} 文件"
remoteExecute "rm -rf ${serverFile}"

#重启 tomcat
printLog "4. 重启 tomcat"
remoteExecute "/data/work/tomcat/bin/restart.sh"
remoteExecute "cd ${serverTomcatHome}/logs ; tail -f catalina.out"

