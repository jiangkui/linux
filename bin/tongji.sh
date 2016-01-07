#!/bin/bash
#
#-----------------版权--------------------
# 名称：抽奖功能统计
# 版本：1.0
# 语言：bash shell
# 日期：2016年01月07日14:35:34
# 作者：ljk
# 邮件：1013939150@qq.com
#-----------------环境--------------------
# Linux 3.13.0
# GNU Bash 4.3.11
# pwd: /data/work/testljk/tongji.sh

#-----------------变量--------------------
dateParam=$1 #日期参数
if [[ ${dateParam} == "" ]];
then
    dateParam=`date "+%Y-%m-%d"`
fi

dialCount=0;
dialCountCiShu=0; #今天所有账户，总共可以抽多少次
dialCountShengYuCiShu=0; #今天剩余抽奖次数
defaultNum=0; #默认抽奖次数 / 人

#---------------输出变量------------------
ChouJiangZongCiShu=0; #抽奖总次数（今天总共抽了多少次）
ChouJiangZongRenShu=0; #抽奖总人数（今天有多少人抽过奖）

ZhongJiangZongCiShu=0; #中奖总次数（今天中了多少次奖）
ZhongJiangZongRenShu=0; #中奖总人数（今天有多少人中过奖）

AnWeiCiShu=0; #安慰次数
AnWeiRenShu=0; #安慰人数

#-----------------方法--------------------

#查询mysql
function queryMySql(){
    mysql -u work -p123456 -h mysqlmsdb1 -D "one"  -e "$1"
#    mysql -u root -pljk -D "one"  -e "$1"
}

function queryRedis(){
    ssh redis11 "redis-cli -h redis11 -p 6381 $1"
#    ssh root@192.168.1.37 "/data/work/redis3/redis-cli -p 6381 $1"
}

function print(){
    num=$2
    if [ ! $num ];
    then
        num=0
    fi
    echo $1"$num"
}

#-----------------main--------------------


print "日期参数：" ${dateParam}
echo ""

#mysql 中抽奖账户总数量
dialCount=$(echo `queryMySql "select count(1) from dial_account"` | awk '{print $2}' )

#从redis中设置 每人能抽几次
defaultNum=`queryRedis "get one_default_dial_num"`

#可以抽的总次数= 总人数*每人能抽几次
((dialCountCiShu=dialCount * defaultNum))

#剩余抽奖次数
dialCountShengYuCiShu=$(echo `queryMySql "select sum(num) from dial_account"` | awk '{print $2}' )

#今天抽了多少次 =可以抽的总次数-剩余抽奖次数
((ChouJiangZongCiShu=dialCountCiShu-dialCountShengYuCiShu))
print "今天抽奖总次数：" ${ChouJiangZongCiShu}

#有多少人抽过奖
ChouJiangZongRenShu=$(echo `queryMySql "select count(1) from dial_account where num< $defaultNum"` | awk '{print $2}' )
print "今天有多少人抽过奖：" ${ChouJiangZongRenShu}

#今天中了多少次奖
ZhongJiangZongCiShu=$(echo `queryMySql "select count(1) from dial_prize_record where date(create_time) = '${dateParam}'"` | awk '{print $2}' )
print "今天中了多少次奖：" ${ZhongJiangZongCiShu}

#今天有多少人中过奖
ZhongJiangZongRenShu=$(echo `queryMySql "select count(1) from (select 1 from dial_prize_record where date(create_time) = '${dateParam}' group by user_id) a;"` | awk '{print $2}' )
print "今天有多少人中过奖：" ${ZhongJiangZongRenShu}

#今天中安慰奖的次数
AnWeiCiShu=$(echo `queryMySql "select count(1) from dial_prize_record where date(create_time) = '${dateParam}' and care=1"` | awk '{print $2}' )
print "今天中安慰奖的次数：" ${AnWeiCiShu}

#安慰人数
AnWeiRenShu=$(echo `queryMySql "select count(1) from (select 1 from dial_prize_record where date(create_time) = '${dateParam}' and care=1 group by user_id) a"` | awk '{print $2}' )
print "安慰人数：" ${AnWeiRenShu}

#redis设置的抽奖次数
setNum=`queryRedis "get one_dial_settings"`
setNum=`echo "${setNum##*awardUserNum\"\:}"`
setNum=`echo "${setNum%\}*}"`
print "redis设置的抽奖次数：" ${setNum}

#今天中奖情况
ZhongJiangQingKuang=`queryMySql "
select * from (
    select count(1) as 'num',
    case
        when type = 1 then '谢谢参与'
        when type = 2 then '夺宝券'
        when type = 3 then '幸运券'
        when type = 4 then '红包'
        when type = 5 then '再来一次'
        when type = 6 then '实物'
        when type = 7 then '话费'
        when type = 8 then 'Q币'
        else '未知' end as '奖项'
    from one.dial_prize_record where date(create_time) = '${dateParam}' group by type
) res  order by res.num desc;"`
echo ""
echo "=================================="
echo "各种奖项今天中奖情况："
echo "${ZhongJiangQingKuang}"

#历史总中将情况
ZhongJiangQingKuangAll=`queryMySql "
select * from (
    select count(1) as 'num',
        case
            when type = 1 then '谢谢参与'
            when type = 2 then '夺宝券'
            when type = 3 then '幸运券'
            when type = 4 then '红包'
            when type = 5 then '再来一次'
            when type = 6 then '实物'
            when type = 7 then '话费'
            when type = 8 then 'Q币'
        else '未知' end as '奖项'
    from one.dial_prize_record group by type
) res order by res.num desc;"`
echo ""
echo "=================================="
echo "历史总中将情况："
echo "${ZhongJiangQingKuangAll}"

#每个奖项的库存
dialIdList=`queryRedis "lrange one_dial_prize_list 0 -1"`
echo ""
echo "=================================="
echo "每个奖项的初始库存"

printf "%-10s%-12s%-20s\n" "ID" "库存" "奖项名称"
for dial in ${dialIdList}
do
    dialid=`queryRedis "hget $dial id"`
    dialName=`queryRedis "hget $dial name"`
    dialNum=`queryRedis "hget $dial dailyCapacity"`
    if [ ! ${dialNum} ];
    then
        dialNum=0
    fi

    printf "%-10s%-10s%-20s\n" ${dialid} ${dialNum} "${dialName}"
done

