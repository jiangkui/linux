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



