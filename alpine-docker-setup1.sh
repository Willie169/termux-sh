echo 'KEYMAPOPTS="tr"
HOSTNAMEOPTS="-n alpine"
INTERFACESOPTS="auto lo
iface lo inet loopback
auto eth0
iface eth0 inet dhcp"
TIMEZONEOPTS="-z UTC"
PROXYOPTS="none"
APKREPOSOPTS="https://dl-cdn.alpinelinux.org/alpine/v3.21/community
https://dl-cdn.alpinelinux.org/alpine/v3.21/main"
SSHDOPTS="-c openssh"
NTPOPTS="-c busybox"
DISKOPTS="-v -m sys -s 0 /dev/sda"' >> answerfile
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
apk update
apk add docker
service docker start
rc-update add docker
docker run hello-world