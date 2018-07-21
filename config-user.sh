#!/bin/bash
ippool=(1 5 9 13 17 21 25 29 33 37 41 45 49 53 57 61 65 69 73 77 81 85 89 93 97 101)
echo "输入增加用户的数量:"
read -p "(请输入大于0小于25的整数):" tempnum
num=${tempnum}
for ((i=1;i<=${num};i++ ));
do
    uname="user"$(cat /dev/urandom | head -1 | md5sum | head -c 8)
    passwd="key"$(cat /dev/urandom | head -1 | md5sum | head -c 8)
    echo "${uname} ${passwd}" >> psw-file
    ip1="10.8.0."${ippool[i]}
    ip2="10.8.0."$((ippool[i]+1))
    echo "${uname},$ip1,10G,100,open" >> traffic-limit
    iptables -n -v -L -t filter|grep $ip1 && ifhave=0 || ifhave=1
    if [$ifhave==1]; then
        iptables -A FORWARD -m limit -d ${ip1} --limit 200/sec -j ACCEPT
        iptables -A FORWARD -d ${ip1} -j DROP
    fi
    echo "ifconfig-push ${ip1} ${ip2}" > ./ccd/${uname}
done
service iptables save
