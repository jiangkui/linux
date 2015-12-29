#!/bin/bash
#
#-----------------版权--------------------
# 名称: 上传 war 包
# 版本：1.0
# 语言：bash shell
# 日期：2015年12月25日17:21:39
# 作者：ljk
# 邮件：1013939150@qq.com
#-----------------环境--------------------
# Linux 3.13.0
# GNU Bash 4.3.11

#-----------------常量--------------------

#-----------------变量--------------------

#-----------------方法--------------------

function echoLog(){
    echo ""
    echo $1
    echo ""
}

#-----------------main-------------------
server=$1 #root@192.168.1.31
localFileName=$2 #/root/xx/xxx/xx.war
serverFileName=$3 #/root/xx/xxx/xx.war
tryAgain=$4 #上传失败时是否重新尝试

if [[ ${server} == "" || ${localFileName} == "" || ${serverFileName} == "" ]]; then
    echo "参数不全！"
    exit 0;
fi

source printLog.sh "上传 War 包"
echo "${localFileName} ---> ${server}:${serverFileName} "

localWarMd5=$(md5sum ${localFileName} | awk '{print $1}')
serverWarMd5=""

uploadNum=0
while [[ ${localWarMd5} != ${serverWarMd5} ]]; do
    ((uploadNum=uploadNum + 1))

    if [[ ${uploadNum} -gt 2 ]] ; then
        echo "上传次数超过2次，上传失败！请手动上传！"
        exit 0;
    fi

    echoLog "第 ${uploadNum} 次上传。。。"

    scp ${localFileName} ${server}":"${serverFileName}

    echoLog "上传完毕，正在校验文件完整性，请稍等。。。"

    serverWarMd5=$(ssh ${server} "md5sum ${serverFileName}" | awk '{print $1}')

    echo "localFileMd5:${localWarMd5}"
    echo "serverWarMd5:${serverWarMd5}"

    if [[ ${localWarMd5} != ${serverWarMd5} ]]; then
        echo "md5sum 不等，文件上传过程中有损坏！"

        if [[ ${tryAgain} != "y" ]]; then
            read -p "请输入 y/n 重新尝试上传！" tryAgain
            if [[ ${tryAgain} != "y" ]]; then
                exit 0;
            fi
        fi

    else
        echo "md5sum 相等，文件上传成功！"
    fi
done