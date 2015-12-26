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

declare -A serverPublishWarPathBin #公网服务器存放war包的bin
serverPublishWarPathBin["money_production"]=". ~/bin/go-money; pwd"
serverPublishWarPathBin["one_production"]=". ~/bin/go-onebaby; pwd"

#-----------------方法-------------------
#获取 map 中的key
function obtainKey(){
    echo ${projectName}"_"${environment}
}

function initServerFileNameMap(){
    serverFileNameMap["money_test"]="/data/work/tomcat/webapps"
    serverFileNameMap["one_test"]="/data/work/tomcat/webapps"
	
	if [[ ${environment} == "production" ]]; then
		#获取公网的上传路径
		serverFileName=$(ssh ${serverMap[${key}]} ${serverPublishWarPathBin[${key}]}  ) 
		serverFileNameMap["${key}"]=${serverFileName}
	fi
	
	for date in ${serverFileNameMap[@]}
	do
		echo $date
	done
}

#-----------------main-------------------

if [[ ${projectName} != "money" && ${projectName} != "one" ]]; then
    echo "项目名称有误！"
    exit 0;
fi

#获取 map 的key
key=`obtainKey`

#初始化服务器上的路径
initServerFileNameMap

if [[ ${executePack} == "y" ]]; then
    source pack.sh ${localProjectPathMap[$projectName]} ${environment}
fi

#上传文件
#echo ${serverMap["${key}"]}"_"${localFileNameMap["${key}"]}"_"${serverFileNameMap["${key}"]}"_"n
source uploadWar.sh ${serverMap["${key}"]} ${localFileNameMap["${key}"]} ${serverFileNameMap["${key}"]} n
