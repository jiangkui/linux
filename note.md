#《鸟哥的Linux私房菜》基础学习篇（第三版）2015-12-07 

[TOC]

>ps:刚才才把 算法（第4版）速读完毕，然后就打算了解下 linux 系统，毕竟现在代码、负载均衡、数据库、redis 等等都是在 linux 上跑的，整个系统都在 linux 上，那么没有理由不去了解他。
>本次速读的目标：
>- 了解linux系统，对系统内的各种模块、功能有一个大概的认识，要达到 随便说一个名词，知道他是干啥的。
>- 学习linux 里面的一些工具，如 vim、shell 等，根据后期的学习情况在定是否要熟练掌握。
>- 本次速读预计时间：1周左右（2015-12-07 ~ 2015-12-14），如果时间不够，再酌情延长。

# 第 0 章 计算机概论
`start:2015-12-07 08:56`

## 0.1 计算机：辅助人脑的好工具

### 0.1.1 计算机的五大单元
输入单元、输出单元、CPU内部控制单元、CPU算术逻辑单元、内存。
CPU 实际要处理的数据完全来自于内存。

### 0.1.2 CPU 的种类
精简指令集：
复杂指令集：

## 0.2 个人计算机架构与接口设备
CPU：
内存：
显卡：
硬盘与存储设备：
PCI适配卡：
主板：
电源：

## 0.3 数据表示方式

# 第 1 章 Linus 是什么
Linux 的内核原型是 1991 年由托瓦兹写出来的。

介绍 linux 和 unix 的历史

## 1.3 Linux 的特色

# 第 2 章 Linux 如何学习

## 2.4 鸟哥的建议（重点在 Solution 的学习）
两个重要的因素会造成我们学习的原动力：
- 成就感
- 兴趣

`end:2015-12-07 09:26`
# 第 3 章 主机规划与磁盘分区

### 各硬件装置在 Linux 中的文件名
IDE 接口的硬盘的文件名为 /dev/hd[a-d] 

几乎所有的硬件档案都在 /dev 这个目录内。硬盘、USP、打印机、鼠标等。。。

### 磁盘分区

# 第 4 章 安装 CentOS 5.x 与多重引导小技巧



# 第 5 章 首次登陆与在线求助
## 5.2 在命令行模式下执行命令

>command [-options] parameter1 parameter2

在linux 中，英文大小写字母是不一样的。

### 5.2.2 基础命令的操作
>系统当前语言：echo $LANG 
>修改语言：LANG=en_US
>显示日期的命令：date +%Y/%m/%d+%H:%M:%S
>显示日历的命令：cal [[month] year]，cal 12 2015
>简单好用的计算器：bc

### 5.2.3 重要的热键[Tab]，[Ctrl]-c，[Ctrl]-d
补全命令，中断目前程序，键盘输入结束（或 相当于exit）

### 5.2.4 错误信息的查看
命令找不到的几种可能：command not found
- 该命令的软件没装
- 命令所在的目录目前的用户没有将他加入命令搜索路径中，参考 bash 的PATH 说明。
- 命令打错了

## 5.3 Linux 系统的在线求助 man page 与 info page
>查看Linux 有多少命令：连按两个table

### 5.3.1 man page
man 是 manual 的简写
>查看某命令的操作说明：man date

### 5.3.2 info page
linux 额外提供的一种在线求助的方法，info 与 man 的用途其实差不多。
>info cal


## 5.4 超简单文本编辑器：nano


## 正确的关机方法
>查看目前由谁在线：who
>查看网络联机状态：netstat -a 
>查看执行程序：ps -aux
>将数据同步写入硬盘 sync
>关机指令：shutdown
>重启动，关机：reboot，halt，poweroff


# 第 6 章 Linux 的档案权限与目录配置
drwxrwxr-x   4 work work     4096 Oct 23  2012 20121023
-rw-rw-r--      1 work work 97044828 Oct 23  2012 20121023.bz2

`[权限][连结][拥有者][群组][档案容量][修改日期][档案名]`

`-rw-rw-r--`  共十个字符：
- 第一个字符有一下几种：
	- d 表示目录
	- `- 表示是文件`
	- l 表示link
- 接下来的字符，三个为一组，[rwx] 分别表示，读写执行 三个权限。没权限则表示 -
	- 第一组为拥有者的权限
	- 第二组为 同组的权限
	- 第三组为 其他人的权限

### Linux 目录配置的依据--FHS
/usr：与软件安装/执行有关
/var：与系统运作过程有关


# 第 7 章 Linux 档案与目录管理
介绍：档案与目录的 增删改查

常用的目录命令：
- cd：变换目录
- pwd：显示当前目录
- mkdir：建立一个新的目录
- rmdir：删除一个空的目录
- rm： 
- mv：移动 或 改名

# 第 8 章 Linux 磁盘与文件系统管理

本章的重点在于如何制作文件系统，包括分割、格式化与挂载等。


# 第 9 章 档案与文件系统的压缩与打包

# 第 10 章 vim 程序编辑器
vim 是进阶版的 vi，vim 不但可以用不同颜色显示文字内容，还能够进行诸如 shell script, C program 等程序编辑功能。 

##10.1 vi 与 vim
vi 文本编辑器 使用广泛。
vim 有编程的能力，字体颜色可以辨别语法的正确性，方便程序设计
程序简单，编辑速度快





