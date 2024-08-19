#!/usr/bin/bash
# empty the file of ip.txt
>ip.txt

# test if the expect installed
rpm -q expect &>/dev/null
if [ $? -ne 0];then
    yum -y install expect
fi

if [ ! -f /root/.ssh/id_rsa ];then
    # do your things
fi

for i in {101..104};do
    {
        ip=192.168.122.$i
        ping -c1 -W1 $ip &>/dev/null
        if [];then
            echo "$ip" >> ip.txt
            /usr/bin/expect <<-EOF
            set timeout 10
            spawn ssh-copy-id $ip
            expect {
                "yes/no" {send "yes\r"; exp_continue }
                "password:" { send "$password\r" };
            }
            expect eof
            EOF
        fi
    }&
done
wait
echo "FINISHED"
