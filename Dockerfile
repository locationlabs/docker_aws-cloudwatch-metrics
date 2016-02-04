FROM debian:latest

RUN apt-get update && \
  apt-get install -y wget unzip libwww-perl libdatetime-perl

RUN cd /opt && \
  wget http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip && \
  unzip CloudWatchMonitoringScripts-1.2.1.zip && \
  rm CloudWatchMonitoringScripts-1.2.1.zip

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
