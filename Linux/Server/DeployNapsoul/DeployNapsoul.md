# Deploy Napsoul

## 说明

参考项目：[DeployNapSoul](https://gitee.com/ShrekerNil/DeployNapSoul)

## 部署

```
apt install -y unzip
unzip DeployNapSoul.zip
cd DeployNapSoul
bash ./deploy1_docker.sh
bash ./deploy2_napsoul.sh
```

## 问题

### 脚本突然停止执行

[Shell脚本突然停止工作 | (1r1g.com)](https://qa.1r1g.com/sf/ask/1240457851/)

你的`bash`脚本看起来很好,我相信这是你调用它的方式.`sh`并且`bash`是不同的壳.尝试像这样运行:

```
sudo ./backup.sh
```

要么

```
sudo bash ./backup.sh
```

代替

```
sudo sh ./backup.sh
```