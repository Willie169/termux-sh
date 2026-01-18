tar -cvf - /data/data/com.termux/files/home /data/data/com.termux/files/usr | pv | bzip2 -9 | pv | split -b 4000M -d -a 3 - /sdcard/termux-backup.tar.bz2.part.
