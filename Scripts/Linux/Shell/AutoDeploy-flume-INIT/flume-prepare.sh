#!/bin/bash
scp -r /Users/shrekernil/Desktop/prd-ali/flume-hdfs-opt/* root@172.20.23.249:/opt/
scp -r /Users/shrekernil/Desktop/prd-ali/flume-hdfs-conf/conf/* root@172.20.23.249:/usr/libra/flume/conf/
scp -r /Users/shrekernil/Desktop/prd-ali/flume-hdfs-conf/bin/* root@172.20.23.249:/usr/libra/flume/bin/
scp -r /Users/shrekernil/Desktop/prd-ali/flume-hdfs-libs/* root@172.20.23.249:/usr/libra/flume/lib/