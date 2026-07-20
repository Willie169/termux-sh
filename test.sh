#!/bin/bash
apt update >/dev/null 2>&1
DEBIAN_FRONTEND=noninteractive apt install bash g++ gcc git -y -o Dpkg::Options::="--force-confnew" >/dev/null 2>&1
set -x
apt install strace -y >/dev/null 2>&1
strace -e execve /usr/bin/cc --version
ln -s /usr/bin/gcc /tmp/mycc
ls -l /tmp/mycc
/tmp/mycc --version
#git clone https://github.com/jusw85/mozlz4.git
#cd mozlz4 || true
#cargo build --release
#cd target/release || true
#mv mozlz4-bin mozlz4
#mv mozlz4 ~/.local/bin/
#cd ~ || true
#rm -rf mozlz4
exit
