#!/bin/bash
# from: https://www.cnblogs.com/SimpleWu/p/14561276.html
cd `dirname $0`

# disable selinux
setenforce 0
sed -i '/SELINUX/s/enforcing/disabled/g' /etc/selinux/config

# disable NetworkManager
systemctl stop NetworkManager
systemctl disable NetworkManager

# update log lvel
#sed -i 's/\#LogLevel=info/LogLevel=notice/g' /etc/systemd/system.conf
#systemctl daemon-reexec

# config ssh
sed -i -e "/GSSAPIAuthentication/s/yes/no/g" -e "/GSSAPICleanupCredentials/s/yes/no/g" -e"s/^#UseDNS\ no/UseDNS\ no/" -e"s/^#UseDNS\ yes/UseDNS\ no/" /etc/ssh/sshd_config
echo -ne "ClientAliveInterval 60\nClientAliveCountMax 10" >> /etc/ssh/sshd_config
systemctl restart sshd

cat >> /etc/ssh/ssh_config <<'EOF'
Host *
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
EOF

# 阿里源
rm -f /etc/yum.repos.d/CentOS-Base.repo
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

# 阿里epel源
rm -f /etc/yum.repos.d/epel.repo
rm -f /etc/yum.repos.d/epel-testing.repo
curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo

# 安装软件
yum clean all
yum update -y
yum install -y iptables-services vim wget net-tools iperf3 telnet lvm2 tree screen tmux rsync lrzsz zip unzip xz ntpdate zlib sysstat hdparm htop iotop iftop dstat nmap mtr mlocate bind-utils ipmitool pciutils parted acpid man bash-completion* lsof bc ncdu

systemctl start acpid && systemctl enable acpid
systemctl stop firewalld && systemctl disable firewalld
# iptables设置
iptables -F
service iptables save
systemctl enable iptables

chmod +x /etc/rc.d/rc.local

# custom
cat >> /etc/bashrc <<'EOF'
export PATH=/usr/local/bin:$PATH
export TERM=xterm-256color
export EDITOR=/usr/bin/vim
# man page
export LESS_TERMCAP_mb=$(printf '\e[01;31m')
export LESS_TERMCAP_md=$(printf '\e[01;35m')
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_so=$(printf '\e[1;31;46m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_us=$(printf '\e[04;36m')
# history tune
shopt -s histappend
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
export PROMPT_COMMAND="history -a"
# PS1
export PS1="\[\e[36m\]\u\[\e[m\]\[\e[37m\]@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\\$ "
EOF

# 抑制systemd session的log
echo 'if $programname == "systemd" and ($msg contains "Starting Session" or $msg contains "Started Session" or $msg contains "Created slice" or $msg contains "Starting user-" or $msg contains "Starting User Slice of" or $msg contains "Removed session" or $msg contains "Removed slice User Slice of" or $msg contains "Stopping User Slice of") then stop' > /etc/rsyslog.d/ignore-systemd-session-slice.conf
systemctl restart rsyslog.service

# vim
cat >> /etc/vimrc <<'EOF'
set ts=4
set paste
set encoding=utf-8
set nocompatible
syntax on
EOF

# 禁用ipv6
cat >> /etc/sysctl.d/99-sysctl.conf <<'EOF'
# disable ipv6
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF

# 优化
cat >> /etc/sysctl.conf <<'EOF'
sunrpc.tcp_slot_table_entries = 128
net.core.rmem_default = 4194304
net.core.wmem_default = 4194304
net.core.rmem_max = 4194304
net.core.wmem_max = 4194304
net.ipv4.tcp_rmem = 4096 1048576 4194304
net.ipv4.tcp_wmem = 4096 1048576 4194304
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_syncookies = 1
net.core.netdev_max_backlog = 300000
vm.swappiness = 0
EOF

sysctl -p

# ulimit 相关
cat > /etc/security/limits.d/20-nproc.conf <<'EOF'
# Default limit for number of user's processes to prevent
# accidental fork bombs.
# See rhbz #432903 for reasoning.

# nproc
root       soft    nproc     unlimited
root       hard    nproc     unlimited
*          hard    nproc     65535
*          soft    nproc     65535
# nofile
*          soft    nofile     65535
*          hard    nofile     65535
EOF

# 修改systemd系统ulimit
cat >> /etc/systemd/system.conf <<'EOF'
DefaultLimitCORE=infinity
DefaultLimitNOFILE=100000
DefaultLimitNPROC=100000
EOF

# 修改systemd用户ulimit
cat >>  /etc/systemd/user.conf <<'EOF'
DefaultLimitCORE=infinity
DefaultLimitNOFILE=100000
DefaultLimitNPROC=100000
EOF

#关闭swap分区
swapoff -a

systemctl daemon-reload