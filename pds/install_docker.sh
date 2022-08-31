#!/bin/bash

# update repo
sudo apt-get update

# add GPG key
sudo apt-get install -y curl
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# add Docker repository
sudo apt-get install -y software-properties-common
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# update the docker repo
sudo apt-get update

# make sure we install Docker from the Docker repo
sudo apt-cache policy docker-ce

# install Docker (the oldest version among the versions that Ubuntu supports)
sudo apt-get install -y docker-ce=5:19.03.9~3-0~ubuntu-focal;;

# configure daemon.json
sudo mkdir -p /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
    "exec-opts": ["native.cgroupdriver=systemd"],
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "100m"
    },
    "storage-driver": "overlay2"
}
EOF

# start docker
sudo systemctl enable docker
sudo systemctl restart docker

sleep 1

# add user to docker
sudo usermod -aG docker $USER

# allow non-root user to access docker.sock just for your convenience :)
# (Caution! This line may be harmful in the real-world!)
sudo chmod 666 /var/run/docker.sock
