# termux-sh

This repo contains setup bash files for Termux.

- [get_started.bash](get_started.bash): Copy it and run it on Termux to automatically setup Termux using [termux_setup.bash](termux_setup.bash).
- [termux_setup.bash](termux_setup.bash): Termux setup scripts for developers, including packages, shortcuts, one Termux proot, three Debian buster ARM64 proots using Andronix's script, and download Debian bookworm AMD64 QEMU image from its official website.
- [DOTbashrc](DOTbashrc): My `.bashrc` for Termux.
- [DOTshortcuts](DOTshortcuts): Shortcuts for Termux:Widget.
- [debian1_setup.sh](debian1_setup.sh): Setup for texlive-full, will be placed in debian1's root after installation.
- [debian2_setup.sh](debian2_setup.sh): Setup for GUI, will be placed in debian2's root after installation.
- [debian3_setup.sh](debian3_setup.sh): Setup for developers, will be placed in debian3's root after installation.
- [debian_amd64.sh](debian_amd64.sh): Setup for developers on Debian AMD64. For example , you can copy is and run in the QEMU Debian bookworm AMD64 downloaded in [termux_setup.bash](termux_setup.bash).
- [qemu_resize.md](qemu_resize.md): Commands about how to resize the QEMU VM's disk space.

Look into the files for more information.