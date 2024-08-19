#!/bin/bash

BASE_SERVER=192.168.100.101

yum install -y openssh-clients;
yum install -y expect;
yum install -y wget

# Download jdk-8u201-linux-x64.tar.gz

echo ~~~~~~~~~~~~~~~~ Downloading jdk-8u201-linux-x64.tar.gz ~~~~~~~~~~~~~~~
wget $BASE_SERVER/jdk-8u201-linux-x64.tar.gz

echo ~~~~~~~~~~~~~~~ Decompressing jdk-8u201-linux-x64.tar.gz ~~~~~~~~~~~~~~
tar -zxf jdk-8u201-linux-x64.tar.gz -C /usr/local/

echo ~~~~~~~~~~~~~~~~~~~~~ Configuring jdk context path ~~~~~~~~~~~~~~~~~~~~
cat >> /etc/profile << EOF

# JDK Context
export JAVA_HOME=/usr/local/jdk1.8.0_201
export PATH=\$PATH:\$JAVA_HOME/bin

EOF

echo ~~~~~~~~~~~~~~~~~~~~~~~~~~ Refresh Environment ~~~~~~~~~~~~~~~~~~~~~~~~~
source /etc/profile

echo ~~~~~~~~~~~~~~~~~~~~~ Configuring host context path ~~~~~~~~~~~~~~~~~~~~
cat >> /etc/hosts << EOF
192.168.100.101    mini1
192.168.100.102    mini2
192.168.100.103    mini3
192.168.100.104    mini4
EOF
