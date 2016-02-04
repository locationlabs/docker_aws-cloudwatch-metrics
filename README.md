# docker_aws-cloudwatch-metrics

## Introduction:

AWS cloud watch does not provide memory usage and swap usage stats out of box. In order to obtain 
these stats, a set of [scripts][1] are to be installed and run on the box. This repo provides the 
docker image for containing the [scripts][1].

## Note:

Most of the Linux tools providing system resource metrics were created before cgroups even 
existed (e.g.: free and top, both from procps). They usually read memory metrics from the proc 
filesystem: /proc/meminfo, /proc/vmstat, /proc/PID/smaps and others.

Unfortunately /proc/meminfo, /proc/vmstat and friends are not containerized. Meaning that they are 
not cgroup-aware. They will always display memory numbers from the host system (physical or 
virtual machine) as a whole, which is the reason why this docker image exists.

[1]: http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip