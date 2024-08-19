#!/bin/bash

# 确定当前文件夹中含有node.exe

# 创建两个文件夹
mkdir node-cache node-global

# 配置这两个文件夹
npm config set cache "D:\Programs\DevEnv\NodeJS\node-cache"
npm config set prefix "D:\Programs\DevEnv\NodeJS\node-global"

# 环境变量中添加NODE_HOME

# 添加系统环境变量Path: `%NODE_HOME% 和 %NODE_HOME%\node-global
