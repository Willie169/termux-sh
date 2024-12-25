size='5G'
memory='1024'
cpu='2'
pkg update && pkg install qemu-utils qemu-common qemu-system-x86-64-headless wget -y
mkdir ~/alpine-x86_64 && cd ~/alpine-x86_64
wget https://dl-cdn.alpinelinux.org/v3.21/releases/x86_64/alpine-virt-3.21.0-x86_64.iso
qemu-img create -f qcow2 alpine-x86_64.img $size
qemu-system-x86_64 -machine q35 -m $memory -smp cpus=$cpu -cpu qemu64 -drive if=pflash,format=raw,read-only=on,file=$PREFIX/share/qemu/edk2-x86_64-code.fd -netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1 -cdrom alpine-virt-3.21.0-x86_64.iso -drive file=alpine-x86_64.img,format=qcow2 -nographic