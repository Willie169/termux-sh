memory='1024'
cpu='2'
qemu-system-x86_64 -machine q35 -m $memory -smp cpus=$cpu -cpu qemu64 -drive file=~/debian-amd64/debian-12-nocloud-amd64.qcow2,format=qcow2 -netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1 -nographic