# @Author:              Shreker
# @Date:                2023-09-05 09:21:47
# @Description:         初始化ZIP版本MongoDB的安装
# @Using:
#   1、将本文件拷贝至安装的根目录，直接运行即可
#   2、安装服务：
#       mongod --config "D:\Programs\Coding\MongoDB\bin\mongod.cfg" --install
#   3、启停服务
#       net start MongoDB
#       net stop MongoDB

mkdir -p ./data/{db,logs}

touch ./data/logs/mongodb.log

touch ./bin/mongod.cfg

cat>./bin/mongod.cfg<<EOF
systemLog:
    destination: file
    logAppend: true
    path: D:\Programs\Coding\MongoDB\data\logs\mongod.log
storage:
    dbPath: D:\Programs\Coding\MongoDB\data\db
EOF
