#!/bin/bash
# Nick O'Dell
# Writes the haproxy configuration given /root/candidates

#This part is because it's used in cron
echo "----------"
date

cp /root/configure_electrum_loadbalancer/haproxy2.cfg /etc/haproxy/

while read host; do
  alpha_host=$(echo s$host | sed 's/\./_/g')
  echo "Checking $alpha_host";
  /root/configure_electrum_loadbalancer/check_candidate.sh $host 2> /dev/null
  if [[ $? -eq 0 ]] ; then
    echo "	server $alpha_host $host:50001 check" >> /etc/haproxy/haproxy2.cfg
  fi
done < /root/candidates

mv /etc/haproxy/haproxy2.cfg /etc/haproxy/haproxy.cfg
service haproxy restart
