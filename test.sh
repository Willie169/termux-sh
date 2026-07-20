#!/bin/bash
apt update >/dev/null 2>&1
DEBIAN_FRONTEND=noninteractive apt install gcc strace -y -o Dpkg::Options::="--force-confnew" >/dev/null 2>&1
set -x
ln -s /usr/bin/gcc /tmp/gcc-link
ln -s /tmp/gcc-link /tmp/gcc-link2
ln -s /tmp/gcc-link2 /tmp/gcc-link3
ln -s /tmp/gcc-link3 /tmp/gcc-link4
/tmp/gcc-link --version
/tmp/gcc-link2 --version
/tmp/gcc-link3 --version
/tmp/gcc-link4 --version
#git clone https://github.com/jusw85/mozlz4.git
#cd mozlz4 || true
#cargo build --release
#cd target/release || true
#mv mozlz4-bin mozlz4
#mv mozlz4 ~/.local/bin/
#cd ~ || true
#rm -rf mozlz4
exit
