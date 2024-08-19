#!/usr/bin/bash
spawn ssh root@<ip>

expect {
    "yes/no" {send "yes\r"; exp_continue }
    "password:" { send "<password>\r" };
}
interact
