apt update && apt upgrade -y
apt install git ncurses-utils -y
git clone https://github.com/sagar040/proot-distro-nethunter.git
cd proot-distro-nethunter
./install-nethunter.sh --install