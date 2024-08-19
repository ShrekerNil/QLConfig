# MySQL安装

## Windows

### Zip安装

1. 下载
   - [MySQL :: Download MySQL Community Server (Archived Versions)](https://downloads.mysql.com/archives/community/)
   - https://cdn.mysql.com//Downloads/MySQLGUITools/mysql-workbench-community-8.0.32-winx64.msi

2. 解压到指定位置

   D:\Programs\DevEnv\MySql\mysql-5.7.40-winx64

3. 复制备份文件夹中的`my.ini`文件到MySQL根目录

   ```
   [mysql]
   # 设置mysql客户端默认字符集
   default-character-set=utf8
    
   [mysqld]
   # 设置3306端口
   port=3306
    
   # 设置mysql的安装目录
   basedir=D:\Programs\DevEnv\MySql\mysql-5.7.40-winx64
    
   # 设置 mysql数据库的数据的存放目录（MySQL8.0+ 不需要以下配置，系统自己生成即可，否则有可能报错）
   datadir=D:\Programs\DevEnv\MySql\mysql-5.7.40-winx64\data
    
   # 允许最大连接数
   max_connections=20
    
   # 服务端使用的字符集默认为8比特编码的latin1字符集
   character-set-server=utf8
    
   # 创建新表时将使用的默认存储引擎
   default-storage-engine=INNODB
   
   # 跳过密码验证
   # skip-grant-tables
   ```

4. CMD命令行到bin目录，运行以下命令

   ```bash
   mysqld -install
   mysqld --initialize-insecure --user=mysql
   
   net start mysql
   
   mysql -u root -p
   
   update mysql.user set authentication_string=password('<password>') where user='root' and host='localhost';
   flush privileges;
   exit
   ```

5. 删除/注释`my.ini`中的`skip-grant-tables`，表示不再跳过密码验证