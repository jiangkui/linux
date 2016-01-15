#学习linux 系统遇到的问题

##安装系统
1. 安装Ubuntu14 时，老是提示Windows 未能启动，后来才知道是没能设置好U盘启动。 
	- 关掉 secure boot
	- 设置 U盘启动为首选方式
2. 电脑无线网卡的安装问题：
	- 如果连不上无线网，应该就是无线网卡驱动没有，需要重装无线网卡驱动
	- 方法很简单，参考地址：http://jingyan.baidu.com/article/ca2d939dd4f1b4eb6c31ce09.html
	- 【系统设置】-->【软件和更新】-->【Ubuntu软件】-->【下载自】-->【其他站点】-->【选 中国 mirrors.aliyun.com 阿里云的快，选择最佳服务器可能找到国外去】

##软件的替代品

###开发工具下载地址
####Idea
- 已解决：官网下载即可
- 下载地址：[Idea 15](http://www.jetbrains.com/idea/download/#tabs_1=linux)

####JDK 7
- 已解决：官网下载即可
- 下载地址： [JDK 7](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html)

####Tomcat 7
- 已解决：官网下载即可
- 下载地址： [Tomcat 7](http://tomcat.apache.org/download-70.cgi)

####Subversion
- 已解决：linux 版本中需要支持 ssl
- 解决方案链接： [Svn(支持ssl）](http://blog.csdn.net/osherrylee/article/details/8559558)

####Maven 
- 已解决：官网下载即可
- 下载地址：[maven 3.3](http://maven.apache.org/download.cgi)

####Mysql
- 已解决: `sudo apt-get install mysql-server`

###常用软件
####QQ
- 已解决：ubuntu 14.0.4 下可用，稳定性不错。
- 方案：Wine 模拟
    - Wine (简体中文) 是类 UNIX 系统下运行微软 Windows 程序的"兼容层"，可以用它模拟 Windows 环境来运行 QQ/TM。
    - 参考链接：[arch linux wiki，翻墙食用](https://wiki.archlinux.org/index.php/Tencent_QQ_%28%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87%29)
问题：基于 2012 的，用惯了 windows 下的2015，再用这个"老家伙"会感觉怪怪的。
下载地址：[Wine QQ 下载地址，ubuntu 14.0.4 可用](http://www.ubuntukylin.com/application/show.php?lang=cn&id=279) 

####有道词典
未解决：官网有支持 linux 版本，下载即可，但 下面的问题未解决，依然不能高效率的查词翻译。
问题： F8 快捷键被占用了，至今未能禁用掉该快捷键，并且部支持迷你窗口快捷键
下载地址：[官网地址](http://cidian.youdao.com/index-linux.html?keyfrom=cnbeta&utm_source=mindstore.io)

####Mysql Client
未解决：mysql-workbench 经常出现sql 无法执行或者执行后却没有结果的情况。
目前手写，还可以。
如果找到其他合适的，再来这里更新。

####Chrome 
已解决：官网下载即可

#### 印象笔记
未解决：linux 下没有印象笔记的客户端，正在寻找替代方案。

####邮件
已解决:ubuntu 自带的邮件即可 (Evolution),需要去软件中心下载.


##提高效率

###好用的软件

####电脑上安装了那些软件
软件中心 --> ClassicMenu Indicator (经典菜单指示器)
安装完毕后打开,右上角就会出现一个白色的 ubuntu 标志,就像是 windows 左下角的启动一样灰常方便.

###Shell 脚本

####shell 基础
这个帖子不错:[Shell 十三问](http://bbs.chinaunix.net/thread-218853-1-1.html)

####免密码登录
已解决：使用 SSH 证书服务
步骤：
	- 本机与服务器都安装 ssh 服务： apt-get install ssh
	- 验证是否安装成功： ssh -V
	- 生成客户端公钥和私钥： ssh-keygen
	- 复制客户端公钥：vim ~/xxx_rsa.pub
	- 放到服务端信任文件中： vim ~/.ssh/authorized_keys
	- 更改 authorized_keys 文件的权限：chmod 600 authorized_keys
	- 执行链接即可： ssh -p22 root@xxx.xxx.xxx.xxx

参考链接：[Ubuntu 使用 SSH 免密码登录](http://jingyan.baidu.com/article/60ccbceb02bd4264cab197b9.html)

####远程连接、拷贝
使用上面的 免密码登录技能即可轻松实现。

```bash
scp ${file} ${service}:/data/work/tomcat/webapps/ROOT.war
```

####自动部署（发布到 tomcat 上，并重启 tomcat）
参见：publish31.sh
参见：publish33.sh

####查询数据库（查询任务完成量，并导出文件到本地）
参见:queryMysql.sh

####查看公网日志（打开多个 terminal 窗口）

####切换内外网 或 VPN

待解决


##常用命令
###搜索脚本的位置
which xx.sh 

###查看别名
alias

###公网目录
~/bin 运维脚本的位置
~/stat 统计脚本

###新增vpn路由分流工具
