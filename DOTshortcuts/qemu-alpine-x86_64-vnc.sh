memory='1024'
cpu='2'
qemu-system-x86_64 -machine q35 -m $memory -smp cpus=$cpu -cpu qemu64 -drive if=pflash,format=raw,read-only=on,file=$PREFIX/share/qemu/edk2-x86_64-code.fd -netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1 -drive file=~/alpine-x86_64/alpine-x86_64.img,format=qcow2 -vnc :0
