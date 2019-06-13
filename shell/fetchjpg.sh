#!/bin/bash
i=0
url=http://www.shuxue9.com/pep/gzbixiu1/ebook/
while [ "$i" -lt 125 ]
do
	let i=i+1
	if [ "$i" -lt 10 ]
	then
		page="00"$i".jpg"
	else
		if [ "$i" -lt 100 ]
		then
			page="0"$i".jpg"
		else
			page=$i".jpg"
		fi
	fi
	echo $url$page
	wget $url$page
	sleep 1
done

