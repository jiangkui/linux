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

set -x
set +x

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

## 1.17 比较与测试
-gt：大于
-lt：小于
-ge：大于或等于
-le：小于或等于

#### 文件系统：
[ -f $file_var ]：变量包含正常的文件路径或文件名，则返回真
[ -x $var ]：能执行，则返回真
-d：目录
-e：文件存在
-w：文件可写
-r：文件可读
-L：符号链接

#### 字符串比较：
[ -z $str1 ]：str1是空字符串，则返回真
[ -n $str1 ]：非空字符串，则返回真

# 第 2 章 命令之乐

## 2.2 用 cat 进行拼接
a.txt 内容为：
aaaaaa

echo "test" | car - a.txt  #减号表示 stdin 文本的文件名
test
aaaaaa

cat -s #可以压缩相邻的空白行

## 2.3 录制并回放终端回话

## 2.4 文件查找与文件列表
find 命令

#### 利用find 执行命令或操作
find . -exec cp {} \;

find 跳过一些目录

`end:2015年12月30日13:25:49`
## 2.5 玩转 xargs
xargs 擅长将标准输入数据转换成命令行参数，有些命令只能以命令行参数的形式接受数据，而无法通过 stdin 接受数据流。

```bash
echo "j,a,q,d,q,w" | xargs -d ,
j a q d q w

echo "j,a,q,d,q,w" | xargs -n 1 -d ,
j
a
q
d
q
w
```

## 2.6 用 tr 进行转换
tr [options] set1 set2

用 set2 中的数据替换 set1 的。如果 set2.length > set1 则忽略多余的长度，如果少于，则重复 set2[set2.length] ，直至长度与 set1 一样长。

```bash
$ echo "HELLO WORLD" | tr 'A-Z' 'a-z'
hello world

#简单的加密  用 9~0 替换 原来的字符串
$ echo "023303" | tr '0-9' '9876543210'
976696
#解密
$ echo 976696 | tr '0-9' '9876543210'
023303

#ROT13 加密算法
$ echo "Hello, how are you." | tr 'a-zA-Z' 'n-za-mN-ZA-M'
Uryyb, ubj ner lbh.

#解密
$ echo "Uryyb, ubj ner lbh." | tr 'a-zA-Z' 'n-za-mN-ZA-M'
Hello, how are you.
```

`end:2015年12月31日13:24:09`

## 2.7 校验和与核实
md5sum 
sha1

## 2.8 加密工具与散列

#### 加密技术 在linux 环境下有一些工具可以用来执行加密和解密
crypt、gpg、base64、md5sum、sha1sum、以及 openssl 。

shadow-like 散列（salt 散列）
linux 用户密码事以散列值形式存在 /etc/shadow 中

密码对应的散列值。 openssl 可以生成 shadow 密码

## 2.9 排序(sort)、唯一与重复(uniq)

```bash
$ sort b.txt a.txt >d.txt
$ cat d.txt 
aaaaaaaaa
bbbbbbbb
```

## 2.10 临时文件名与随机数


## 2.11 分割文件和数据
split 
csplit

## 2.12 根据扩展名切分文件名

## 2.13 批量重命名和移动

## 2.14 拼写检查与词典操作

## 2.15 交互输入自动化
```bash
$ echo -e "1\nhello\n" | ./tm.sh
1 hello
```

## 2.16 利用并行进程加速命令执行
多线程执行 md5sum file

```
& 可以将shell命令置于后台执行。
$! 可以获得进程的 PID，$! 保存着最近一个后台进程的 PID。
wait 命令可以等待进程结束
```

```bash
#!/bin/bash
PIDARRAY=()
for file in a.txt b.txt c.txt
do 
	md5sum $file &
	PIDARRAY+=("$!")
done
wait ${PIDARRAY[@]}
```

