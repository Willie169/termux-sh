#!/data/data/com.termux/files/usr/bin/bash
proot-distro install debian
proot-distro install ubuntu
bash ~/termux-sh/proot-install-debianbox.sh
cat ~/termux-sh/debian-bookworm.sh <(echo -e "\nexit") | bash ~/proot-debian.sh
cat ~/termux-sh/ubuntu-24-04.sh <(echo -e "\nexit") | bash ~/proot-ubuntu.sh
cat ~/termux-sh/box64-wine64-winetricks.sh <(echo -e "\nexit") | bash ~/proot-debianbox.sh
cp ~/termux-sh/debian1-setup.sh ~/debian1/debian-fs/root && echo 'bash debian1-setup.sh && rm debian1-setup.sh && exit' bash ~/debian1.sh
cp ~/termux-sh/debian2-setup.sh ~/debian2/debian-fs/root && echo 'bash debian1-setup.sh && rm debian1-setup.sh && exit' bash ~/debian2.sh
cd ~
echo 'termux-setup.sh finished'