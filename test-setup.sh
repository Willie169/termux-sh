#!/data/data/com.termux/files/usr/bin/bash
UBUNTU='ubuntu'
UBUNTUINSTALL=1
cd ~ || exit
pkg update
DEBIAN_FRONTEND=noninteractive pkg install proot proot-distro -y -o Dpkg::Options::="--force-confnew"
[ -n "$UBUNTU" ] && proot-distro install ubuntu:latest --name "$UBUNTU"
[ -n "$UBUNTU" ] && [ "$UBUNTUINSTALL" -ne 0 ] && cp ~/termux-sh/test.sh "$PRF/$UBUNTU/rootfs/root/" && echo './test.sh' | bash <(proot-distro login "$UBUNTU" --redirect-ports --shared-tmp --isolated --get-proot-cmd)
exit
