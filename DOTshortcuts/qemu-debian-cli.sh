qemu-system-x86_64 -m 2G \
-drive file=debian-12-nocloud-amd64.qcow2,format=qcow2 \
-nographic \
-serial mon:stdio \
-display none \
-netdev user,id=net0,hostfwd=tcp::2222-:22 \
-device e1000,netdev=net0
