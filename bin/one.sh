#!/bin/bash
#
#-----------------版权--------------------
# 名称：抓取一元夺宝数据
# 版本：1.0
# 语言：bash shell
# 日期：2015年12月28日11:38:10
# 作者：ljk
# 邮件：1013939150@qq.com
#-----------------环境--------------------
# Linux 3.13.0
# GNU Bash 4.3.11

#-----------------常量--------------------
prefixUrl="http://1.163.com/goods/getPeriod.do?navigation=-1"
varPeriod="&period="
timestamp="&t="$(date +%s)
varToken="&token="
varGid="&gid="

USER=root
PASSWORD=ljk
DB=one

#-----------------变量--------------------
period=""
gid=""
token="eba2fa19-8f82-4fca-b4fe-f1476f75988e"

#-----------------数组--------------------

#-----------------方法--------------------
function queryUrl(){
    if [[ $1 == "" || $2 == "" ]]; then
        echo "期号商品id不能为空！"
        exit 0;
    fi

    echo ${prefixUrl}${varPeriod}$1${timestamp}${varToken}${token}${varGid}$2
}

function saveDate(){
    codes=$(echo $1 | jq ".code")

    if [[ ${codes} != "0" ]]; then
        echo "code 不为0！"$1
        exit 0;
    fi

    periodWinner=$(echo $1 | jq ".result.periodWinner")

    savePeriodWinner "${periodWinner}"

    echo ""
}

function savePeriodWinner(){
    savePeriodDate "$1"

    owner=$(echo $1 | jq ".owner")
    saveUserDate "${owner}"
}

function savePeriodDate(){
    luckyCode=$(echo $1 | jq ".luckyCode")
    ownerCost=$(echo $1 | jq ".ownerCost")
    status=$(echo $1 | jq ".status")
    duobaoTime=$(echo $1 | jq ".duobaoTime")
    ownerCid=$(echo $1 | jq ".owner.cid")
    goodsId=$(echo $1 | jq ".goods.gid")
    calcTime=$(echo $1 | jq ".calcTime")
    period=$(echo $1 | jq ".period")
    cost=$(echo $1 | jq ".cost")

    insertSql="INSERT INTO period_winner (lucky_code, owner_cost, status, duobao_time, cid, goods_id, calc_time, period, cost) VALUES (${luckyCode}, ${ownerCost}, ${status}, ${duobaoTime}, ${ownerCid}, ${goodsId}, ${calcTime}, ${period}, ${cost})"

    saveToMysql "${insertSql}"
}

function saveUserDate(){
    uid=$(echo $1 | jq ".uid")
    avatarName=$(echo $1 | jq ".avatarName")
    freeCoin=$(echo $1 | jq ".freeCoin")
    IPAddress=$(echo $1 | jq ".IPAddress")
    isFirstLogin=$(echo $1 | jq ".isFirstLogin")
    nickname=$(echo $1 | jq ".nickname")
    coin=$(echo $1 | jq ".coin")
    IP=$(echo $1 | jq ".IP")
    avatarPrefix=$(echo $1 | jq ".avatarPrefix")
    cid=$(echo $1 | jq ".cid")
    bonusNum=$(echo $1 | jq ".bonusNum")
    mobile=$(echo $1 | jq ".mobile")

    insertSql="INSERT INTO user (uid, avatarName, freeCoin, IPAddress, isFirstLogin, nickname, coin, IP, avatarPrefix, cid, bonusNum, mobile) VALUES (${uid}, ${avatarName}, ${freeCoin}, ${IPAddress}, ${isFirstLogin}, ${nickname}, ${coin}, ${IP}, ${avatarPrefix}, ${cid}, ${bonusNum}, ${mobile})"
    saveToMysql "${insertSql}"
}

function saveToMysql(){
    $(mysql -u${USER} -p${PASSWORD} -D ${DB} -e "$1")
}

#-----------------main--------------------

period=$1
if [[ ${period} == "" ]]; then
    period=212310462
fi

gid=$2
if [[ ${gid} == "" ]]; then
    gid=898
fi


num=1
while [[ ${num} -lt 1000000 ]]; do
    echo "第 ${num} 次请求！ 期号：${period}  商品：${gid}"
    url=$(queryUrl ${period} ${gid})
    result=$(curl -s ${url})

    #使用 jq 进行各种过滤
    period=$(echo ${result} | jq ".result.periodWinner.period")
    gid=$(echo ${result} | jq ".result.periodWinner.goods.gid")

    saveDate "${result}"

#    sleep 0.1
    ((num=num+1))
done


#curl -s 'http://1.163.com/goods/getPeriod.do?gid=898&period=212310462&navigation=-1&t=1451265961395&token=eba2fa19-8f82-4fca-b4fe-f1476f75988e' |jq "."
#curl -s 'http://1.163.com/goods/getPeriod.do?gid=898&period=212273829&navigation=-1&t=1451265961395&token=eba2fa19-8f82-4fca-b4fe-f1476f75988e' |jq ". | {period: .result.periodWinner.period, cid:.result.periodWinner.owner.cid, uid:.result.periodWinner.owner.uid}"
