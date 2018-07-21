#查询当前流量并写入stat文件
iptables -n -v -L -t filter -x| awk '$3=="ACCEPT" && $9 ~ /10.8.0./ {print $9,$2}' > /etc/openvpn/stat

#stat数据与limit数据对比，进行处理
