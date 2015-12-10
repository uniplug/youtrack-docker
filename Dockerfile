FROM java:8-jre
MAINTAINER tech@uniplug.ru

WORKDIR /opt/youtrack

ADD log4j.xml /opt/youtrack/bin/

ENV YOUTRACK_VERSION 6.5.16953

RUN mkdir -p /youtrack /opt/youtrack/data /opt/youtrack/backup /opt/youtrack/bin

RUN wget -nv https://download.jetbrains.com/charisma/youtrack-$YOUTRACK_VERSION.jar -O /opt/youtrack/bin/youtrack-$YOUTRACK_VERSION.jar

RUN ln -s /opt/youtrack/bin/youtrack-$YOUTRACK_VERSION.jar /opt/youtrack/bin/youtrack.jar

EXPOSE 80

VOLUME ["/opt/youtrack/data/", "/opt/youtrack/backup/"]

ENTRYPOINT ["java", \
  "-Xmx1g", \
  "-XX:MaxMetaspaceSize=250m", \
  "-Duser.home=/opt/youtrack", \
  "-Ddatabase.location=/opt/youtrack/data", \
  "-Ddatabase.backup.location=/opt/youtrack/backup", \
  "-Djavax.net.ssl.trustStore=/etc/ssl/certs/java/cacerts", \
  "-Djavax.net.ssl.trustStorePassword=changeit", \
  "-Djetbrains.youtrack.disableBrowser=true", \
  "-Djetbrains.youtrack.enableGuest=false", \
  "-Djetbrains.mps.webr.log4jPath=/opt/youtrack/bin/log4j.xml", \
  "-Djava.awt.headless=true", \
  "-Djetbrains.youtrack.disableCheckForUpdate=true", \
  "-Djava.security.egd=/dev/urandom", \
  "-jar", \
  "/opt/youtrack/bin/youtrack.jar", \
  "80" \
]
