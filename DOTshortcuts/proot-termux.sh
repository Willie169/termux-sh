[ -z "$TERMUX" ] && TERMUX='termux'
bash <(proot-distro login $TERMUX --redirect-ports --isolated --get-proot-cmd)
