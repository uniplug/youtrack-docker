FROM java:8-jre-alpine
MAINTAINER "UcupBS"

RUN mkdir -p /opt/youtrack/data /opt/youtrack/backup /opt/youtrack/bin

WORKDIR /opt/youtrack

ENV YOUTRACK_VERSION 2017.2.33063

RUN apk add --no-cache \
	supervisor

RUN apk update 
RUN update-ca-certificates    
RUN apk add ca-certificates wget 

RUN wget \
 https://download.jetbrains.com/charisma/youtrack-${YOUTRACK_VERSION}.jar \
 -O /opt/youtrack/bin/youtrack.jar

#ADD youtrack.jar /opt/youtrack/bin/

ADD supervisor/youtrack.conf /etc/supervisor/conf.d/youtrack.conf

EXPOSE 80/tcp

VOLUME ["/opt/youtrack/data/", "/opt/youtrack/backup/"]

CMD ["/usr/bin/supervisord","-n","-c","/etc/supervisor/supervisord.conf"]
