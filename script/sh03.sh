
#!/bin/bsh
# 程序：
#       创建三个文件
#
# 日期：
#       2015-12-07 23:49:27
#
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo -e "将创建三个文件"
read -p "请输入文件名字：" fileuser

filename=${fileuser:-"filename"}  #开始判断是否有配置文件名

date1=$(date --date='2 days ago' +%Y%m%d) #前两天的日期
date2=$(date --date='1 days ago' +%Y%m%d) #前一天的日期
date3=$(date +%Y%m%d) #今天的日期
file1=${filename}${date1}
file2=${filename}${date2}
file3=${filename}${date3}

touch "$file1"
touch "$file2"
touch "$file3"
