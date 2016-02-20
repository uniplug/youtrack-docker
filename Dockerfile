FROM java:8-jre
MAINTAINER tech@uniplug.ru

WORKDIR /opt/youtrack

ADD log4j.xml /opt/youtrack/bin/

ENV YOUTRACK_VERSION 6.5.17031
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y vim supervisor
RUN mkdir -p /youtrack /opt/youtrack/data /opt/youtrack/backup /opt/youtrack/bin

RUN wget -nv https://download.jetbrains.com/charisma/youtrack-$YOUTRACK_VERSION.jar -O /opt/youtrack/bin/youtrack-$YOUTRACK_VERSION.jar

RUN ln -s /opt/youtrack/bin/youtrack-$YOUTRACK_VERSION.jar /opt/youtrack/bin/youtrack.jar

EXPOSE 80

#ADD ./start.sh start.sh
ADD supervisord.conf /etc/supervisord.conf
ADD supervisor/youtrack.conf supervisor/youtrack.conf
VOLUME ["/opt/youtrack/data/", "/opt/youtrack/backup/"]

CMD ["/usr/bin/supervisord","-n","-c","/etc/supervisord.conf"]

