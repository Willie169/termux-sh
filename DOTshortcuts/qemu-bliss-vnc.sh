memory='1024'
cpu='2'
qemu-system-x86_64 -machine q35 -m $memory -smp cpus=$cpu -cpu qemu64 -drive if=pflash,format=raw,read-only=on,file=$PREFIX/share/qemu/edk2-x86_64-code.fd -drive if=pflash,format=raw,read-only=on,file=$PREFIX/share/qemu/efi-virtio.rom -netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1 -drive file=bliss.img,format=qcow2 -vnc :0
