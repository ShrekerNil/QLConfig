#!/bin/bash
nohup java -Xdebug -Xrunjdwp:transport=dt_socket,address=5005,server=y,suspend=y -jar faith-0.0.1.jar >/root/projects/debug.log 2>&1 &
echo $! > /var/run/faith_debug.pid
