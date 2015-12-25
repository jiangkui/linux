#!/bin/bash
#
#-----------------版权--------------------
# 名称：输出日志
# 版本：1.0
# 语言：bash shell
# 日期：2015年12月25日17:07:01
# 作者：ljk
# 邮件：1013939150@qq.com
#-----------------环境--------------------
# Linux 3.13.0
# GNU Bash 4.3.11

#-----------------常量--------------------
projectPath=$1 #工程路径
environment=$2 #环境  test | production

#-----------------main-------------------

source printLog.sh "打 war 包"

if [[ ${projectPath} = "" ]]; then
    echo "请输入工程路径！"
    exit 0;
fi

cd $1

source printLog.sh "mvn clean"
mvn clean

source printLog.sh "mvn package"

if [[ ${environment} == "" ]]; then
    mvn package -Dmaven.test.skip=true
else
    mvn package -Dmaven.test.skip=true -P${environment}
fi
