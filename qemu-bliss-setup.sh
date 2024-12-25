size='5G'
memory='1024'
cpu='2'
pkg update && pkg install qemu-utils qemu-common qemu-system-x86-64-headless wget -y
mkdir ~/bliss && cd ~/bliss
wget https://sourceforge.net/projects/blissos-x86/files/Official/BlissOS15/Gapps/Generic/Bliss-v15.9.2-x86_64-OFFICIAL-gapps-20241012.iso -o Bliss-v15.9.2-x86_64-OFFICIAL-gapps-20241012.iso
qemu-img create -f qcow2 bliss.img $size
qemu-system-x86_64 -machine q35 -m $memory -smp cpus=$cpu -cpu qemu64 -drive if=pflash,format=raw,read-only=on,file=$PREFIX/share/qemu/edk2-x86_64-code.fd -netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1 -cdrom Bliss-v15.9.2-x86_64-OFFICIAL-gapps-20241012.iso -drive file=bliss.img,format=qcow2 -nographic