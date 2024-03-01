# Building Docker Networking from Scratch

This project demonstrates how to set up a basic Docker network using a bridge interface on a Debian-based system. This guide provides step-by-step instructions and explanations for new engineers.

**Prerequisites:**

* Basic understanding of Linux commands.
* Docker installed and running.

**Steps:**

1. **Update package list and install bridge-utils:**
    * The script uses `sudo apt-get update` to refresh the package list and `sudo apt-get install -y bridge-utils` to install the `bridge-utils` package, which provides tools for managing bridge interfaces.

2. **Create a bridge interface:**
    * `sudo ip link add name br0 type bridge` creates a new bridge interface named `br0`. A bridge interface acts as a virtual switch, allowing multiple network devices to connect and communicate.

3. **Assign IP address to the bridge:**
    * `sudo ip addr add 192.168.0.1/24 dev br0` assigns the IP address `192.168.0.1` with a subnet mask of `/24` to the bridge interface `br0`. This defines the network range for devices connected to the bridge.

4. **Bring up the bridge interface:**
    * `sudo ip link set dev br0 up` activates the bridge interface, allowing devices to connect and communicate through it.

5. **Create Docker network:**
    * `docker network create --driver=bridge --subnet=192.168.0.0/24 --gateway=192.168.0.1 mynetwork` creates a Docker network named `mynetwork`. The options used are:
        * `--driver=bridge`: Specifies the bridge driver, which utilizes the previously created bridge interface.
        * `--subnet=192.168.0.0/24`: Defines the subnet for the network, matching the one assigned to the bridge.
        * `--gateway=192.168.0.1`: Sets the network gateway, which is the IP address of the bridge interface.

6. **Run Nginx containers:**
    * Two Docker containers are launched using `docker run`:
        * `nginx_container1`: This container is named `nginx_container1` and is connected to the `mynetwork` network. The `--ip=192.168.0.10` option assigns a static IP address of `192.168.0.10` within the network. The image used is `nginx`, which runs the Nginx web server.
        * `nginx_container2`: This container follows a similar pattern, named `nginx_container2`, connected to `mynetwork`, and assigned a static IP of `192.168.0.11`.

7. **Verify connectivity:**
    * The script checks connectivity between the containers using `ping`:
        * `docker exec nginx_container1 ping -c 3 192.168.0.11`: This command runs `ping` inside `nginx_container1`, sending 3 ping requests to container 2's IP (`192.168.0.11`).
        * A similar command is executed in `nginx_container2` to ping container 1.

8. **Print container IP addresses:**
    * The script simply prints the assigned IP addresses for both containers for reference.

**Note:**

* This script is intended for my educational purposes only and should be used with caution in production environments.
* Consider security implications when assigning static IP addresses and ensure proper network access controls are in place.
