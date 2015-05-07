#!/bin/bash
# Nick O'Dell
# Usage: [ip-of-loadbalancer] [ip-of-worker]
# Adds the second ip to the loadbalancer specified by the first IP.
# Expects publickey login

ssh root@$2 "echo \"$1\" >> /root/candidates; \
        cat /root/candidates | uniq > /root/candidates2;  \
        mv /root/candidates{2,}; \
        ";

OUTPUT=$(ssh root@$2 "cat /root/candidates")

echo "$OUTPUT" | grep -c $1 > /dev/null
if [[ $? -eq 0 ]] ; then
	echo "Success!"
	echo "Added $1 to list of candidate IPs."
else
	echo "Failed."
fi
