#!/usr/bin/env bash
for f in ci.sh termux-setup.sh ubuntu-debian.sh xmrig-install.sh DOTshortcuts/xmrig-xmr.sh DOTshortcuts/proot-*.sh; do
	chmod +x "$f"
	shfmt -w "$f"
	shellcheck "$f" -e 1090,1091
done
