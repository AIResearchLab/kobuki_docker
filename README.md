# kobuki_docker

This repository contains docker files for both ARM64 and AMD64 systems. Upon completions these will be released as docker images as well.

## To do list

- [x] Setup the docker images
- [ ] Add kobuki and test keyop and joyop
- [ ] Add Nav config and test

## Setup

Run the following commands in the terminal to set udev rules for kobuki connection

```sh
wget https://raw.githubusercontent.com/kobuki-base/kobuki_ftdi/devel/60-kobuki.rules
sudo cp 60-kobuki.rules /etc/udev/rules.d

sudo service udev reload
sudo service udev restart
```

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



