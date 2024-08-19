# 仓库体积过大，如何减小？

[仓库体积过大，如何减小？](https://gitee.com/help/articles/4232#article-header0)

[腾讯云-Git中文开发手册](https://cloud.tencent.com/developer/doc/1096)

[仓库体积](https://gitee.com/help/labels/133) [减少空间](https://gitee.com/help/labels/134) [git rebase](https://gitee.com/help/labels/135)

## 概述

Gitee 平台目前对仓库的配额如下：

| 套餐   | 免费版      | 基础版      | 标准版      | 高级版      | 尊享版      |
| ------ | ----------- | ----------- | ----------- | ----------- | ----------- |
| 单仓库 | 最大 500 MB | 最大 1 GB   | 最大 1 GB   | 最大 2 GB   | 最大 3 GB   |
| 单文件 | 最大 50 MB  | 最大 100 MB | 最大 100 MB | 最大 200 MB | 最大 300 MB |

如用户在使用过程中不小心将较大的二进制文件加入仓库，那么仓库大小很快就会超过规定的配额，用户可以通过升级到对应的套餐配额或对仓库进行历史改写瘦身，来解除系统对仓库推拉服务的锁定。

- 套餐升级可访问：https://gitee.com/enterprises 了解
- 仓库瘦身方案见下方：

## 查看存储库中的大文件

```
git rev-list --objects --all | grep -E `git verify-pack -v .git/objects/pack/*.idx | sort -k 3 -n | tail -10 | awk '{print$1}' | sed ':a;N;$!ba;s/\n/|/g'`
```

或

```
git rev-list --objects --all | grep "$(git verify-pack -v .git/objects/pack/*.idx | sort -k 3 -n | tail -15 | awk '{print$1}')"
```

发现报错：

```sh
Shreker@ShrekerNil MINGW64 /d/GitRepo/GitEE/QLSummary/QLNotes (master)
$ git rev-list --objects --all | grep -E `git verify-pack -v .git/objects/pack/*.idx | sort -k 3 -n | tail -10 | awk '{print$1}' | sed ':a;N;$!ba;s/\n/|/g'`
fatal: Cannot open existing pack file '.git/objects/pack/*.idx'
========================================================================================
Shreker@ShrekerNil MINGW64 /d/GitRepo/GitEE/QLSummary/QLNotes (master)
$ git rev-list --objects --all | grep "$(git verify-pack -v .git/objects/pack/*.idx | sort -k 3 -n | tail -15 | awk '{print$1}')"
fatal: Cannot open existing pack file '.git/objects/pack/*.idx'
```

解决方案：[**.git文件过大解决**](https://blog.51cto.com/fan0128/2538758?source=dra)

```sh
git gc
```



## 改写历史，去除大文件

> 注意：下方命令中的 `path/to/large/files` 是大文件所在的路径，千万不要弄错！

```sh
git filter-branch --tree-filter 'rm -f path/to/large/files' --tag-name-filter cat -- --all
git push origin --tags --force
git push origin --all --force
```

如果在 `git filter-branch` 操作过程中遇到如下提示，需要在 `git filter-branch` 后面加上参数 `-f`

```
Cannot create a new backup.
A previous backup already exists in refs/original/
Force overwriting the backup with -f
```

并告知所有组员，push 代码前需要 pull rebase，而不是 merge，否则会从该组员的本地仓库再次引入到远程库中，导致仓库在此被 Gitee 系统屏蔽。

更加具体的操作可以点击文章 [改写历史，永久删除git库的物理文件](https://my.oschina.net/jfinal/blog/215624?fromerr=ZTZ6c38X) 查看

------

## Gitee 存储库体积控制策略

Gitee 已将服务端的钩子切换到 GNK (Gitee Native Hook)，GNK 基于 C++ 编写，使用了 Git 环境隔离等高级特定，意味着大文件检测和存储库体积检测不会再有漏网之鱼。一些用户的存储库体积已经超过了 Gitee 配额限制，而之前的钩子检测存在缺陷，无法实时拦截大存储库和大文件，当切换到 GNK 后，这些用户修改他们的存储库却无法推送到 Gitee，这让他们产生了困扰。

《Gitee 存储库体积控制策略》就这一困扰解答若干问题，详情请见：https://my.oschina.net/GIIoOS/blog/3126211

一些工具
https://github.com/newren/git-filter-repo
https://rtyley.github.io/bfg-repo-cleaner/
https://git-scm.com/docs/git-filter-branch