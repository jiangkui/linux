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
projectWar="ROOT.war"

localProjectPach="/home/jiangkui/IdeaProjects/one_yuan"

userName="root"
#serverIp="192.168.1.33"
serverIp="alicloud"

#关不掉tomcat时，默认等待n秒，之后kill
defaultWaitTime=5

#-----------------变量--------------------
serverUser=${userName}@${serverIp}

localWarFile=${localProjectPach}"/test/"${projectWar}

serverTomcatHome=/root/program/apache-tomcat-7.0.67
#serverTomcatHome=/data/work/tomcat
serverTomcatWebapps=${serverTomcatHome}/webapps
serverROOTFileName=${serverTomcatWebapps}"/ROOT"

serverTomcatBin=${serverTomcatHome}/bin
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

function packWar(){
    printLog "打 war 包"
    cd ${localProjectPach}
    mvn clean
    mvn package -Dmaven.test.skip=true -Ptest
}

function stopTomcat(){
    printLog "停止 tomcat"

    count=`processCount`
    if [ ${count} -gt 0 ]; then
        remoteExecute ${serverTomcatBin}/shutdown.sh

        echo ""
        echo "正在停止 tomcat 。。。 "
        sleep 1

        waitSecond=1
        while [[ ${count} -gt 0 ]]; do
            echo "已等待"${waitSecond}"秒"

            if [[ ${waitSecond} -ge ${defaultWaitTime} ]]; then
                killProcess
                waitSecond=0
            fi

            ((waitSecond = waitSecond + 1))
            sleep 1
            count=`processCount`
        done

        echo "tomcat 已经停止"
    fi
}

function uploadWar(){
#    printLog "上传war包 ${localWarFile} 到 ${serverUser}:${serverTomcatWebapps}"

#    scp ${localWarFile} ${serverUser}":"${serverTomcatWebapps}

    localWarSha1=$(md5sum /home/ljk/progect/broadcom-wl-5.100.138.tar.bz2 | awk '{print $1}')
    serverWarSha1=$(ssh root@alicloud "md5sum /root/program/apache-tomcat-7.0.67.tar.gz" | awk '{print $1}')

    #TODO 比较本地 war 与 servert war 是否相等

    echo $localWarSha1" "$serverWarSha1
}

#-----------------main--------------------
uploadWar


#packWar
#
#stopTomcat
#
##删除 server 上的 ROOT包
#printLog "删除原 ${serverROOTFileName} 文件"
#remoteExecute "rm -rf ${serverROOTFileName}"
#
#printLog "重启 tomcat"
#remoteExecute "/data/work/tomcat/bin/restart.sh"
#remoteExecute "cd ${serverTomcatHome}/logs ; tail -f catalina.out"

