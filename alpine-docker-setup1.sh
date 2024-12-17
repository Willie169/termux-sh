echo 'auto lo
iface lo inet loopback
auto eth0
iface eth0 inet dhcp' >> /etc/network/interfaces
/etc/init.d/networking restart
echo 'https://mirror.twds.com.tw/alpine/v3.21/community
https://mirror.twds.com.tw/alpine/v3.21/main
https://mirror.twds.com.tw/alpine/v3.21/releases' >> /etc/apk/repositories
apk update
apk upgrade
echo 'KEYMAPOPTS="tr"
HOSTNAMEOPTS="-n alpine"
INTERFACESOPTS="auto lo
iface lo inet loopback
auto eth0
iface eth0 inet dhcp"
TIMEZONEOPTS="-z UTC"
PROXYOPTS="none"
APKREPOSOPTS="https://mirror.twds.com.tw/alpine/v3.21/community
https://mirror.twds.com.tw/alpine/v3.21/main
https://mirror.twds.com.tw/alpine/v3.21/releases"
SSHDOPTS="-c openssh"
NTPOPTS="-c busybox"
DISKOPTS="-v -m sys -s 0 /dev/sda"' >> answerfile
poweroff
