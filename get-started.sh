cd ~
termux-setup-storage
termux-change-repo
pkg update && pkg upgrade -y && apt update && apt upgrade -y && pkg install git -y
git clone https://github.com/Willie169/termux-sh.git
chmod +x ~/termux-sh/*.sh && chmod +x ~/termux-sh/DOTshortcuts/*.sh
source ~/termux-sh/termux-setup-all.sh