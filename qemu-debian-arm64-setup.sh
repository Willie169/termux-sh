size='5G'
memory='1024'
cpu='2'
pkg update && pkg install qemu-utils qemu-common qemu-system-aarch64-headless wget -y
mkdir ~/debian-arm64 && cd ~/debian-arm64
wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-nocloud-arm64.qcow2
qemu-img resize debian-12-nocloud-arm64.qcow2 +$size
qemu-system-aarch64 -machine virt -m $memory -smp cpus=$cpu -cpu cortex-a53 -drive if=pflash,format=raw,read-only=on,file=$PREFIX/share/qemu/edk2-aarch64-code.fd -netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1 -drive file=~/debian-arm64/debian-12-nocloud-arm64.qcow2,format=qcow2 -nographic