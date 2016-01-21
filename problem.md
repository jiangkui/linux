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
[vpn 分流](https://github.com/jimmyxu/chnroutes)
原计划自己写一个的,但状态不佳,尚未完全研究明白...

###jvm 性能监控与故障处理工具
####Java 提供了 6 种命令行工具：（没有技术支持并且是实验性质的）
- jps：虚拟机进程状况工具
- jstat：虚拟机统计信息监视工具
- jinfo：Java 配置信息工具
- jmap：Java 内存映像工具
- jhat：虚拟机堆转储快照分析工具
- jstack：Java 堆栈跟踪工具 
    - 用于生成虚拟机当前时刻的线程快照
    - 线程快照就是当前虚拟机每一条线程正在执行的方法堆栈的集合
    - 目的：定位线程出现长时间停顿的原因，如：线程间死锁、死循环、请求外部资源导致的长时间等待等都是导致线程长时间等待的常见原因。
- HSDIS（Sun官方推荐的反汇编插件）：JIT 生成代码反汇编

####JDK 的可视化工具：（正式成员）
- JConsole：Java 监视与管理控制台
- VisualVm：多合一故障处理工具

####研究 VisualVm 的使用
安装 screen：yum install screen
正在研究中。。。

[解决方案：](http://ihuangweiwei.iteye.com/blog/1219302)

继续研究visualVm,看看自己的阿里云有啥问题,为啥 剩余的60m内存,一直不使用,反而是到了50m 的时候就强制gc了.
[Java 内存区域和GC机制](http://www.cnblogs.com/zhguang/p/3257367.html)
###Java内存区域:
- 栈区（JVM Stack）：存储基本数据类型，refrence。
    - 虚拟机栈：
    - 本地方法栈：
- 堆区(Heap)：存储对象实力,原则上,所有的对象在堆区上分配内存.
- 方法区(Method Area)：存储已经被虚拟机加载的类信息(版本,field,方法,接口等)、final常量、静态变量、编译器即时编译的代码等。
- 程序计数器：一个线程一个程序计数器（线程私有）

###各个区域的内存溢出
- **程序计数器：**此处是JVM 唯一一个没有定义 OutOfMemoryError 的区域
- **栈区：**线程调用的栈深度大于虚拟机允许的最大深度，则抛出 StackOverFlowError（栈溢出），如果 Java虚拟机允许动态扩展虚拟机栈的大小，线程就可以一直申请栈，直到内存不足，此时会抛出 OutOfMemoryError（内存溢出）
- **堆区：**在执行垃圾回收之后，扔没有足够的内存分配，也不能再扩展，则会抛出 OutOfMemoryError：Java heap space 异常
- **方法区（Permanent Generation space）：**定义了 OutOfMemoryError:PermGen space异常，在内存不足时抛出。
- **直接内存：**也可能抛出 OutOfMemoryError 异常。

**关于 refrence ，实现方式有两种：**
    - 句柄：Java Heap 中会划分出 句柄池，refrence 存储对象的句柄地址，句柄存储对象实例、class 的地址信息（优点：对象变化时只需要更新句柄即可，稳定）
    - 指针：refrence 直接存储对象的地址，对象中在存储其Class的地址。（优点：快）
    - 虚拟机使用的是指针。

**分代分配，分代回收。**
###Java 内存分配机制
根据对象存活时间被分为：
- 年轻代：对象被创建时，内存的分配首先发生在年轻代（大对象可以直接被创建在老年代）
    - Eden区（伊甸园）：内存首次分配的区域，大多数刚创建的对象会放到这里
    - Survivor 0、 1（存活区）：两个存活区
- 老年代：gc 达到一定次数后依然存活的对象，则进入老年代。
- 永久代（方法区）：可以选择是否执行垃圾收集，一般的，方法区上执行垃圾收集是很少的，这也是方法区被称为永久代的原因之一。方法区上进行垃圾收集，条件苛刻而且相当困难，效果也不令人满意，所以一般的不做太多考虑。

###垃圾收集器
####新生代收集器
- **Serial收集器：**使用停止复制算法，一个线程进行GC，串行，其他线程暂停。<span style="color: #2d4fc9;">使用-XX:+UseSerialGC可以使用Serial+Serial Old模式运行进行内存回收（这也是虚拟机在Client模式下运行的默认值）</span>
- **ParNew收集器：**使用停止复制算法，Serial收集器的多线程版，用多个线程进行GC，并行，其它工作线程暂停，关注缩短垃圾收集时间。<span style="color: #2d4fc9;">使用-XX:+UseParNewGC开关来控制使用ParNew+Serial Old收集器组合收集内存；使用-XX:ParallelGCThreads来设置执行内存回收的线程数。</span>
- **Parallel Scavenge 收集器：**停止复制算法，关注CPU吞吐量，能高效利用CPU。
#### 老年代收集器
- **Serial Old 收集器：**单线程，串行，使用标记整理（整理的方法：清理和压缩）
    - 清理：干掉废弃的对象
    - 压缩：将剩下的对象移动到一起，保证内存分为2块，一块全是对象，一块空闲
- **Parallel Old 收集器：**多线程，并行，使用标记整理（整理的方法：汇总和压缩），在多核计算中很有用。
    - 汇总：将幸存的对象复制到预先准备好的区域，而不是先清理废弃的对象。
- **CMS（Concurrent Mark Sweep）收集器：**致力于最短回收停顿时间，使用标记清楚算法，多线程，并发收集（用户线程和GC线程同时工作）
    - 执行过程：初始标记-->并发标记-->预清理-->可控预清理-->重新标记-->并发清除-->并发重设状态等待下次CMS

并发和并行的区别：
**并发**是指用户线程与GC线程同时执行，不需要停顿用户线程（其实在CMS中用户线程还是要停顿的，只是非常短）
**并行**收集是指多个GC线程并行工作，此时用户线程是暂停的。
Serial是串行的，Parallel收集器是并行的，而CMS收集器是并发的。

继续研究Java虚拟机
