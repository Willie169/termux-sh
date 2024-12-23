size='5G'
memory='1024'
cpu='2'
pkg update && pkg install qemu-utils qemu-common qemu-system-x86_64-headless wget -y
mkdir ~/debian-amd64 && cd ~/debian-amd64
wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-nocloud-amd64.qcow2
qemu-img resize debian-12-nocloud-amd64.qcow2 +$size && qemu-system-x86_64 -machine q35 -m $memory -smp cpus=$cpu -cpu qemu64 -drive file=~/debian-amd64/debian-12-nocloud-amd64.qcow2,format=qcow2 -netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1 -nographic