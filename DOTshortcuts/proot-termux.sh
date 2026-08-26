#!/data/data/com.termux/files/usr/bin/bash

[ -z "$PROOT_TERMUX" ] && test -f ~/.bashrc.proot && source ~/.bashrc.proot
[ -z "$PROOT_TERMUX" ] && PROOT_TERMUX='termux'
proot-distro login "$PROOT_TERMUX" --redirect-ports --isolated
