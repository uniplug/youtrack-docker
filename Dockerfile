FROM java:8-jre
MAINTAINER tech@uniplug.ru

RUN mkdir -p /opt/youtrack/data /opt/youtrack/backup /opt/youtrack/bin

WORKDIR /opt/youtrack

ENV YOUTRACK_VERSION 7.0.27477

RUN apt-get update && \
    apt-get install -y supervisor && \
    rm -rf /var/lib/apt/lists/*

RUN wget --progress=dot:mega \
 https://download.jetbrains.com/charisma/youtrack-${YOUTRACK_VERSION}.jar \
 -O /opt/youtrack/bin/youtrack.jar

#ADD youtrack.jar /opt/youtrack/bin/

ADD supervisor/youtrack.conf /etc/supervisor/conf.d/youtrack.conf

EXPOSE 80/tcp

VOLUME ["/opt/youtrack/data/", "/opt/youtrack/backup/"]

CMD ["/usr/bin/supervisord","-n","-c","/etc/supervisor/supervisord.conf"]
