#!/bin/bash
# Nick O'Dell
# Sets up the loadbalancer, automatically run by copy_to_target.sh

apt-get install haproxy netcat

touch /root/candidates

mkdir -p /root/logs

crontab -l -u root 2> /dev/null | grep -c "configure_electrum" > /dev/null

if [[ $? -eq 1 ]]; then
	echo "Adding entries to crontab"
	crontab -l -u root | cat - /root/configure_electrum_loadbalancer/crontab_entries | crontab -u root -
fi

# Not much point in this since there's nothing in /root/candidates, but
# might as well.
/root/configure_electrum_loadbalancer/create_configuration.sh
