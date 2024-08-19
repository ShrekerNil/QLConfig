#!/bin/bash

SERVERS="192.168.100.101 192.168.100.102 192.168.100.103 192.168.100.104"
PASSWORD=centos610
#BASE_SERVER=192.168.100.101

config_ssh_auto_login() {
    expect -c "set timeout -1;
        spawn ssh-copy-id $1;
        expect {
            *(yes/no)* { send -- yes\r; exp_continue; }
            *password:* { send -- $2\r; exp_continue; }
            eof {exit 0;}
        }"
}

config_ssh_auto_login_batch() {
    echo "~~~~~~~~~~~~~~ Starting ssh-copy-id ~~~~~~~~~~~~~~"
    for SERVER in $SERVERS; do
        config_ssh_auto_login $SERVER $PASSWORD
    done
}

config_local_env() {
    yum install -y openssh-clients
    yum install -y expect
}

config_remote_openssh_clients() {
    for SERVER in $SERVERS; do
        expect -c "set timeout -1;
            spawn ssh root@$SERVER yum install -y openssh-clients;
            expect {
                *password:* { send -- $PASSWORD\r; exp_continue; }
                *(yes/no)* { send -- yes\r; exp_continue; }
                eof        {exit 0;}
            }"
    done
}

make_rsa_key() {
    expect -c "set timeout -1;
        spawn ssh-keygen;
        expect {
            */.ssh/id_rsa* { send -- \r; exp_continue; }
            *empty* { send -- \r; exp_continue; }
            *again* { send -- \r; exp_continue; }
            eof        {exit 0;}
        }"
}

echo "~~~~~~~~~~~~~~~~ config local environment ~~~~~~~~~~~~~~~"
config_local_env

echo "~~~~~~~~~~~~~ config remote openssh-clients ~~~~~~~~~~~~~"
config_remote_openssh_clients

echo "~~~~~~~~~~~~~ make rsa key ~~~~~~~~~~~~~"
make_rsa_key

echo "~~~~~~~~~~~~~~~~~ config ssh auto login ~~~~~~~~~~~~~~~~~"
config_ssh_auto_login_batch

#echo "~~~~~~~~~~~~~~ copy and execute install.sh ~~~~~~~~~~~~~~"
#for SERVER in $SERVERS
#do
#    ssh root@$SERVER mkdir /root/scripts
#    scp install.sh root@$SERVER:/root/scripts
#    ssh root@$SERVER /root/scripts/install.sh
#done
