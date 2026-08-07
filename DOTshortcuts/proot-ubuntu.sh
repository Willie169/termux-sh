#!/data/data/com.termux/files/usr/bin/bash

for f in ~/.bashrc.d/*-functions.sh; do
	test -f "$f" && source "$f"
done
[ -z "$PROOT_UBUNTU" ] && test -f ~/.bashrc.proot && source ~/.bashrc.proot
[ -z "$PROOT_UBUNTU" ] && PROOT_UBUNTU='ubuntu'
pdl "$PROOT_UBUNTU"
