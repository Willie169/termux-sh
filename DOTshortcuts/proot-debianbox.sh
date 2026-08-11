#!/data/data/com.termux/files/usr/bin/bash

for f in ~/.bashrc.d/bashrc.d/*-functions.sh; do
	test -f "$f" && source "$f"
done
[ -z "$PROOT_DEBIANBOX" ] && test -f ~/.bashrc.proot && source ~/.bashrc.proot
[ -z "$PROOT_DEBIANBOX" ] && PROOT_DEBIANBOX='debianbox'
pdl "$PROOT_DEBIANBOX"
