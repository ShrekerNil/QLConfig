#!/bin/bash

#获取ip地址
#ifconfig | grep "inet addr:" | gawk '{print $2}' | sed 's/addr://g'

#获取掩码
#ifconfig | grep "Mask" | gawk '{print $4}' | sed 's/Mask://g'

#修改ip地址
#ifconfig eth0 192.168.0.20 netmask 255.255.255.0
#修改/etc/sysconfig/network-scripts/ifcfg-eth0

#修改默认网关
#route add default gw 192.168.0.254
#修改/etc/sysconfig/network-scripts/ifcfg-eth0

#修改NDS地址
#修改/etc/resolv.conf文件

#修改host name
#hostname zbc
#修改/etc/sysconfig/network文件

echo "********这是一个查看网络信息的脚本报告***********"
echo ""

NETWORK_TYPE=$(ifconfig | grep "Link" | gawk '{print $1}')
NETMASK=$(ifconfig | grep "Mask" | gawk '{print $4}' | sed 's/Mask://g')
IPADDR=$(ifconfig | grep "inet addr:" | gawk '{print $2}' | sed 's/addr://g')
HWADDR=$(ifconfig | grep "HWaddr" | gawk '{print $5}')
NAME_SERVER=$(cat /etc/resolv.conf | grep "nameserver" | gawk '{print $2}')

count=1

for network_type in $NETWORK_TYPE; do
  eval NETWORK_TYPE_$count=$(echo $network_type) 2>/dev/null
  count=$(($count + 1))
done

count=1
for netmask in $NETMASK; do
  eval NETMASK_$count=$(echo $netmask) 2>/dev/null
  count=$(($count + 1))
done

count=1
for ipaddr in $IPADDR; do
  eval IPADDR_$count=$(echo $ipaddr) 2>/dev/null
  #a=`echo "IPADDR_$count"`
  #echo "$a"
  #$a=`echo $ipaddr` 2>/dev/null
  #echo "$(IPADDR_$count)"
  count=$(($count + 1))
done

count=1
for hwaddr in $HWADDR; do
  eval HWADDR_$count=$(echo $hwaddr) 2>/dev/null
  count=$(($count + 1))
done

for parm in 1 2 3; do
  #a=`echo "NETWORK_TYPE_$parm"`
  #eval echo "$"$a""
  eval echo "网络类型：$"NETWORK_TYPE_$parm""
  eval echo "IP地址：$"IPADDR_$parm""
  eval echo "子网掩码：$"NETMASK_$parm""
  eval echo "物理地址：$"HWADDR_$parm""
  echo "DNS地址：$NAME_SERVER"
  echo ""
done
#echo "$NETWORK_TYPE_1"
#a=asd
#eval $a=4
#eval echo $[ $a ]
#echo $asd

#修改网络信息
str1=''
vco=$(expr length "$str1")

echo ">>>>>>>>>>>>你是否需要修改网络信息？请回答y或者n"
read ANSWER

ANSWER=$(echo $ANSWER | tr [A-Z] [a-z])
if [ $ANSWER = "y" ]; then
  answer=0
elif [ $ANSWER = "n" ]; then
  answer=1
else
  echo "》》》》》输入不合法，请退出重试"
  exit 1
fi

if [ $answer -eq 0 ]; then

  echo "请问是需要即时生效（1）还是永久生效（2）？回答相应数字即可"
  read RESULT

  if [ $RESULT -eq 1 ] 2>/dev/null; then
    echo "请给出需要修改的网络类型：eth0或者eth1"
    read nettype_sed1

    if [ $nettype_sed1 = "eth0" ] || [ $nettype_sed1 = "eth1" ] 2>/dev/null; then
      echo "IP地址："
      read ipaddr_sed1
      var_ip=$(echo "$ipaddr_sed1" | gawk --re-interval '/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/{print $0}')
      vio=$(expr length "$var_ip")
      if [ $vio -ne $vco ]; then
        echo "子网掩码："
        read netmask_sed1
        var_mask=$(echo "$netmask_sed1" | gawk --re-interval '/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/{print $0}')
        vmo=$(expr length "$var_mask")
        if [ $vmo -ne $vco ]; then
          echo "DNS地址："
          read dns_sed1
          var_dns=$(echo "$dns_sed1" | gawk --re-interval '/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/{print $0}')
          vdo=$(expr length "$var_dns")
          if [ $vdo -ne $vco ]; then

            #即时性修改网络信息"

            #修改IP地址与掩码
            ifconfig eth0 $ipaddr_sed1 $netmask_sed1 2>/dev/null
            echo "IP地址与掩码修改完成！"
            #return 0
            #if [ $? -eq 0 ];then
            #       echo "IP地址与掩码修改完成！"
            #else
            #       echo "IP地址与掩码修改失败！"
            #fi

            #修改DNS地址
            #sed -i '/nameserver/c\nameserver 8.8.8.8' /etc/resolv.conf
            echo "nameserver $dns_sed1" >>/etc/resolv.conf
            if [ $? -eq 0 ]; then
              echo "DNS修改完成！"
            else
              echo "DNS修改失败！"
            fi

            #echo "1"
          else
            echo "你输入的DNS地址格式不正确，请退出重新输入！"
          fi
        else
          echo "你输入的子网掩码格式不正确，请退出重新输入！"
        fi
      else
        echo "输入的IP格式不正确！请退出重新输入"
      fi
    else
      echo "输入不合法，即将退出！"
      exit 1
    fi

  elif
    [ $RESULT -eq 2 ] 2>/dev/null
  then
    echo "1"
    echo "请给出需要修改的网络类型：eth0或者eth1"
    read nettype_sed1

    if [ $nettype_sed1 = "eth0" ] || [ $nettype_sed1 = "eth1" ] 2>/dev/null; then
      echo "IP地址："
      read ipaddr_sed1
      var_ip=$(echo "$ipaddr_sed1" | gawk --re-interval '/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/{print $0}')
      vio=$(expr length "$var_ip")
      if [ $vio -ne $vco ]; then
        echo "子网掩码："
        read netmask_sed1
        var_mask=$(echo "$netmask_sed1" | gawk --re-interval '/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/{print $0}')
        vmo=$(expr length "$var_mask")
        if [ $vmo -ne $vco ]; then
          echo "DNS地址："
          read dns_sed1
          var_dns=$(echo "$dns_sed1" | gawk --re-interval '/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/{print $0}')
          vdo=$(expr length "$var_dns")
          if [ $vdo -ne $vco ]; then
            #永久性修改网络信息
            echo "1"
          else
            echo "你输入的DNS地址格式不正确，请退出重新输入！"
          fi
        else
          echo "你输入的子网掩码格式不正确，请退出重新输入！"
        fi
      else
        echo "输入的IP格式不正确！请退出重新输入"
      fi
    else
      echo "输入不合法，即将退出！"
      exit 1

    fi
  else
    echo "输入不合法，即将退出！"
    exit 1
  fi
else
  echo "脚本结束！"
fi
