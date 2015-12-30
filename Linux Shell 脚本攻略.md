#《Linux Shell 脚本攻略》（第二版） 2015年12月29日21:11:13
	
[toc]
	
`本书的练习脚本放在 script/two 文件夹里面`
	
# 第 1 章 小试牛刀
	
当启动 shell 时，他会执行一组命令来定义诸如提示文本、颜色等各类设置。这组命令来自于 ~/.bashrc（非交互式）。（对于登录shell（交互式）则是 ~/.bash_profile）
登陆shell 是登陆主机后获得的那个 shell。
	
~/.bash_history：保存用户运行过的命令。
	
打印彩色输出(`直接执行好使，脚本中不好使，原因未查`)：
echo -e "\e[1;31m This is red text \e[0m"
	
##1.3 玩转变量和环境变量
	
获得某应用的进程id
>pgerp java
获取该应用的环境变量
>cat /proc/$PID/environ
>结果：M2_HOME=/home/ljk/progect/apache-maven-3.3.9LC_PAPER=zh_CN.UTF-8JOB=dbus ...
	
两个变量之间用 null 字符(`\0`)分隔，我们可以这么玩：把 null 改成换行（tr命令可以替换）
>cat /proc/$PID/environ | tr '\0' '\n'
>结果：变成一行一行的了
>M2_HOME=/home/ljk/progect/apache-maven-3.3.9
>LC_PAPER=zh_CN.UTF-8
>JOB=dbus 

#####常见误区
var=value 是为 var 赋值。
var = value 表示相等操作。这是一个常见的错误！
	
#### 补充内容
获得字符串长度
>length=${#var}
	
识别当前使用的shell
>echo $SHELL  或 echo $0
	
检查是否未超级用户
root 用户的UID是0
>echo $UID
	
## 1.5 使用 shell 进行数学运算
bash shell 环境，可以利用 let、(()) 和 [] 执行基本的算数操作，高级操作时 expr 和 bc 这两个工具也会有用。
	
## 1.6 玩转文件描述符及重定向

将 stderr 转换成 stdout 并且都重定向到 一个文件中
>cmd 2>&1 output.txt 或 cmd &> out.txt

有一个方法可以将数据重定向到文件，还可以提供一份重定向数据的副本作为后续命令的 stdin。（tee 命令，既能输出到文件，还同时输出到屏幕）

`> 和 >> 不同，前者会清空文件在写入，后者是追加。`
处理错误信息时可以这样：
cmd 2>/dev/null
/dev/null 是一个特殊的设备文件，它接收到的任何数据都会被丢弃。null设备也被称为黑洞。

## 1.7 数组合关联数组
见 arr.sh

## 1.8 别名
$ \command 命令可以强制使用命令，而不执行别名。是一个不错的安全保证。防止中要操作被黑客设置成别名而丢失数据。

## 1.9 获取终端信息
tput stty

## 1.10 获取、设置日期和延时
查看一组命令花费时间

time script.sh

或者脚本执行前 获取 start=$(date +%s)，脚本执行后在获取一次，相减即可。

一个比较好玩的演示脚本：tput的运用
tput.sh

## 1.11 调试脚本
bash -x script.sh
sh -x script.sh

调试神器！

## 1.12 函数和参数

fork炸弹

echo $? 可以获取命令或函数的返回值，返回值被称为退出状态，可以用户分析命令执行成功与否。 成功退出则为0

## 1.13 将命令序列的输出读入变量
shell 脚本最棒的特性之一就是可以轻松的将多个命令或工具组合起来生成输出。
一个命令的输出可以作为另一个命令的输入。

$ cmd1 | cmd2 | cmd3

#### 有两种方法可以读取由管道相连的命令序列的输出
##### 子shell
cmd_output=$(ls | cat -n)

##### 反引用
cmd_output=`ls | cat -n`


读入输出的数据时，可以用双引号的方式保存 空格和换行，如：
cmd_output="$(ls | cat -n)"


## 1.14 不使用回车键来读取 n 个字符

read.sh

## 1.15 运行命令直至执行成功

## 1.16 字段分隔符和迭代器
IFS
迭代器是
for while until
until：一直执行循环，直到条件为真为止。

`end:2015年12月30日09:32:37`

