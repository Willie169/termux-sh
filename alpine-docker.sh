echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
apk update && apk upgrade
apk add docker
service docker start
rc-update add docker
