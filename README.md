# YouTrack on Docker
	
[![](https://badge.imagelayers.io/uniplug/youtrack:latest.svg)](https://imagelayers.io/?images=uniplug/youtrack:latest 'Get your own badge on imagelayers.io')
[![Docker Repository on Quay](https://quay.io/repository/uniplug/youtrack/status "Docker Repository on Quay")](https://quay.io/repository/uniplug/youtrack)


This repository contains a UNOFFICIAL Docker image of JetBrains [YouTrack](http://www.jetbrains.com/youtrack).

* The Docker image is available at [hub.docker.com](https://hub.docker.com/r/uniplug/youtrack/) and [quay.io](https://quay.io/repository/uniplug/youtrack)
* The GitHub repository is available at [uniplug/docker-youtrack](https://github.com/uniplug/youtrack-docker)

**Alpine tag does not contain a supervisor and cannot restart on its own when failed.**

## Usage

Create a named container 'youtrack'.

```bash
docker create --name youtrack quay.io/uniplug/youtrack:alpine
```

Start the container.

```bash
docker start youtrack
```

YouTrack starts and listens on port 80 in the container.
To map it to the host's port 80, use the following command to create and start the container:

```bash
docker run -d --name youtrack -p 80:80 quay.io/uniplug/youtrack:alpine
```

To access container logs

```bash
docker logs -f youtrack
```

YouTrack is started and managed by [supervisor](http://supervisord.org/).

### Additional settings

YouTrack stores its data and backups at ```/opt/youtrack/data/``` and ```/opt/youtrack/backup/``` in the container.
If you wish to re-use data, it is a good idea to set up a volume mapping for these two paths. For example:

```bash
docker run -d \
 --name="youtrack" \
 -v /data/youtrack/data/:/opt/youtrack/data/ \
 -v /data/youtrack/backup/:/opt/youtrack/backup/ \
 -p 80:80 \
 quay.io/uniplug/youtrack:alpine
```
