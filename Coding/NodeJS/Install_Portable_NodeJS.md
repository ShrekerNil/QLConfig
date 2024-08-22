# 安装解压版NodeJS

## 安装过程

### 解压到要安装的位置

### 配置全局文件夹

根目录创建node-cache和node-global

执行设置命令

```cmd
npm config set cache "D:\Programs\DevEnv\NodeJS\node-cache"
npm config set prefix "D:\Programs\DevEnv\NodeJS\node-global"
```

### 配置环境变量

1. 添加根目录 NODE_HOME
2. 添加Path`%NODE_HOME%`和`%NODE_HOME%\node-global`

## 配置

### 配置淘宝镜像

```cmd
npm install -g cnpm --registry=https://registry.npm.taobao.org
npm config -g set registry https://registry.npm.taobao.org
```

