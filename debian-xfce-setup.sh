mkdir ~/debian3 && cp ~/termux-sh/debian-xfce-mod.sh ~/debian3 && cd ~/debian3 && bash debian-xfce-mod.sh --after "$(printf "apt update --allow-releaseinfo-change -y && apt --fix-broken install -y && apt upgrade -y\necho \"alias exit='vncserver-stop && trap '' INT TERM && builtin exit'\" >> ~/.bashrc && source ~/.bashrc\nrm -rf ~/.bash_profile\nvncserver-stop && trap '' INT TERM\necho 'debian-xfce-setup.sh finished'")"