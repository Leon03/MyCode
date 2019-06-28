#/bin/bash
wol_file=/tmp/wolfile
iface=$1
while :
do
{
#    tcpdump udp port 2304 -i br-lan -c 1 -w $wol_file;
    tcpdump udp port 2304 -i $iface -c 1 -w $wol_file;
    result=`hexdump  -s 82 $wol_file -e '6/1 "%02X:" "\n"' -n 102`;
    line1=`echo $result | awk '{print $1}'`
    line2=`echo $result | awk '{print $2}'`
    line3=`echo $result | awk '{print $3}'`
    if [ x$line1 = x"FF:FF:FF:FF:FF:FF:" -a x$line3 = x"*" ]
    then
        echo "etherwake -i $iface -b ${line2%:}"
        `etherwake -i $iface -b $line2`
    fi
}
done
