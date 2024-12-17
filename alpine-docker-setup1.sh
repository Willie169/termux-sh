echo 'auto lo
iface lo inet loopback
auto eth0
iface eth0 inet dhcp' >> /etc/network/interfaces
/etc/init.d/networking restart
echo 'https://dl-cdn.alpinelinux.org/alpine/v3.21/community
https://dl-cdn.alpinelinux.org/alpine/v3.21/main' >> /etc/apk/repositories
apk update
apk upgrade
setup-alpine
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
poweroff