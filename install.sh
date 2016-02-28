#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Update Packages
apt-get update

# Install Dependencies
apt-get install -y curl dnsmasq linux-image-extra-$(uname -r)
sleep 3

# Install Docker Engine
curl -sSL https://get.docker.com/ | sh

# Install Docker Compose
curl -sSL https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Add the vagrant-user to the Docker group
usermod -aG docker vagrant
