#!/bin/ash
#first we need install pkg iputils-ping
localip="192.168.1.254"
target="202.96.104.15"
pub_ip_file=/tmp/pubip
oldip=`cat $pub_ip_file`
result=`/usr/bin/ping -c 1 -R $target | head -n 4 | tail -n 1 | sed -e 's/^[ \t]*//g' -e 's/[ \t]*$//g' -e '/^$/d'`
if [ x$result = x$oldip ]
then
    echo "Same router ip, ignore it."
else
    if [ ${#result} -ge 16 ]
    then
        echo "Wrong information."
    else
        echo "Router ip was changed, send email!!!"
        echo "$result" > $pub_ip_file
        (echo "From:<name1@xx1.com>";echo "To:<name2@xx2.com>";echo "Subject: new ip is $result";echo "";echo "$result";) | ssmtp -v -auname1 -appassword1 name2@xx2.com
    fi
fi

