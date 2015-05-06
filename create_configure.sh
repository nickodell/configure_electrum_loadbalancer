#!/bin/bash

cp /root/configure_electrum_loadbalancer/haproxy2.cfg /etc/haproxy/

while read host; do
  alpha_host=$(echo s$host | sed s/\./_/)
  echo "Checking $alpha_host";
  /root/configure_electrum_loadbalancer/check_candidate.sh $host
  if [[ $? -eq 0 ]] ; then
    
done < /root/candidates
