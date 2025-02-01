## Resize Disk Space of QEMU VM
### Check Image Info

In host, run:

```
qemu-img info <image>
```

### Check VM Disk

Inside guest, run:

```
df -h
```

and for partition, run:

```
lsblk
```

### Resize Image

In host, run:

```
qemu-img resize <image> +5G
```

`+5G` indicates increasing 5GB disk image. You can adjust the size as needed.

### Resize Partition in Debian AMD64

In Debian guest, run:

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

and then in Debian guest run:

```
sudo resize2fs /dev/sda1
```

### Resize Partition in Debian ARM64

In Debian guest, run:

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

and then in Debian guest run:

```
sudo resize2fs /dev/vda1
```
