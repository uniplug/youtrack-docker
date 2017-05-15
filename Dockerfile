FROM java:8-jre
MAINTAINER Coordenadoria de Tecnologia da Informação - UFC/Quixada <ccti@quixada.ufc.br>

RUN mkdir -p /opt/youtrack/data /opt/youtrack/backup /opt/youtrack/bin

WORKDIR /opt/youtrack

ENV YOUTRACK_VERSION 2017.2.33063

RUN apt-get update && \
    apt-get install -y supervisor && \
    rm -rf /var/lib/apt/lists/*

RUN wget \
 https://download.jetbrains.com/charisma/youtrack-${YOUTRACK_VERSION}.jar \
 -O /opt/youtrack/bin/youtrack.jar

ADD supervisor/youtrack.conf /etc/supervisor/conf.d/youtrack.conf

EXPOSE 80/tcp

VOLUME ["/opt/youtrack/data/", "/opt/youtrack/backup/"]

CMD ["/usr/bin/supervisord","-n","-c","/etc/supervisor/supervisord.conf"]
