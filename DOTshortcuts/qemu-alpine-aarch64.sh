memory='1024'
cpu='2'
qemu-system-aarch64 -machine virt -m $memory -smp cpus=$cpu -cpu cortex-a53 -drive if=pflash,format=raw,read-only=on,file=$PREFIX/share/qemu/edk2-aarch64-code.fd -netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1 -drive file=~/alpine-aarch64/alpine-aarch64.img,format=qcow2 -nographic