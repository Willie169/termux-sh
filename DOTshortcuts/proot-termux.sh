#!/data/data/com.termux/files/usr/bin/bash
[ -z "$TERMUX" ] && TERMUX='termux'
bash <(proot-distro login "$TERMUX" --redirect-ports --isolated --get-proot-cmd)
