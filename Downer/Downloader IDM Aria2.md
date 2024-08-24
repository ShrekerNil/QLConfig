# Downloader IDM Aria2

软件小妹配置：https://www.cnblogs.com/softxmm/p/13972678.html

原文：[【软件小妹】百度网盘简易下载助手（直链下载复活版）](https://www.cnblogs.com/softxmm/p/13972678.html)

**两个文件在备份盘的软件目录有备份**

## 大前提 

这是一个油猴脚本，安装脚本之前，必须先安装油猴浏览器扩展（如已安装则跳过）：
[【第一步】下载油猴](https://jzxw.vip/softxm/Tampermonkey.crx) --> 如有提示安装，则直接安装即可，否则继续执行第二步
[【第二步】安装油猴](https://chrome.zzzmh.cn/help?token=setup) --> 参考其中章节： *一、 拖动安装(推荐)*

## 安装下载器

### 方式一：IDM

*注：如果你已经有IDM了，那用你自己的就行了，无需下载我提供的版本*
**IDM下载**：https://wwx.lanzoux.com/b01nqc7yj
我提供的IDM是绿色版本，解压后，执行“!)绿化.bat”，就可以正常使用了。
**IDM配置**：

1. 选项→连接→默认最大连接数：**4线程**

2. 选项→下载→修改UA为 **netdisk;3.0.0.112**

   ```
   Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko
   ```

   

### 方式二：Aria2

*注：Aria2总会出现一些奇奇怪怪的问题，强烈建议使用IDM方式来下载。*
下载地址：https://wwx.lanzoux.com/b01nqc7yj
Aria2为绿色软件，解压后，打开“AriaNg启动器”，即可启动Aria2

必须确保页面上左侧**系统设置**的**Aria2状态**选项值为**已连接**，如果为**未连接**则托盘图表右键**重新载入**



## 安装“百度网盘简易下载助手”油猴脚本 

脚本安装地址：[安装地址一（推荐）](https://greasyfork.org/zh-CN/scripts/418182)   [安装地址二（备用）](https://files.cnblogs.com/files/softxmm/jyzs.user.js)
安装之后，打开百度网盘，即会发现多了一个红色按钮“简易下载助手”

## 下载文件

网盘页面，勾选文件，点击【简易下载助手】，弹出文件下载窗口。
下载窗口支持2种下载方式：
**1、复制直链地址：**复制后就可以到IDM中新建下载任务了
**2、发送至Aria2：**点击后直接发送至Aria2中进行下载（可以在Aria2中看到下载状态）