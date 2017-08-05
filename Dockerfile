FROM alpine:3.6

MAINTAINER ivan@lagunovsky.com

ENV LANG=C.UTF-8 \
    JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/jre \
    PATH=$PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin \
    Xms=512m \
    Xmx=1g \
    MaxMetaspaceSize=250m

COPY ./bin/youtrack-start /usr/local/bin/youtrack-start

RUN chmod +x /usr/local/bin/youtrack-start && \
    mkdir -p /opt/youtrack/data /opt/youtrack/backup /opt/youtrack/bin && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --update --no-cache wget bash

ENV JAVA_VERSION=8.141.15-r0 
RUN apk add --update --no-cache openjdk8-jre=${JAVA_VERSION}

ENV YOUTRACK_VERSION=2017.2.34480
RUN wget https://download.jetbrains.com/charisma/youtrack-${YOUTRACK_VERSION}.jar -O /opt/youtrack/bin/youtrack.jar

EXPOSE 80/tcp

WORKDIR /opt/youtrack

VOLUME ["/opt/youtrack/data/", "/opt/youtrack/backup/"]

CMD ["/usr/local/bin/youtrack-start"]
