#!/bin/ash
#first we need install pkg iputils-ping and ssmtp
localip="192.168.1.252"
target="202.96.104.15"
password="password"
username="username"
src="sender"
dst="receiver"
pub_ip=/tmp/pubip
if [ ! -f "$pub_ip" ]; then
    touch $pub_ip
fi
lasttime=`head -n 1 $pub_ip`
oldip=`tail -n 1 $pub_ip`
result=`/usr/bin/ping -c 1 -R $target | head -n 4 | tail -n 1 | sed -e 's/^[ \t]*//g' -e 's/[ \t]*$//g' -e '/^$/d'`
if [ x$result = x$oldip ]
then
    echo "Same router ip, ignore it."
    echo `date -Iseconds` > $pub_ip
    echo "$result" >> $pub_ip
else
    if [ ${#result} -ge 16 ]
    then
        echo "Wrong information."
    else
        echo "Router ip was changed, send email!!!"
        echo `date -Iseconds` > $pub_ip
        echo "$result" >> $pub_ip
        (echo "From:<$src>";echo "To:<$dst>";echo "Subject: new ip is $result";echo "";echo "$result";) | ssmtp -v -au$username -ap$password $dst
    fi
fi
