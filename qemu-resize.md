## Resize Disk Space of QEMU VM
### Resize Image
In host, run:
```
qemu-img resize debian-12-nocloud-amd64.qcow2 +5G
```
Change `debian-12-nocloud-amd64.qcow2` to the real file name. `+5G` indicates increasing 30GB disk image. You can adjust the size as needed.
### Resize Partition in Debian AMD64
In Debian-derivative guest, run:
```
sudo apt update
sudo apt install parted e2fsprogs -y
sudo parted /dev/sda
```
In `(parted)`, run:
```
print
fix
resizepart 1 100%
quit
```
and then run:
```
sudo resize2fs /dev/sda1
```
### Resize Partition in Debian ARM64
In Debian-derivative guest, run:
```
sudo apt update
sudo apt install parted e2fsprogs -y
sudo parted /dev/vda
```
In `(parted)`, run:
```
print
fix
resizepart 1 100%
quit
```
and then run:
```
sudo resize2fs /dev/vda1
```
