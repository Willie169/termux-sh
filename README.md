# termux-sh

This repo contains setup bash files for Termux.

- [get-started.sh](get-started.sh): Copy it and run it on Termux to automatically setup Termux using [termux_setup.bash](termux_setup.bash).
- [termux-setup.sh](termux-setup.sh): Termux setup scripts for developers, including packages, shortcuts, one Termux proot, three Debian buster ARM64 proots using Andronix's script, download Debian bookworm AMD64 QEMU image from its official website, and install a proot-distro Debian bookworm ARM64.
- [DOTbashrc](DOTbashrc): My `.bashrc` for Termux.
- [DOTshortcuts](DOTshortcuts): Shortcuts for Termux:Widget.
- [debian1-setup.sh](debian1-setup.sh): Setup for texlive-full, will be placed in debian1's root after installation.
- [debian2-setup.sh](debian2-setup.sh): Setup for GUI, will be placed in debian2's root after installation.
- [debian3-setup.sh](debian3-setup.sh): Setup for developers, will be placed in debian3's root after installation. 
- [debian-bookworm.sh](debian-bookworm.sh): Setup for developers for Debian bookworm that is externally managed. For example, you can copy it and run it in the proot-distro Debian bookworm ARM64 and the QEMU Debian bookworm AMD64.
- [qemu-resize.md](qemu-resize.md): Commands and tutorial about how to resize the QEMU VM's disk space.
- [box64-wine64-winetricks.sh](box64-wine64-winetricks.sh): Install and setup box64, wine64, and winetricks to be ran on a Debian bookworm ARM64, such as the proot-distro Debian bookworm ARM64.
- [xmrig-install.sh](xmrig-install.sh): Clone and compile xmrig, a Monero (XMR) miner.
- [proot-install-debian01.sh](proot-install-debian01.sh): proot-distro install Debian bookworm ARM64 with overridden alias debian01.

Look into the files for more information.

References:
- [https://ivonblog.com](https://ivonblog.com).
- [https://wiki.termux.com/wiki/Main_Page](https://wiki.termux.com/wiki/Main_Page).
- [https://ryanfortner.github.io](https://ryanfortner.github.io).
- [https://www.qemu.org](https://www.qemu.org).
- [https://andronix.app](https://andronix.app).
