#!/bin/sh

dtday=`date +'%Y%m%d'`
dt=`date +'%Y%m%d%H%M%S'`
old_ip_file=/opt/scripts/ip/ip.txt
new_ip_file=/opt/scripts/ip/ip.$dt

rm /opt/scripts/ip/ip.$dtday*
wget 10.10.82.149/ip.txt -O $new_ip_file

old_ip_size=`du -b $old_ip_file | awk '{print $1}'`
new_ip_size=`du -b $new_ip_file | awk '{print $1}'`

echo 'old ip size=>'$old_ip_size
echo 'new ip size=>'$new_ip_size

if [ "x$old_ip_size" != "x$new_ip_size" ];then
   content='ip.txt changed!'
   curl -d "key=U7Ajg83E0X&title=$content&content=$content&to=weijungong&from=weijungong&cc=weijungong" "http://10.11.132.28:8089/action/email/send"
fi
