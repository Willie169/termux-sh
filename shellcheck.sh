#!/bin/bash
for f in termux-setup.sh ubuntu-debian.sh xmrig-install.sh DOTshortcuts/xmrig-xmr.sh DOTshortcuts/proot-*.sh; do
test -f "$f" && shellcheck "$f" -e 1090,1091
done
