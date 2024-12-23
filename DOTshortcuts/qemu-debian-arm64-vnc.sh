memory='1024'
cpu='2'
qemu-system-aarch64 -machine virt -m $memory -smp cpus=$cpu -cpu cortex-a53 -drive file=~/debian-arm64/debian-12-nocloud-arm64.qcow2,format=qcow2 -netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1 -vnc :0