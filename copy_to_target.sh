#!/bin/bash
# Nick O'Dell
# Copies this repository to the remote machine

git add .
git commit -m "Automatically generated commit"
git push
ssh "$@" "rm -rf /root/configure_electrum_loadbalancer; \
          apt-get install -y git && \
          git clone https://github.com/nickodell/configure_electrum_loadbalancer && \
          nohup ./configure_electrum_loadbalancer/configure.sh"
