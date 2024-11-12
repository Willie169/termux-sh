# termux-sh

This repo contains setup bash files for Termux.

- [get-started.sh](get-started.sh): Copy it and run it on Termux to automatically setup Termux using [termux_setup.bash](termux_setup.bash).
- [termux-setup.sh](termux-setup.sh): Termux setup scripts for developers, including packages, shortcuts, one Termux proot, three Debian buster ARM64 proots using Andronix's script, download Debian bookworm AMD64 QEMU image from its official website, and install a proot Debian bookworm ARM64 via proot-distro.
- [DOTbashrc](DOTbashrc): My `.bashrc` for Termux.
- [DOTshortcuts](DOTshortcuts): Shortcuts for Termux:Widget.
- [debian1-setup.sh](debian1-setup.sh): Setup for texlive-full, will be placed in debian1's root after installation.
- [debian2-setup.sh](debian2-setup.sh): Setup for GUI, will be placed in debian2's root after installation.
- [debian3-setup.sh](debian3-setup.sh): Setup for developers, will be placed in debian3's root after installation.
- [debian-bookworm.sh](debian-bookworm.sh): Setup for developers for Debian bookworm. For example , you can copy it and run it in the QEMU Debian bookworm AMD64 or proot-distro Debian bookworm ARM64 installed in [termux-setup.bash](termux-setup.bash).
- [qemu-resize.md](qemu-resize.md): Commands about how to resize the QEMU VM's disk space.
- [box64-wine64-winetricks.sh](box64-wine64-winetricks.sh): Install and setup box86, box64, wine, and winetricks, run it on the Debian bookworm ARM64 installed via proot-distro.

Look into the files for more information.

References:
- [https://ivonblog.com](https://ivonblog.com).
- [https://wiki.termux.com/wiki/Main_Page](https://wiki.termux.com/wiki/Main_Page).
- [https://ryanfortner.github.io](https://ryanfortner.github.io).
- [https://www.qemu.org](https://www.qemu.org).
- [https://andronix.app](https://andronix.app).