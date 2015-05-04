#!/bin/bash

(echo '{"params": ["2.1.1", "0.9"], "id": 0, "method": "server.version"}' | \
   nc $1 50001 > output)& 

sleep 5; kill $!

grep -c '"id": 0, "result": "0.9"' output > /dev/null
if [[ $? -eq 0 ]] ; then
	echo "server responded"
else
	echo "server didn't respond"
fi
