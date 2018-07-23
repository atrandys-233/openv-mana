#查询当前流量并写入stat文件
iptables -n -v -L -t filter -x| awk '$3=="ACCEPT" && $9 ~ /10.8.0./ {print $9,$2}' > /etc/openvpn/stat

#stat数据与limit数据合并
awk  'FNR==NR{a[$1]=$2}NR>FNR{if($2 in a)print $1,$2,$3,a[$2]}' stat trafffic-limit >trafffic-now

#处理数据
awk '{if($4>$3){iptables -I FORWARD -d $2 -j DROP}}'
