#!/bin/bash
apt update >/dev/null 2>&1
DEBIAN_FRONTEND=noninteractive apt install gcc strace -y -o Dpkg::Options::="--force-confnew" >/dev/null 2>&1
set -x
strace -e execve /usr/bin/cc --version
strace -e execve /etc/alternatives/cc --version
strace -e execve /usr/bin/gcc-15 --version
cp -a /etc/alternatives/cc /tmp/cc-a
ls -l /tmp/cc-a
/tmp/cc-a --version
ln -s /etc/alternatives/cc /tmp/cc-b
/tmp/cc-b --version
#git clone https://github.com/jusw85/mozlz4.git
#cd mozlz4 || true
#cargo build --release
#cd target/release || true
#mv mozlz4-bin mozlz4
#mv mozlz4 ~/.local/bin/
#cd ~ || true
#rm -rf mozlz4
exit
