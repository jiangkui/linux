#!/bin/bash
#
#-----------------版权--------------------
# 名称：发布静态文件
# 版本：1.0
# 语言：bash shell
# 日期：2016年01月04日11:39:53
# 作者：ljk
# 邮件：1013939150@qq.com
#-----------------环境--------------------
# Linux 3.13.0
# GNU Bash 4.3.11

#-----------------参数--------------------
tryAgain=$1
serverMt="root@192.168.1.42"
serverLvs="work@lvs"

#-----------------数组--------------------
#serverPublishWarPathBin["one_production"]=". ~/bin/go-onebaby; pwd"

#-----------------方法-------------------
function printLog(){
    echo ""
    echo "================================================"
    echo $1
    echo "================================================"
    echo ""
}

function uploadWar(){
    localMd5=$(ssh ${serverMt} "cd /data/work/nginx/www; md5sum mt.zip" | awk '{print $1}')

    serverMd5=""
    uploadNum=0
    while [[ ${localMd5} != ${serverMd5} ]]; do
        ((uploadNum=uploadNum + 1))

        if [[ ${uploadNum} -gt 3 ]] ; then
            echo "上传次数超过3次，上传失败！"
            exit 0;
        fi

        echo "第 ${uploadNum} 次上传。。。"

        echo "远程执行 scp /data/work/nginx/www/mt.zip ==> ${serverLvs}:${serverFile} 请等待。。。"

        ssh ${serverMt} "scp /data/work/nginx/www/mt.zip ${serverLvs}:${serverFile}"

        serverMd5=$(ssh ${serverLvs} "md5sum ${serverFile}" | awk '{print $1}')

        echo "localFileMd5:${localMd5}"
        echo "serverWarMd5:${serverMd5}"

        if [[ ${localMd5} != ${serverMd5} ]]; then
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
}

#-----------------main-------------------
echo "$(printLog "打 zip 包")"
echo "$(ssh ${serverMt} "cd /data/work/nginx/www; ./go.sh")"

echo "$(printLog "打包完成")"

#获取公网路径
serverFile=$(ssh ${serverLvs} ". ~/bin/go-money; pwd")"/mt.zip"

uploadWar

read -p "是否远程执行自动发布脚本?(lvs auto-mt.sh) 请输入 y/n " autoMt
if [[ ${autoMt} == "y" ]];
then
    echo $(ssh ${serverLvs} ". ~/bin/go-money; . ./auto-mt.sh")
fi