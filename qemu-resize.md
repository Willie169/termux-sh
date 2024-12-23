## Resize Disk Space of QEMU VM
### Resize Image
In host, run:
```
qemu-img resize debian-12-nocloud-amd64.qcow2 +5G
```
Change `debian-12-nocloud-amd64.qcow2` to the real file name. `+5G` indicates increasing 30GB disk image. You can adjust the size as needed.
### For Debian Derivatives
In Debian-derivative guest, run:
```
sudo apt update
sudo apt install parted e2fsprogs -y
sudo parted /dev/sda
print
fix
resizepart 1 100%
quit
sudo resize2fs /dev/sda
```
Change `/dev/sda` to the actual disk name.