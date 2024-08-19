#!/bin/bash

. /etc/profile
. /root/.bash_profile

NOW=$(date +%Y-%m-%d-%H:%M)
CUR_FOLDER=$(
  cd $(dirname $0)
  pwd
)
LOG_FILE=$(CUR_FOLDER)/faith_backup.log

echo "~~~~~~~~~~~~~ $(NOW) ~~~~~~~~~~~~~" >>$LOG_FILE

mysqldump -h127.0.0.1 -uroot -pmysql57 faith >/root/MysqlData/faith-data/faith_data_backup.sql
if [ $? == 0 ]; then
  echo "DUMP SUCCEEDED!" >>$LOG_FILE
  cd /root/MysqlData/faith-data/
  git add ./
  git commit -m "... AUTO COMMIT ..." >>$LOG_FILE
  git push -f origin master
  echo "BASKUP FINISHED ..." >>$LOG_FILE
else
  echo "BACKUP FAILED!" >>$LOG_FILE
fi

