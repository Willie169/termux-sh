#!/data/data/com.termux/files/usr/bin/bash

for f in ~/.bashrc.d/*-functions.sh; do
	test -f "$f" && source "$f"
done
[ -z "$PROOT_DEBIAN" ] && test -f ~/.bashrc.proot && source ~/.bashrc.proot
[ -z "$PROOT_DEBIAN" ] && PROOT_DEBIAN='debian'
pdl "$PROOT_DEBIAN"
