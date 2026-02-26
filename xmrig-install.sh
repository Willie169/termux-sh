cd ~
pkg install git build-essential cmake luv openssl tor -y
git clone https://github.com/Willie169/xmrig.git
mkdir ~/xmrig/build
cd ~/xmrig/build
cmake .. -DWITH_HWLOC=OFF
make -j$(nproc)
