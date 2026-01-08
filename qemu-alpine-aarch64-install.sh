size='5G'
memory='1024'
cpu='2'
pkg update && pkg install qemu-utils qemu-common qemu-system-aarch64-headless wget -y
mkdir ~/alpine-aarch64 && cd ~/alpine-aarch64
wget https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/aarch64/alpine-virt-3.21.0-aarch64.iso
qemu-img create -f qcow2 alpine-aarch64.img $size
qemu-system-aarch64 -machine virt -m $memory -smp cpus=$cpu -cpu cortex-a72 -drive if=pflash,format=raw,read-only=on,file=$PREFIX/share/qemu/edk2-aarch64-code.fd -netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1 -cdrom alpine-virt-3.21.0-aarch64.iso -drive file=alpine-aarch64.img,format=qcow2 -nographic