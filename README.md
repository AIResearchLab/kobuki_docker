# kobuki_docker

This repository contains dockerfile for kobuki system for both ARM64 and AMD64 systems.  This image bases itself on [AIResearchLab/kobuki](https://github.com/AIResearchLab/kobuki)


## Add this Docker container to other projects

Add the following snippet under `services` to any compose.yaml file to add this container.

```bash
  kobuki:
    image: ghcr.io/airesearchlab/kobuki:humble
    command: ros2 launch kobuki kobuki.launch.py
    restart: unless-stopped
    privileged: true
    network_mode: host
    volumes:
      - /dev:/dev
```

## Setup for pulling container from ghcr.io and running

Clone this reposiotory

```bash
git clone https://github.com/AIResearchLab/kobuki_docker.git
```

Pull the Docker image and run Docker compose (No need to run `docker compose build`)
```bash
cd kobuki_docker
docker compose pull
```

Start the docker container
```bash
docker compose up
```

## Setup for building the container on device running

Clone this reposiotory

```bash
git clone https://github.com/AIResearchLab/kobuki_docker.git
```

Build the Docker image
```bash
cd kobuki_docker
docker compose -f compose-build.yaml build
```

Start the docker container
```bash
docker compose -f compose-build.yaml up
```



