# kobuki_docker

This repository contains dockerfile for kobuki system for both ARM64 and AMD64 systems.

## Setup for Docker container from ghcr.io

Add the following snippet under `services` to any compose.yaml file to add this container.

```bash
  kobuki:
    image: postgres:15.6-bookworm
    command: ros2 launch kobuki kobuki.launch.py
    restart: unless-stopped
    privileged: true
    network_mode: host
    volumes:
      - /dev:/dev
```

## Setup for Dockerfile

Run the following commands in the terminal to set udev rules for kobuki connection

Clone this reposiotory

```bash
git clone https://github.com/AIResearchLab/kobuki_docker.git
```

Build the Docker image
```bash
cd kobuki_docker
docker compose build
```

## Startup

```bash
docker compose up
```



