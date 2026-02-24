cd ~
pkg install git build-essential cmake tor -y
git clone https://github.com/xmrig/xmrig.git
mkdir xmrig/build
cd xmrig/build
cmake .. -DWITH_HWLOC=OFF
make -j$(nproc)
cd ~
