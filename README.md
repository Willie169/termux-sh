# termux-sh

This repository contains setup bash files for Termux.

- [get-started.sh](get-started.sh): Copy and run it on Termux to setup Termux for developing using [termux-setup-all.sh](termux-setup-all.sh).
- [termux-setup.sh](termux-setup.sh): Termux setup script for developing, including installing packages, copying shortcuts for Termux:Widget and in `~`, installng one Termux proot with [termux-proot.sh](DOTshortcuts/termux-proot.sh), which can be booted using the same shortcut, installing three Debian buster ARM64 proot with [Andronix](https://github.com/AndronixApp/AndronixOrigin)'s scripts in three folders in `~` named debian1, debian2, and debian3, downloading [Debian bookworm AMD64 QEMU image from its official website](https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-nocloud-amd64.qcow2), and installing a proot-distro Debian bookworm ARM64.
- [termux-setup-all.sh](termux-setup-all.sh): Same as [termux-setup.sh](termux-setup.sh) but with setup for each VM installed except Debian bookworm AMD64 QEMU image using [debian1-setup.sh](debian1-setup.sh), [debian2-setup.sh](debian2-setup.sh), [debian3-setup.sh](debian3-setup.sh) for each Andronix Debian buster ARM64, [debian-bookworm.sh](debian-bookworm.sh) and [box64-wine64-winetricks.sh](box64-wine64-winetricks.sh) for proot-distro Debian bookworm ARM64.
- [DOTbashrc](DOTbashrc): `.bashrc` for Termux.
- [DOTshortcuts](DOTshortcuts): Shortcuts for Termux:Widget and in `~`. [debian1.sh](DOTshortcuts/debian1.sh) to boot Debian buster ARM64 with in `~/debian1`, [debian2.sh](DOTshortcuts/debian2.sh) to boot Debian buster ARM64 with in `~/debian2`, [debian3.sh](DOTshortcuts/debian3.sh) to boot Debian buster ARM64 with in `~/debian3`, [kali.sh](DOTshortcuts/kali.sh) to boot Kali nethunter KBDEXKMTE with user `kali`, [termux-proot.sh](DOTshortcuts/termux-proot.sh) to boot Termux proot, [proot-debian.sh](DOTshortcuts/debian.sh) to boot proot-distro Debian bookworm ARM64, [proot-debian01.sh](DOTshortcuts/debian01.sh) to boot proot-distro Debian bookworm ARM64 whose alias is overriden as debian01, all assuming installed; [gitPull.sh](DOTshortcuts/gitPull.sh) to `git pull` all git repositories in `~/gh`.
- [debian1-setup.sh](debian1-setup.sh): Setup for texlive-full, will be placed in debian1's root after installation.
- [debian2-setup.sh](debian2-setup.sh): Setup for GUI, will be placed in debian2's root after installation.
- [debian3-setup.sh](debian3-setup.sh): Setup for developers, will be placed in debian3's root after installation. 
- [debian-bookworm.sh](debian-bookworm.sh): Setup for developers for Debian bookworm that is externally managed. For example, you can copy and run it in the proot-distro Debian bookworm ARM64 and the QEMU Debian bookworm AMD64.
- [qemu-resize.md](qemu-resize.md): Commands and tutorial about how to resize a QEMU VM's disk space.
- [box64-wine64-winetricks.sh](box64-wine64-winetricks.sh): Install and setup box64, wine64, and winetricks to be ran on a Debian bookworm ARM64, such as the proot-distro Debian bookworm ARM64.
- [xmrig-install.sh](xmrig-install.sh): Clone and compile xmrig, the official Monero (XMR) miner. It is not used by other setup scripts so run it separately if you need.
- [proot-install-debian01.sh](proot-install-debian01.sh): Install proot-distro Debian bookworm ARM64 with overridden alias "debian01".
- [proot-install-nethunter.sh](proot-install-nethunter.sh): Install proot-distro Kali Linux nethunter ARM64 from [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter). Enter Build ID after it, "KBDEXKMTE" for everything. The script will add a user named `kali` alongside with `root`. Boot it with `<build id> [ USER ]` or `proot-distro login <build id> [ USER ]`. Open GUI after logged in with `sudo kgui`.

Look into the files for more information.

References:
- [https://ivonblog.com](https://ivonblog.com).
- [https://github.com/termux/termux-app](https://github.com/termux/termux-app).
- [https://wiki.termux.com](https://wiki.termux.com).
- [https://ryanfortner.github.io](https://ryanfortner.github.io).
- [https://www.qemu.org](https://www.qemu.org).
- [https://andronix.app](https://andronix.app).
- [https://github.com/AndronixApp/AndronixOrigin](https://github.com/AndronixApp/AndronixOrigin).
- [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter).
