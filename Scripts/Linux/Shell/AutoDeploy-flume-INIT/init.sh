#!/bin/sh

# 1. transport jdk & flume package to /opt in host machine
# 2. exec init.sh script
# 3. copy conf properties / start script /configure file to corresponding directory
# 4. execute start script

#HOSTNAME=txdev-flume
HOSTNAME=dev-flume
#HOSTNAME=pre-flume
#HOSTNAME=prd-flume

echo "~~~~~~~~~~~~~~~~~~~~~ Configuring HostName ~~~~~~~~~~~~~~~~~~~~"
sed -i "s/VM.*centos/$HOSTNAME/" /etc/sysconfig/network
hostname $HOSTNAME

echo "~~~~~~~~~~~~~~~ Install jdk-8u121-linux-x64.tar.gz ~~~~~~~~~~~~~~"
mkdir /usr/java/
cd /opt/
tar -zxvf ./jdk-8u121-linux-x64.tar.gz -C /usr/java/

echo "~~~~~~~~~~~~~~~~~~~~~ Configuring jdk Context ~~~~~~~~~~~~~~~~~~~~"
cat >> /etc/profile << EOF

# JDK Context
export JAVA_HOME=/usr/java/jdk1.8.0_121
export PATH=\$PATH:\$JAVA_HOME/bin

EOF

echo "~~~~~~~~~~~~~~~~~~~~~ Install Flume ~~~~~~~~~~~~~~~~~~~~"
mkdir /usr/libra/
cd /opt/
tar -zxvf ./apache-flume-1.7.0-bin.tar.gz -C /usr/libra/
cd /usr/libra/
mv ./apache-flume-1.7.0-bin ./flume
mkdir -p /usr/libra/flume/logs/

echo "~~~~~~~~~~~~~~~~~~~~~ Configuring Flume Context ~~~~~~~~~~~~~~~~~~~~"
cat >> /etc/profile << EOF

# Flume Context
export FLUME_HOME=/usr/libra/flume
export PATH=\$PATH:\$FLUME_HOME/bin

EOF

echo "~~~~~~~~~~~~~~~~~~~~~ Source Profile ~~~~~~~~~~~~~~~~~~~~"
source /etc/profile

echo "~~~~~~~~~~~~~~~~~~~~~ Configuring Hosts ~~~~~~~~~~~~~~~~~~~~"
cat >> /etc/hosts << EOF
#tx dev
172.25.48.163  db3.statis.txdev
172.25.48.146  db2.statis.txdev
172.25.48.122  db1.statis.txdev
172.25.48.76  cdh.statis.txdev

#dev
172.20.11.71 cdh.dev.xylink
172.20.11.68 king1.dev.xylink
172.20.11.69 king2.dev.xylink
172.20.11.70 king3.dev.xylink

#prd cdh
172.20.23.222 king1
172.18.32.94 king2
172.20.23.220 knight1
172.20.23.56 cdh

# txdev kafka
172.25.48.176 VM_48_176_centos

# dev kafka
172.20.11.94 dev-kafka3
172.20.11.93 dev-kafka2
172.20.11.92 dev-kafka1

#pre kafka
172.18.160.68 pre-kafka1
172.18.160.69 pre-kafka2
172.18.160.67 pre-kafka3

EOF

# copy dependency libs

# config Xmx Xms

