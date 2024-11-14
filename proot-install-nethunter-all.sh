apt update && apt upgrade -y
apt install bc ncurses-utils proot-distro git -y
git clone https://github.com/sagar040/proot-distro-nethunter.git
cd proot-distro-nethunter
bash install-nethunter.sh --install