## 10.2 vi 的使用

## 10.3 vim 的额外功能

## 10.4 其他 vim 的使用注意事项

## 10.5 重点回顾

# 第 11 章 认识与学习 BASH
`start:2015-12-07 22:00`
## 11.2 shell 的变量功能

### 11.2.7 与文件系统及程序的限制关系：ulimit
可以限制用户的某些系统资源的，包括可以打开的文件数量、可以使用的 CPU 时间、可以使用的内存总量等。

## 11.3 命令别名与历史命令


## 11.4 Bash Shell 的操作环境

### 11.4.1 路径于命令查找顺序
命令运行的顺序：
1. 以相对/绝对路径执行命令
2. 由 alias 找到该命令来执行
3. 由 bash 内置的（builtin）命令来执行
4. 通过 $PATH 这个变量的顺序找到的第一个命令来执行

### 11.5.1 什么是数据流重定向
数据流重定向可以将 输入命令返回的信息传送到其他地方。

分别传送所用的特殊字符如下所示：
1. 标准输入（stdin）：代码为0，使用 < 或 <<
2. 标准输出（stdout）：代码为1， 使用 > 或 >>
3. 标准错误输出（stderr）：代码为2，使用 2> 或 2>>

>例如：ll ~/rootfile

## 11.6 管道命令（pipe）

### 11.6.1 选取命令：cut，grep

### 11.6.2 排序命令：sort,wc,uniq

# 第 12 章 正则表达式与文件格式化处理

# 第 13 章 学习 shell script

### 13.1.2 第一个 script 的编写与执行
```bash
#!/bin/bsh
# Program：
#       第一个 hello world
# Data：
#       2015-12-07 23:06:06
#
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
echo -e "Hello World! \a \n"
exit 0
```

### 13.1.3 编写 shell script 的良好习惯
写脚本时，加上功能，版本信息，作者等注释。


## 13.2 简单的 shell script 练习

### 13.2.1 简单范例
交互式脚本：
```bash
#!/bin/bash
# Program:
#       一个简单的交互程序
# Date：
#       2015-12-07 22:57:59
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

read -p "请输入你的名字：" name
read -p "请输入你的年龄：" age
echo "\n你的名字：$name 年龄 $age"
```

创建 三个文件 sh03.sh
```bash
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
```


## 13.4 条件判断式

### 13.4.1 利用 if ... then




# 第 17 章 程序管理与 SELinux 初探
`start:2015-12-11 08:21`

搜集帖子和招聘信息，了解下一步学习的方向，现在决定，要先了解linux 的系统。
预算：2个周。

`end:2015-12-11 09:30`

`start:2015-12-11 12:40`
主要寻找两个问题：
1. 我为什么要学linux：
	- 进阶需要，早晚得学的东西，刚好最近的学习计划是这个
	- 尝试做一个改变吧。
2. 从哪里入手：
	- 从 Ubantu 开始吧，过度简单一些。
	- win10 格式化掉。

`end:2015-12-11 13:40`

`start:2015-12-11 22:08`
ubantu 下载完毕，明天把 win10 革掉。
`end:2015-12-11 `

`start:2015-12-12 17:50`
忙活了一下午终于把 Ubuntu 装好了，期间主要遇到两个大问题：
- 安装Ubuntu14 时，老是提示Windows 未能启动，后来才知道是没能设置好U盘启动。 
	- 关掉 secure boot
	- 设置 U盘启动为首选方式
- 电脑无线网卡的安装问题：
	- 如果连不上无线网，应该就是无线网卡驱动没有，需要重装无线网卡驱动
	- 方法很简单，参考地址：http://jingyan.baidu.com/article/ca2d939dd4f1b4eb6c31ce09.html
	- 【系统设置】-->【软件和更新】-->【Ubuntu软件】-->【下载自】-->【其他站点】-->【选 中国 mirrors.aliyun.com 阿里云的快，选择最佳服务器可能找到国外去】

`end:2015-12-12 18:01`

`start:2015-12-13 10:04`
今天主要处理以下问题：
- 寻找开发、工作需要软件的替代方式。
	- 紧急且重要的软件：
		1. Idea 14的使用:http://www.jetbrains.com/idea/download/#tabs_1=linux
		2. Java 7:http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html
		3. Tomcat 7:http://tomcat.apache.org/download-70.cgi
		4. Svn(支持ssl）：http://blog.csdn.net/osherrylee/article/details/8559558
		5. maven:
			- 官网地址：http://maven.apache.org/download.cgi
			- 下载地址：http://apache.mirrors.tds.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
		6. 
	- 重要的软件：
		1. 有道词典:有 linux 版本，官网下载即可:http://cidian.youdao.com/index-linux.html?keyfrom=cnbeta&utm_source=mindstore.io
		2. QQ: http://www.ubuntukylin.com/application/show.php?lang=cn&id=279
		3. mysql:暂时就先这样
		4. chrome 
		5. 印象笔记
		6.  
- 对 Ubuntu 系统、快捷键有一个大概的了解
`end:2015-12-13 22:57`

`start:2015-12-14 22:00`
ubuntu系统使用SSH免密码登陆:http://jingyan.baidu.com/article/60ccbceb02bd4264cab197b9.html

链接阿里云(默认端口是 22)：ssh -p22 root@101.200.174.82
`end:2015-12-14 22:30`
