#!/data/data/com.termux/files/usr/bin/bash
pkg update >/dev/null 2>&1
DEBIAN_FRONTEND=noninteractive pkg install proot proot-distro -y -o Dpkg::Options::="--force-confnew" >/dev/null 2>&1
proot-distro install ubuntu:latest --name ubuntu >/dev/null 2>&1
cp ~/termux-sh/test.sh "${PREFIX}/var/lib/proot-distro/containers/ubuntu/rootfs/root/" >/dev/null 2>&1
echo './test.sh' | bash <(proot-distro login "$UBUNTU" --redirect-ports --shared-tmp --isolated --get-proot-cmd)
exit
