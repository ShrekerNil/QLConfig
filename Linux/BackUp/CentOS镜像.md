# CentOS镜像

> 源文章：http://a.aliyun.com/f1.KrkzV

## 简介

CentOS，是基于 Red Hat Linux 提供的可自由使用源代码的企业级 Linux 发行版本；是一个稳定，可预测，可管理和可复制的免费企业级计算平台。

下载地址: https://mirrors.aliyun.com/centos/
https://mirrors.aliyun.com/centos-vault/

## 配置方法

> **通知：CentOS 8操作系统版本结束了生命周期（EOL），Linux社区已不再维护该操作系统版本。建议您切换到Anolis或Alinux。如果您的业务过渡期仍需要使用CentOS 8系统中的一些安装包，请根据下文切换CentOS 8的源。**

### 1. 备份

```
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
```

### 2. 下载新的 CentOS-Base.repo 到 /etc/yum.repos.d/

##### centos8（centos8官方源已下线，建议切换centos-vault源）

```
wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-vault-8.5.2111.repo
```

或者

```
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-vault-8.5.2111.repo
```

**centos6（centos6官方源已下线，建议切换centos-vault源）**

```
wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-vault-6.10.repo
```

或者

```
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-vault-6.10.repo
```

**CentOS 7**

```
wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
```

或者

```
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
```

### 3. 运行 yum makecache 生成缓存

### 4. 其他

非阿里云ECS用户会出现 Couldn't resolve host 'mirrors.cloud.aliyuncs.com' 信息，不影响使用。用户也可自行修改相关配置: eg:

```
sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo
```



## CentOS 8 结束生命周期如何切换源

### 公网用户：

```
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-vault-8.5.2111.repo
yum clean all && yum makecache
```

### 阿里云ecs用户：

```
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-vault-8.5.2111.repo
sed -i 's/mirrors.cloud.aliyuncs.com/url_tmp/g' /etc/yum.repos.d/CentOS-Base.repo && sed -i 's/mirrors.aliyun.com/mirrors.cloud.aliyuncs.com/g' /etc/yum.repos.d/CentOS-Base.repo && sed -i 's/url_tmp/mirrors.aliyun.com/g' /etc/yum.repos.d/CentOS-Base.repo
yum clean all && yum makecache
```



## 相关链接

- 官方主页: http://www.centos.org/
- 邮件列表: https://wiki.centos.org/GettingHelp/ListInfo
- 论坛: https://forums.centos.org/
- 文档: http://www.centos.org/docs/
- Wiki: http://wiki.centos.org/

## 评论

[1698004264309976](https://developer.aliyun.com/profile/n2ab7idhw7y7a)
2022-03-03

这帖是满分的坑，最后还是要根据 https://help.aliyun.com/document_detail/405635.html 这里的操作执行成功

---

[游客ekygkqgzke27u](https://developer.aliyun.com/profile/ekygkqgzke27u)
2022-02-21

确实坑，花了半小时找解决方案，社区文档里的都过期了。。。

2

[游客g6rxat57zazni](https://developer.aliyun.com/profile/g6rxat57zazni)

2022-02-25

@3iakz3vvkvroc 这个地址操作可以，给力！！



[3iakz3vvkvroc](https://developer.aliyun.com/profile/3iakz3vvkvroc)

2022-02-22

目前centos8源配置已更新，可以根据以下文档进行操作： https://help.aliyun.com/document_detail/405635.html