#!/usr/bin/bash
#set ip 192.168.100.101
set ip [lindex $argv 0]
set user [lindex $argv 1]
set password [lindex $argv 2]
set timeout 5

spawn ssh root@$ip

expect {
    "yes/no" {send "yes\r"; exp_continue }
    "password:" { send "$password\r" };
}
#interact
expect "#"
send "useradd niceboy\r"
send "exit\r"
# end the expect program
expect eof