#!/bin/bash
# Nick O'Dell
# Simple script to look at the logs of the bitcoind process and check if it's
# actually getting new blocks.

# This is because this is used by cron
echo "----------"
date

mkdir -p /root/logs

while read host; do
  alpha_host=$(echo s$host | sed 's/\./_/g')
  scp -o ConnectTimeout=5 -o StrictHostKeyChecking=no \
    -o BatchMode=yes \
    root@$host:/home/bitcoin/.bitcoin/debug.log /root/logs/$alpha_host.log
  if [[ $? -eq 0 ]]; then
    echo -n "Got logs from $host, "
    grep -c "UpdateTip" /root/logs/$alpha_host.log \
      | xargs echo -n # Strip trailing newline
    echo " new blocks since logs were last pruned.";
    rm /root/logs/$alpha_host.failed 2> /dev/null
  else
    echo "Server $host failed."
    touch /root/logs/$alpha_host.failed
  fi
done < /root/candidates
