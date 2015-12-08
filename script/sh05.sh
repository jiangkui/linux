#!bin/bath
#说明： 测试 test 
#时间：2015-12-08

#1.判断是否输入字符串
read -p "请输入文件名：" filename
test -z $filename && echo "您必须输入" && exit 0

#2.判断文件是否存在
test ! -e $filename && echo "文件 $filename 不存在" && exit 0

#3.开始判断文件类型与属性
test -f $filename && echo "文件存在"
test -d $filename && echo "目录存在"
test -r $filename && echo "有读取权限"
test -w $filename && echo "有写入权限"
test -x $filename && echo "有执行权限"
