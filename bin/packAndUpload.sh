#!/bin/bash
#
#-----------------版权--------------------
# 名称：打包上传
# 版本：1.0
# 语言：bash shell
# 日期：2015年12月25日17:54:06
# 作者：ljk
# 邮件：1013939150@qq.com
#-----------------环境--------------------
# Linux 3.13.0
# GNU Bash 4.3.11

#-----------------参数--------------------
projectName=$1 #项目名称： money | one
environment=$2 #环境： test(测试) | production(生产)
executePack=$3 #是否执行打包命令： y 是 | other

environment=${environment:-"test"} #默认 test 环境
executePack=${executePack:-"y"} #默认 先打包，在上传

#-----------------数组--------------------
declare -A serverMap #server 地址
serverMap["money_test"]="root:192.168.1.31"
serverMap["money_production"]="work@lvs"
serverMap["one_test"]="root:192.168.1.33"
serverMap["one_production"]="work@lvs"

declare -A localProjectPathMap #本地路径
localProjectPathMap["money_test"]="/home/jiangkui/IdeaProjects/money"
localProjectPathMap["money_production"]=${localProjectPathMap["money_test"]}
localProjectPathMap["one_test"]="/home/jiangkui/IdeaProjects/one_yuan"
localProjectPathMap["one_production"]=${localProjectPathMap["one_test"]}

declare -A localFileNameMap #本地 War 包路径
localFileNameMap["money_test"]=${localProjectPathMap["money_test"]}"/target/ROOT.war"
localFileNameMap["money_production"]=${localFileNameMap["money_test"]}
localFileNameMap["one_test"]=${localProjectPathMap["one_test"]}"/test/ROOT.war"
localFileNameMap["one_production"]="/home/jiangkui/IdeaProjects/one_yuan_production/ROOT.war"

declare -A serverFileNameMap #server War 包路径

#-----------------方法-------------------
function obtainKey(){
    echo ${projectName}"_"${environment}
}

function initServerFileNameMap(){
    serverFileNameMap["money_test"]="/data/work/tomcat/webapps"
    serverFileNameMap["one_test"]="/data/work/tomcat/webapps"

    #TODO 连上lvs 之后 在执行命令。 写一个命令块。
    echo "${serverMap[`obtainKey`]}"
    echo $(ssh ${serverMap[`obtainKey`]} "gomoney")
}

#-----------------main-------------------

if [[ ${projectName} != "money" && ${projectName} != "one" ]]; then
    echo "项目名称有误！"
    exit 0;
fi

initServerFileNameMap

#if [[ ${executePack} == "y" ]]; then
#    source pack.sh ${localProjectPathMap[$projectName]} ${environment}
#fi

