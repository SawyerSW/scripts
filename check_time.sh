#!/bin/bash

ip=`/sbin/ifconfig | awk -F'[: ]+' '/Link encap/{a=$1;next;}/inet addr/{if($4!~/^127\./ && $4!~/^192\./ && $4 !~/^10\./ &&$4!~/^172\./)print $4}'|head -1`
ls /sbin/ntpdate
if [ $? -ne 0 ];then
	yum -y install ntpdate
fi
echo 'ZONE="Asia/Shanghai"' >/etc/sysconfig/clock &&ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && /usr/sbin/ntpdate time.nist.gov

/usr/sbin/ntpdate time.nist.gov
if [ $? -ne 0 ];then
    /usr/sbin/ntpdate time-a.nist.gov
    if [ $? -ne 0 ];then
        /usr/bin/rdate -s time.nist.gov
        if [ $? -ne 0 ];then
            /usr/bin/rdate -s time-a.nist.gov
            if [ $? -ne 0 ];then
                echo "`date` $ip time rsync fail!!!" >> /tmp/time.log
                if [ `awk 'END{print NR}' /tmp/time.log` -gt 3 ];then
                    /bin/rm /tmp/time.log -f
                    echo "$ip time rsync fail" | mail -s "time rsync fail" -c other@yfcloud.com yunwei_live@yfcloud.com
                fi
            fi
        fi
    fi
fi
