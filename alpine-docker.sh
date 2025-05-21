sudo echo "nameserver 8.8.8.8" > /etc/resolv.conf
sudo echo "nameserver 8.8.4.4" >> /etc/resolv.conf
sudo apk update && sudo apk upgrade
sudo apk add docker
sudo service docker start
sudo rc-update add docker
sudo docker run hello-world