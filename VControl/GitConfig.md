# Git配置

## 本地多远程

> 参考我的简书: [[Git\]单机多点远程Git仓库 - 简书 (jianshu.com)](https://www.jianshu.com/p/fadad5b98540)

### 创建多个密钥对

bash切换到.ssh目录下, 执行以下命令

```sh
ssh-keygen -t rsa -C "SSH_GITEE_COMMON_HOME" -f "id_rsa_gitee_common_home"
ssh-keygen -t rsa -C "SSH_GITHUB_COMMON_HOME" -f "id_rsa_github_common_home"
```

### 配置config文件

```
# Config GitEE
Host gitee.com
HostName gitee.com
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa_gitee_common_home

# Config GitHub
Host github.com
HostName github.com
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa_github_common_home
```

### 配置ssh-agent

专用密钥添加到ssh-agent的高速缓存中

```sh
ssh-add ./id_rsa_gitee_common_home
ssh-add ./id_rsa_github_common_home
```

### 测试

```sh
ssh -T git@gitee.com
ssh -T git@github.com
```

输入y即可