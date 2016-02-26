# YouTrack on Docker

This repository contains a Docker image of JetBrains [YouTrack](http://www.jetbrains.com/youtrack).

* The Docker image is available at [uniplug/youtrack](https://registry.hub.docker.com/u/uniplug/youtrack)
* The GitHub repository is available at [uniplug/docker-youtrack](https://github.com/uniplug/youtrack-docker)

Youtrack is started and managed by [supervisor](http://supervisord.org/). If you access to the container with

```bash
docker attach --sig-proxy=false "container_name" 
```

you can see the stdout and stderr provided by youtrack.


## Usage
First, pull the Docker image using the following command:

```bash
docker pull uniplug/youtrack
```

Next, create a container.

```bash
docker run -t uniplug/youtrack
```

YouTrack starts and listens on port 80 in the container. To map it to the host's port 80, use the following command to create the container instead:

```bash
docker run --name="youtrack" -p 80:80 -t uniplug/youtrack
```

### Additional settings

YouTrack stores its data and backups at ```/opt/youtrack/data/``` and ```/opt/youtrack/backup/``` in the container. If you wish to re-use data, it is a good idea to set up a volume mapping for these two paths. For example:

```bash
docker run -t \
 --name="youtrack" \
 -v /data/youtrack/data/:/opt/youtrack/data/ \
 -v /data/youtrack/backup/:/opt/youtrack/backup/ \
 -p 80:80 \
 uniplug/youtrack
```

### Service example

```ini
[Unit]
Description=YouTrack
After=docker.service nginx-proxy.service
Requires=docker.service nginx-proxy.service

[Service]
KillMode=none
ExecStartPre=-/usr/bin/docker kill youtrack
ExecStartPre=-/usr/bin/docker rm youtrack
ExecStart=/usr/bin/docker run -t \
          --name youtrack \
          -v /data/youtrack/data/:/opt/youtrack/data/ \
          -v /data/youtrack/backup/:/opt/youtrack/backup/ \
          -e VIRTUAL_HOST=youtrack.example.com \
          uniplug/youtrack
ExecStop=-/usr/bin/docker stop youtrack
```
