#!/bin/bash

# backup file
mysqldump -h127.0.0.1 -uroot -pmysql57 faith > /root/MysqlData/faith-data/faith_data_backup.sql

# git push
git push -f origin master

echo "baskup finished"
