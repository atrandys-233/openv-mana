#!/bin/bash
echo "输入增加用户的数量:"
read -p "(请输入大于0的整数):" tempnum
num=${tempnum}
for ((i=1;i<=${num};i++ ));
do
       uname=$(cat /dev/urandom | head -1 | md5sum | head -c 8)
       echo "${uname} suansuanru.site" >> psw-file
done
