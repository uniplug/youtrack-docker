FROM openjdk:8-jre-alpine3.7
MAINTAINER tech@uniplug.ru

RUN mkdir -p /opt/youtrack/data /opt/youtrack/backup /opt/youtrack/bin

WORKDIR /opt/youtrack

ENV YOUTRACK_VERSION 2018.1.39916

RUN apk --no-cache upgrade

RUN apk --no-cache add supervisor ca-certificates wget

RUN update-ca-certificates

RUN wget \
 https://download.jetbrains.com/charisma/youtrack-${YOUTRACK_VERSION}.jar \
 -O /opt/youtrack/bin/youtrack.jar

ADD supervisor/youtrack.conf /etc/supervisor.d/youtrack.ini

EXPOSE 80/tcp

VOLUME ["/opt/youtrack/data/", "/opt/youtrack/backup/"]

CMD ["/usr/bin/supervisord","-n","-c","/etc/supervisord.conf"]
