#!/bin/bash

# Install necessary packages (assuming Debian-based Linux distribution)
sudo apt-get update
sudo apt-get install -y bridge-utils

# Create a bridge interface
sudo ip link add name br0 type bridge

# Assign an IP address to the bridge interface
sudo ip addr add 192.168.0.1/24 dev br0

# Bring up the bridge interface
sudo ip link set dev br0 up

# Create Docker network
docker network create --driver=bridge --subnet=192.168.0.0/24 --gateway=192.168.0.1 mynetwork

# Run Nginx containers with assigned IP addresses and connect them to the network
docker run -d --name nginx_container1 --network=mynetwork --ip=192.168.0.10 nginx
docker run -d --name nginx_container2 --network=mynetwork --ip=192.168.0.11 nginx

# Verify connectivity
docker exec nginx_container1 ping -c 3 192.168.0.11
docker exec nginx_container2 ping -c 3 192.168.0.10

# Print container IP addresses
echo "Nginx container 1 IP address: 192.168.0.10"
echo "Nginx container 2 IP address: 192.168.0.11"
