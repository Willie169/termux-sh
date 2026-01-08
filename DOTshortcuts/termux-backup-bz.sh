BZIP2='-9' tar -cvjf - /data/data/com.termux/files/home /data/data/com.termux/files/usr | split -b 4000M - /sdcard/termux-backup.tar.bz2.part
