#!/data/data/com.termux/files/usr/bin/bash

for f in ~/.bashrc.d/bashrc.d/*-functions.sh; do
  test -f "$f" && source "$f"
done
[ -z "$PROOT_UBUNTUBOX" ] && test -f ~/.bashrc.proot && source ~/.bashrc.proot
[ -z "$PROOT_UBUNTUBOX" ] && PROOT_UBUNTUBOX='ubuntubox'
pdl "$PROOT_UBUNTUBOX"
