[ -z "$TERMUX" ] && TERMUX='termux'
proot-distro login $TERMUX --redirect-ports --isolated
