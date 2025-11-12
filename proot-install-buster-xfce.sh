BUSTERXFCE='busterxfce'

[ -n "$BUSTERXFCE" ] && mkdir ~/$BUSTERXFCE && echo "bash ~/$BUSTERXFCE/start-debian.sh" >> ~/$BUSTERXFCE.sh && chmod +x ~/$BUSTERXFCE.sh && cp ~/$BUSTERXFCE.sh ~/.shortcuts && cp ~/termux-sh/debian-xfce-mod.sh ~/$BUSTERXFCE && rm -rf ~/termux-sh && bash ~/$BUSTERXFCE/debian-xfce-mod.sh --after "$(printf "apt update --allow-releaseinfo-change -y && apt --fix-broken install -y && apt upgrade -y\necho \"alias exit='vncserver-stop && trap '' INT TERM && builtin exit'\" >> ~/.bashrc && source ~/.bashrc\nrm -rf ~/.bash_profile\nvncserver-stop && trap '' INT TERM\nexit")"
