FROM java:8-jre-alpine
MAINTAINER tech@uniplug.ru

WORKDIR /opt/youtrack

ENV YOUTRACK_VERSION 2018.1.41561

ADD youtrack-start /usr/local/bin/youtrack-start

RUN apk add --no-cache \
	ca-certificates

RUN \
    mkdir -p /opt/youtrack/data /opt/youtrack/backup /opt/youtrack/bin \
    && chmod +x /usr/local/bin/youtrack-start

ADD https://download.jetbrains.com/charisma/youtrack-${YOUTRACK_VERSION}.jar \
 /opt/youtrack/bin/youtrack.jar

EXPOSE 80/tcp

VOLUME ["/opt/youtrack/data/", "/opt/youtrack/backup/"]

CMD ["/usr/local/bin/youtrack-start"]
