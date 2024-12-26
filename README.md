# termux-sh

This repository contains setup Shell scripts for automating the configuration of Termux, a terminal emulator for Android. The scripts facilitate the installation of essential tools, environment configurations, proot distributions, QEMU virtual machines, and related setups.

---

## Termux Setup

### Prerequisites

- Approximately 30GB of storage space.
- Internet connection for packages and scripts download and setup.
- It is recommended to turn off the battery optimization for Termux.
- It is recommended to hold wakelock while running these scripts. You can do so by opening Termux, pulling down the notification bar, and then tapping **Acquire wakelock** on the notification of Termux.
- It is recommended to prevent the `Process completed (signal 9) - press Enter` error in advance. You may encounter the `Process completed (signal 9) - press Enter` Error when using Termux, especially when running VMs. To prevent it from occuring, please read [my tutorial "Android Non Root" about it](https://willie169.github.io/Android-Non-Root/#process-completed-signal-9---press-enter-error) for the fixes. If you want to use the ADB command line fix, i.e. `Fix for QEMs like OneUI, MiUi, Samsung, etc. and other non-stock Android 12L and beyond` in the above-mentioned tutorial, please read [another section of my tutorial about Shizuku](https://willie169.github.io/Android-Non-Root/#shizuku-systemui-tuner-and-ashell-use-local-adb-of-android-device-on-terminals-such-as-termux-without-another-device-with-shizuku-leave-developer-options-off-when-doing-so-with-systemui-tuner-and-use-adb-with-features-like-autocomplete-suggestion-with-ashell). 

### Execution

Copy and run the following script to initialize Termux with predefined settings:
```
termux-setup-storage
termux-change-repo
pkg update && pkg install git -y
cd ~ && git clone https://github.com/Willie169/termux-sh.git
bash ~/termux-sh/termux-setup.sh
``` 

This script invokes [`termux-setup.sh`](termux-setup.sh), which installs essential packages, configures shortcuts, and sets up proot environments.

Follow the screen guide to complete it. If you see a dancing parrot, powered by [parrot.live](https://github.com/hugomd/parrot.live), on screen, pull down the notification bar and tap **exit** on the notification of Termux. Now, you can restart Termux and enjoy it.

### Key features

1. **Package installation**: Install tools for development, runtime environments, and utilities for C/C++, Python, Java, Node.js, Rust, Go, Ruby, Perl, proot, GitHub, GitLab, SSL, SSH, JQ, FFMPEG, Maven, Termux-X11, TigerVNC, XFCE4, Zsh, and more on Termux.
2. **Shortcut configuration**: Copy shortcuts from **[`DOTshortcuts`](DOTshortcuts)** into `.shortcuts` for Termux:Widget and the home directory (`~`), and then rename the [`bashrc.sh`](DOTshortcuts/.bashrc) in the home directory to `.bashrc`.
2. **Termux properties adjustments**: Enable external app access via `termux.properties`.
2. **Termux proot environment**: Install [Yonle's termux-proot](https://github.com/Yonle/termux-proot), a Termux proot environment, with [`proot-termux.sh`](DOTshortcuts/proot-termux.sh).
2. **Audio setup**: Configure audio output using [Andronix](https://andronix.app)'s `setup-audio.sh`.
2. **Fabric installation**: Install [fabric](https://github.com/danielmiessler/fabric), an open-source modular framework for augmenting humans using Al using a crowdsourced set of Al prompts.
2. **Node.js library installation**: Install `node-html-markdown`, `showdown`, and `jsdom`.
2. **Andronix Debian environments**: Create three Debian Buster ARM64 proot environments,`~/debian1`, which is CLI only, and `~/debian2`, which has XFCE and VNC server configured, using script from [Andronix](https://github.com/AndronixApp/AndronixOrigin).
2. **Proot-distro Debian environments**: Configure two Debian Bookworm ARM64 proot-distro instances with default alias, `debian`, and an overridden alias, `debianbox`, respectively.
2. **Proot-distro Ubuntu environments**: Configure an Ubuntu 24.04 ARM64 proot-distro instance with default alias, `ubuntu`.
2. **Environments setup scripts**: Executes specific configuration scripts for each proot or proot-distro instance. See [Setup Scripts](#setup-scripts) section for more information.

### Setup Scripts

These scripts are invoked by [Termux Setup](#termux-setup).

- [`proot-install-debianbox.sh`](proot-install-debianbox.sh): Installs proot-distro Debian Bookworm ARM64 instance with an overriden alias, `debianbox`.
- [`debian-dev.sh`](debian-dev.sh): Install developer tools for Debian Buster ARM64 instance, including development tools, runtime environments, and utilities for C/C++, Python3, Java 11, Node.js, Go, Ruby, Perl, GitHub, SSL, SSH, JQ, Maven, Zsh, NumPy SymPy Matplotlib, Selenium, Jupyter Notebook, Pandas, Meson, Ninja, and more. Invoked for the `debian1` proot environment in [Termux Setup](#termux-setup).
- [`debian-xfce-mod.sh`](debian-xfce-mod.sh): Modified version of [`Andronix's debian-xfce.sh`](https://github.com/AndronixApp/AndronixOrigin/blob/master/Installer%2FDebian%2Fdebian-xfce.sh), which installs and configures Debian Buster ARM64 proot environment with XFCE GUI support and related tools. Invoked for the `debian2` proot environment in [Termux Setup](#termux-setup).
- [`debian-bookworm.sh`](debian-bookworm.sh): Install developer tools for Debian Bookworm instance, including development tools, runtime environments, and utilities for C/C++, Python3, Java 17, Node.js, Rust, Go, Ruby, Perl, GitHub, SSL, SSH, Pandoc, TeX Live, Maven, NumPy SymPy Matplotlib, Selenium, Jupyter Notebook, Pandas, Meson, Ninja, Noto Sans CJK, STIX Two Math, and more. It is compatible with both QEMU and Proot setups. Invoked for the Debian Bookworm ARM64 proot-distro instance with the default alias, `debian`, in [Termux Setup](#termux-setup).
- [`box64-wine64-winetricks.sh`](box64-wine64-winetricks.sh): Install `box64`, `wine64`, and `winetricks` for running x86_64 Linux and Windows applications on an ARM64 Linux instance. Invoked for the Debian Bookworm ARM64 proot-distro instance with the overriden alias, `debianbox`, in [Termux Setup](#termux-setup).
- [`ubuntu-24-04.sh`](ubuntu-24-04.sh): Install developer tools for Ubuntu 24.04 instance, including development tools, runtime environments, and utilities for C/C++, Python3, Java 17, Node.js, Rust, Go, Ruby, Perl, GitHub, SSL, SSH, JQ, Maven, NumPy SymPy Matplotlib, Selenium, Jupyter Notebook, Pandas, Meson, Ninja, and more. Invoked for the Ubuntu 24.04 ARM64 proot-distro instance with the default alias, `ubuntu`, in [Termux Setup](#termux-setup).

---

## Shortcuts

Shortcuts are located in [`DOTshortcuts`](DOTshortcuts). Some of them are intended for tools that is not installed or configured in the [Termux Setup](#termux-setup), such as QEMU. Some related scripts and instructions are in [Additional Scripts and Instructions](#additional-scripts-and-instructions).

### Boot VM Scripts

- [`debian1.sh`](DOTshortcuts/debian1.sh), [`debian2.sh`](DOTshortcuts/debian2.sh): Boot respective Debian Buster ARM64 proot environments.
- [`qemu-alpine-aarch64.sh`](DOTshortcuts/qemu-alpine-aarch64.sh), [`qemu-alpine-aarch64-vnc.sh`](DOTshortcuts/qemu-alpine-aarch64-vnc.sh), [`qemu-alpine-x86_64.sh`](DOTshortcuts/qemu-alpine-x86_64.sh), [`qemu-alpine-x86_64-vnc.sh`](DOTshortcuts/qemu-alpine-x86_64-vnc.sh), [`qemu-debian-aarch64.sh`](DOTshortcuts/qemu-debian-aarch64.sh), [`qemu-debian-aarch64-vnc.sh`](DOTshortcuts/qemu-debian-aarch64-vnc.sh), [`qemu-alpine-amd64.sh`](DOTshortcuts/qemu-alpine-amd64.sh), [`qemu-debian-amd64-vnc.sh`](DOTshortcuts/qemu-debian-amd64-vnc.sh), [`qemu-bliss-vnc.sh`](DOTshortcuts/qemu-bliss-vnc.sh): Boot respective QEMU system emulation VMs with `-netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1` option, where files with `-vnc` in their names start VNC server at the host's `localhost:0` and others are `-nographic`. Those VMs can be installed with [`qemu-alpine-aarch64-install.sh`](qemu-alpine-aarch64-install.sh), [`qemu-alpine-x86_64-install.sh`](qemu-alpine-x86_64-install.sh), [`qemu-debian-arm64-install.sh`](qemu-debian-arm64-install.sh), [`qemu-debian-amd64-install.sh`](qemu-debian-amd64-install.sh), and [`qemu-bliss-install.sh`](qemu-bliss-install.sh) respectively. See [Additional Scripts and Instructions](#additional-scripts-and-instructions) for details.
- [`proot-debian.sh`](DOTshortcuts/proot-debian.sh), [`proot-debianbox.sh`](DOTshortcuts/proot-debianbox.sh): Boot respective Debian Bookworm ARM64 proot-distro instances with `isolated` and `fix-low-ports` options.
- [`nethunter.sh`](DOTshortcuts/nethunter.sh): Boot the Kali Nethunter proot-distro instance with the alias `kali-default` as user `kali` with `isolated` and `fix-low-ports` options.
- [`proot-termux.sh`](DOTshortcuts/proot-termux.sh): Boot the Termux proot.

### Utility Scripts

- [`bashrc.sh`](DOTshortcuts/bashrc.sh): A customized `.bashrc` for Termux with pre-defined aliases, functions, and environment variables for Tor, Git, Go, ANTLR4, etc.
- [`gitPull.sh`](DOTshortcuts/gitPull.sh): `git pull` all repositories in `~/gh`.
- [`code.sh`](DOTshortcuts/code.sh), [`download.sh`](DOTshortcuts/download.sh): `cd /storage/emulated/0/Documents/code` and `cd /storage/emulated/0/Download` respectively.
- [`xmrig.sh`](DOTshortcuts/xmrig.sh): Mine XMR to [the repository owner](https://github.com/Willie169)'s wallet, `48j6iQDeCSDeH46gw4dPJnMsa6TQzPa6WJaYbBS9JJucKqg9Mkt5EDe9nSkES3b8u7V6XJfL8neAPAtbEpmV2f4XC7bdbkv`, using [xmrig](https://github.com/xmrig/xmrig), which is not installed in the [Termux Setup](#termux-setup) and can be installed with [`xmrig-install.sh`](xmrig-install.sh). Change the wallet address and other configurations if you need.
- [`shizuku.sh`](DOTshortcuts/shizuku.sh): `cd shizuku` and `sh rish`. This is a shortcuts for [Shizuku](https://github.com/RikkaApps/Shizuku), which is not configured in the scripts in this repository. Please read [the section of my tutorial about Shizuku](https://willie169.github.io/#shizuku-systemui-tuner-and-ashell-use-local-adb-of-android-device-on-terminals-such-as-termux-without-another-device-with-shizuku-leave-developer-options-off-when-doing-so-with-systemui-tuner-and-use-adb-with-features-like-autocomplete-suggestion-with-ashell) for more information.
- [`termux-backup-bz.sh`](DOTshortcuts/termux-backup-bz.sh): Create a compressed backup with the highest compression level of BZIP2 of the `/data/data/com.termux/files/home` and `/data/data/com.termux/files/usr`, then splits the resulting archive into parts, each 4000MB in size.
- [`android-backup-bz.sh`](DOTshortcuts/android-backup-bz.sh): Create a compressed backup with the highest compression level of BZIP2 of the `/storage/emulated/0/Files`, `/storage/emulated/0/DCIM`, `/storage/emulated/0/Pictures`, `/storage/emulated/0/Alarms`, and `/storage/emulated/0/Documents`, then splits the resulting archive into parts, each 4000MB in size.
- [`start-audio.sh`](start-audio.sh): Start sound output from Termux. Configured in [Termux Setup](#termux-setup) according to [https://docs.andronix.app/troubleshoot/sound](https://docs.andronix.app/troubleshoot/sound).

---

## Additional Scripts and Instructions

These scripts are not invoked by [Termux Setup](#termux-setup). Run it separately if you need it.

- [`qemu-alpine-aarch64-install.sh`](qemu-alpine-aarch64-install.sh), [`qemu-alpine-x86_64-install.sh`](qemu-alpine-x86_64-install.sh), [`qemu-debian-arm64-install.sh`](qemu-debian-arm64-install.sh), [`qemu-debian-amd64-install.sh`](qemu-debian-amd64-install.sh), [`qemu-bliss-install.sh`](qemu-bliss-install.sh): Setup amd boot the respective QEMU system emulation VMs with `-netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1` option, where the Alpine VMs are created from Virt 3.21.0 ISO images and the Debian VMs are pre-created Bookworm QCOW2 images. [`qemu-bliss-install.sh`](qemu-bliss-install.sh) starts VNC server at the host's `localhost:0` and others are `-nographic`. Remember to `setup-alpine` in Alpine VMs and resize disk in Debian VMs. [Bliss OS](https://blissos.org) is an Android-based open source OS for x86_64 architecture that incorporates many optimizations, features, and that supports many more devices. 
- [`qemu-resize.md`](qemu-resize.md): Provide instructions and scripts for resizing QEMU images.
- [`alpine-docker.sh`](alpine-docker.sh): Install Docker on an Alpine machine and run hello-world.
- [`debian-waydroid.sh`](debian-waydroid.sh): Install [Waydroid](https://waydro.id) on Debian derivatives such as the QEMU Debian VMs. Waydroid is a container-based approach to boot a full Android system in a Linux namespace on a GNU/Linux-based platform.
- [`xmrig-install.sh`](xmrig-install.sh): Clone and compile [xmrig](https://github.com/xmrig/xmrig), an open source Monero (XMR) miner.
- [`proot-install-nethunter.sh`](proot-install-nethunter.sh): Install the Kali Nethunter ARM64 proot-distro instance from [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter). Follow the screen guide and enter wanted Build ID to install. For example, `KBDEXKMTE` for everything, which occupies about 34GB, and `KBDEXKMTD` for default, which occupies about 13GB. Boot it with `<build id> [` USER `]` or `proot-distro login <build id> [` USER `]`. Open GUI after logged in with `sudo kgui`. Please go to [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter) for more information.

---

## TODO

- Migrate to `config.json` to make this project more customizable.
- Modularize scripts for flexibility and reusability.
- Expand VMs and development tools support.

---

## License

This repository is licensed under GNU General Public License General Public License, see [LICENSE.md](LICENSE.md) for details.

---

## References

- [https://alpinelinux.org](https://alpinelinux.org).
- [https://andronix.app](https://andronix.app).
- [https://blissos.org](https://blissos.org).
- [https://github.com/AndronixApp/AndronixOrigin](https://github.com/AndronixApp/AndronixOrigin).
- [https://github.com/cyberkernelofficial/docker-in-termux](https://github.com/cyberkernelofficial/docker-in-termux).
- [https://github.com/diogok/termux-qemu-alpine-docker](https://github.com/diogok/termux-qemu-alpine-docker).
- [https://github.com/hugomd/parrot.live](https://github.com/hugomd/parrot.live).
- [https://github.com/notofonts/noto-cjk](https://github.com/notofonts/noto-cjk).
- [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter).
- [https://github.com/stipub/stixfonts](https://github.com/stipub/stixfonts).
- [https://github.com/termux/proot-distro](https://github.com/termux/proot-distro).
- [https://github.com/termux/termux-app](https://github.com/termux/termux-app).
- [https://github.com/termux/termux-widget](https://github.com/termux/termux-widget).
- [https://github.com/willie169/Android-Non-Root](https://github.com/willie169/Android-Non-Root).
- [https://github.com/zanjie1999/windows-fonts](https://github.com/zanjie1999/windows-fonts).
- [https://ivonblog.com](https://ivonblog.com).
- [https://ryanfortner.github.io](https://ryanfortner.github.io).
- [https://wiki.termux.com](https://wiki.termux.com).
- [https://willie169.github.io](https://willie169.github.io).
- [https://www.debian.org](https://www.debian.org).
- [https://www.docker.com](https://www.docker.com).
- [https://www.qemu.org](https://www.qemu.org).
- [https://waydro.id](https://waydro.id).
