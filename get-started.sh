cd ~
termux-setup-storage
apt update && apt upgrade -y && pkg update && pkg upgrade -y
pkg install git -y
git clone https://github.com/Willie169/termux-sh.git
source ~/termux-sh/termux-setup.sh