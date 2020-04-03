# multi arch docker image for vzlogger

This image wraps a [vzlogger](https://github.com/volkszaehler/vzlogger) 
into a container for platforms
- linux/amd64
- linux/arm64
- linux/arm/v7

## usage
The image has its entrypoint set to vzlogger. Just pass any vzlogger command
line arguments to the "docker run" command. Bind mount your vzlogger.conf from
from the host file system into the container.

Example:

    docker run --rm --read-only -v $PWD/vzlogger.conf:/etc/vzlogger.conf:ro -p8080:8080 -t torstend/vzlogger --httpd --httpd-port 8080

As an alternative, use this snipped in your docker-compose.yaml and run "docker-compose run vzlogger"

    version: '3.2'
    services:
      vzlogger:
        image: torstend/vzlogger:latest
        read_only: true
        command: [ "--httpd", "--httpd-port", "8080" ]
        tty: true
        volumes:
          - ./vzlogger.conf:/etc/vzlogger.conf:ro
        healthcheck:
          test: "curl -f http://localhost:8080/ ||exit 1"
          interval: 10s
          timeout: 10s
          retries: 2
        ports:
          - "8080:8080"

[Dockerfile](https://github.com/t3r/vzlogger-docker/blob/master/Dockerfile) 
and [docker-compose.yaml](https://github.com/t3r/vzlogger-docker/blob/master/docker-compose.yaml) could be 
found [here: https://github.com/t3r/vzlogger-docker](https://github.com/t3r/vzlogger-docker)

The images at [the docker hub](https://hub.docker.com/repository/docker/torstend/vzlogger)
were build with this command

    docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t torstend/vzlogger -t torstend/vzlogger:stretch-0.8.0-git-8d06176 . --push
