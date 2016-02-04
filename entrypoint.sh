#!/bin/bash

trap "exit" SIGINT SIGTERM

while true; do 
  /opt/aws-scripts-mon/mon-put-instance-data.pl --verbose --swap-util --mem-util --disk-space-util --disk-path=/ --auto-scaling
  sleep ${SLEEP_DURATION:-10}
done
