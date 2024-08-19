#!/bin/bash
pid_file = "/var/run/faith.pid"

if [ ! -x $pid_file]; then
  echo 'Server not running'
else
  PID=$(cat /var/run/faith.pid)
  kill -9 $PID
  rm -f /var/run/faith.pid
fi
