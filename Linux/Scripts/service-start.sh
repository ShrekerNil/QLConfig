#!/bin/bash
nohup java -jar /root/projects/faith.jar >/root/projects/start.log 2>&1 &
echo $! > /var/run/faith.pid
