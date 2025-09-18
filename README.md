# termux-sh

This repository contains Shell scripts for [Termux](https://github.com/termux/termux-app), a terminal emulator for Android. These scripts include setup automation, shortcuts, installations and configurations of development tools and emulation environments such as proot, proot-distro, QEMU system emulation, and box64, and more.

My tutorials for Termux, some of my scripts in this repository, and other related stuff are in [**Android-Non-Root**](https://github.com/Willie169/Android-Non-Root), which includes tutorials for a range of powerful, open-source tools such as [Termux](https://github.com/termux/termux-app), [F-Droid](https://f-droid.org), [Shizuku](https://github.com/RikkaApps/Shizuku), [Tor](https://www.torproject.org), [TrackerControl](https://github.com/TrackerControl/tracker-control-android), [InviZible Pro](https://github.com/Gedsh/InviZible), [QEMU](https://www.qemu.org), [Tailscale](https://github.com/tailscale/tailscale), [OpenSSH](https://www.openssh.com), and [PipePipe](https://github.com/InfinityLoop1308/PipePipe) to enhance Android device’s functionality, security, privacy, and customization without the need for root access.


---

## Termux Setup ([`termux-setup.sh`](termux-setup.sh))

### Prerequisites

- Approximately 18.5GB of storage space for default configuration. Approximately 30.1GB of storage space if none of `UBUNTU`, `DEBIANBOX`, `BUSTERCLI`, and `BUSTERXFCE` is empty string, and none of `DEBIANINSTALL`, `UBUNTUINSTALL`, `DEBIANBOXINSTALL`, and `BUSTERCLIINSTALL` is `0`.
- Internet connection for packages and scripts download.
- It is recommended to turn off the battery optimization for Termux.
- It is recommended to hold wakelock while running these scripts. You can do so by opening Termux, pulling down the notification bar, and then tapping **Acquire wakelock** on the notification of Termux.
- It is recommended to prevent the `Process completed (signal 9) - press Enter` error in advance. You may encounter it when using Termux, especially when running VMs. To prevent it from occuring, please read my tutorial **Android Non Root** about it: <https://willie169.github.io/Android-Non-Root/#process-completed-signal-9---press-enter-error> for the fixes.

### Execution

<ol>
<li>In <code>termux-change-repo</code>, it is recommended to choose a mirror close to your geographic location:
<pre><code>termux-setup-storage
termux-change-repo
pkg update &amp;&amp; pkg install git -y
cd ~ &amp;&amp; git clone https://github.com/Willie169/termux-sh.git
</code></pre>
</li>
<li>Optionally edit the variables in the beginning of <code>~/termux-sh/termux-setup.sh</code> (<code>nano</code> for example). In VM names variables, <code> </code> (space) will be replaced with <code>_</code>, names that are not allowed will be added a suffix <code>1</code>:
<pre><code>pkg install nano
nano ~/termux-sh/termux-setup.sh
</code></pre>
</li>
<li>Run the setup script:
<pre><code>bash ~/termux-sh/termux-setup.sh
</code></pre>
</li>
</ol>

[`termux-setup.sh`](termux-setup.sh) will install essential packages, configures shortcuts, and sets up VMs in Termux.

Follow the screen guide to complete it. If you see a dancing parrot on screen, which is powered by [parrot.live](https://github.com/hugomd/parrot.live), pull down the notification bar and tap **exit** on the notification of Termux. Now, you can restart Termux and enjoy it.

### Features

The variables below refer to the variables set in the beginning of [`termux-setup.sh`](termux-setup.sh).

1. **Termux packages installation**: Installs Termux packages set in `$PKG`. The default one includes tools for C/C++, Python3, Java17, Java21, Node.js, Yarn, Rust, Go, Ruby, Perl, GitHub CLI, GitLab CLI, OpenSSL, OpenSSH, JQ, Ghostscript, FFMPEG, Maven, Zsh, Termux-X11, TigerVNC, XFCE4, PRoot, RARLAB UnRAR, and more.
2. **Shortcut configuration**: Copies shortcuts (including all VM-boosting shortcuts even if those VMs are not configured to be installed) from **[`DOTshortcuts`](DOTshortcuts)** into `.shortcuts` (for **Termux:Widget**) and the home directory (`~`) and renames [`~/bashrc.sh`](DOTshortcuts/.bashrc) to `~/.bashrc`.
2. **Vim configuration**: Put the following in `./vimrc` if not `VIMRC=0`:
```
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
filetype plugin indent on
```
2. **Termux properties adjustments**: Enables external app access in `termux.properties`.
2. **Termux proot environment**: Installs [Yonle's termux-proot](https://github.com/Yonle/termux-proot), a Termux proot environment, with [`proot-termux.sh`](DOTshortcuts/proot-termux.sh), if not `PROOTTERMUX=0`.
2. **Audio setup**: Configures audio output using [Andronix](https://andronix.app)'s `setup-audio.sh` if not `AUDIO=0`.
2. **Node.js packages installation**: Installs NPM packages set in `$NPM`. The default is 
`jsdom marked marked-gfm-heading-id node-html-markdown markdown-toc showdown`.
2. **Fabric installation**: Installs Go package [fabric](https://github.com/danielmiessler/fabric), an open-source modular framework for augmenting humans using Al using a crowdsourced set of Al prompts.
2. **Proot-distro Debian Bookworm environment with development tools**: Configures Debian Bookworm ARM64 proot-distro instance with alias `$DEBIAN` if `$DEBIAN` is not empty string, and install development tools in it if `$DEBIAN` is not empty string and `$DEBIANINSTALL` is not `0`.
2. **Proot-distro Ubuntu environment with development tools**: Configures an Ubuntu 24.04 ARM64 proot-distro instance with alias `$UBUNTU` if `$UBUNTU` is not empty string, and install development tools in it if `$UBUNTU` is not empty string and `$UBUNTUINSTALL` is not `0`.
2. **Proot-distro Debian Bookworm environment with Box64, Wine64, and Winetricks**: Configures Debian Bookworm ARM64 proot-distro instance with alias `$DEBIANBOX` if `$DEBIANBOX` is not empty string, and install Box64, Wine64, and Winetricks in it if `$DEBIANBOX` is not empty string and `$DEBIANBOXINSTALL` is not `0`.
2. **Andronix Debian Buster CLI-only environment with development tools**: Creates CLI-only Debian Buster ARM64 proot environments in `~/$BUSTERCLI` if `$BUSTERCLI` is not empty string, using scripts from [Andronix](https://github.com/AndronixApp/AndronixOrigin), and install development tools in it if `$BUSTERCLI` is not empty string and `$BUSTERCLIINSTALL` is not `0`.
2. **Andronix Debian Buster environment with XFCE and VNC**: Creates Debian Buster ARM64 proot environments with XFCE and VNC server configured in `~/$BUSTERXFCE` if `$BUSTERXFCE` is not empty string, using scripts from [Andronix](https://github.com/AndronixApp/AndronixOrigin).

Go to [VM Setup Scripts](#setup-scripts) for more details of the VM setup scripts invoked in [`termux-setup.sh`](termux-setup.sh).

### VM Setup Scripts

These scripts will be invoked by [Termux Setup](#termux-setup) if corresponding configuration is set.

- [`debian-buster-xfce-mod.sh`](debian-buster-xfce-mod.sh): Modified version of [`Andronix's debian-xfce.sh`](https://github.com/AndronixApp/AndronixOrigin/blob/master/Installer%2FDebian%2Fdebian-xfce.sh), which installs and configures XFCE GUI and VNC server support and related tools for Debian Buster ARM64 proot environment. Invoked for the `$BUSTERXFCE` Debian Buster proot environment.
- [`debian-bookworm.sh`](debian-bookworm.sh): Installs developer tools for Debian Bookworm proot environment, including development tools, runtime environments, and utilities for C/C++, Python3, Java 17, Node.js, Yarn, Rust, Go, Ruby, Perl, GitHub, FFmpeg, SSL, SSH, Pandoc, TeX Live, Node.js packages, Python3 packages, pipx, Poetry, XITS fonts, Noto CJK fonts, UnRAR-free, custom `~/.bashrc`, custom `~/.vimrc`, and more. The installation of fonts is compatible with my LaTeX template in [LaTeX-ToolKit](https://github.com/Willie169/LaTeX-ToolKit). Invoked for the Debian Bookworm ARM64 proot-distro instance with alias `$DEBIAN`.
- [`box64-wine64-winetricks.sh`](box64-wine64-winetricks.sh): Installs `box64`, `wine64`, and `winetricks` for running x86\_64 Linux and Windows applications on an ARM64 Linux instance. Invoked for the Debian Bookworm ARM64 proot-distro instance with alias `$DEBIANBOX`.
- [`ubuntu-24-04.sh`](ubuntu-24-04.sh): Installs developer tools for Ubuntu 24.04 proot environment, including development tools, runtime environments, and utilities for C/C++, Python3, Java 8, Java 11, Java 17, Java 21, Node.js, Rust, Go, Ruby, Perl, GitHub, FFmpeg, SSL, SSH, Pandoc, TeX Live, Node.js packages, Python3 packages, pipx, Poetry, XITS fonts, Noto CJK fonts, RARLAB UnRAR, custom `~/.bashrc`, custom `~/.vimrc`, and more. The installation of fonts is compatible with my LaTeX template in [LaTeX-ToolKit](https://github.com/Willie169/LaTeX-ToolKit). Invoked for the Ubuntu 24.04 ARM64 proot-distro instance with alias `$UBUNTU`.

---

## Shortcuts

Shortcuts are located in [`DOTshortcuts`](DOTshortcuts). Some of them are intended for tools that is not installed or configured in the [Termux Setup](#termux-setup), such as QEMU. Some related scripts are in [Additional Scripts](#additional-scripts).

### Boot VM Scripts

- [`qemu-alpine-aarch64.sh`](DOTshortcuts/qemu-alpine-aarch64.sh), [`qemu-alpine-aarch64-vnc.sh`](DOTshortcuts/qemu-alpine-aarch64-vnc.sh), [`qemu-alpine-x86_64.sh`](DOTshortcuts/qemu-alpine-x86_64.sh), [`qemu-alpine-x86_64-vnc.sh`](DOTshortcuts/qemu-alpine-x86_64-vnc.sh), [`qemu-debian-aarch64.sh`](DOTshortcuts/qemu-debian-aarch64.sh), [`qemu-debian-aarch64-vnc.sh`](DOTshortcuts/qemu-debian-aarch64-vnc.sh), [`qemu-alpine-amd64.sh`](DOTshortcuts/qemu-alpine-amd64.sh), [`qemu-debian-amd64-vnc.sh`](DOTshortcuts/qemu-debian-amd64-vnc.sh), [`qemu-bliss-vnc.sh`](DOTshortcuts/qemu-bliss-vnc.sh): Boot respective QEMU system emulation VMs with `-netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1` option, where files with `-vnc` in their names start VNC server at the host's `localhost:0` and others are `-nographic`. Those VMs can be installed with [`qemu-alpine-aarch64-install.sh`](qemu-alpine-aarch64-install.sh), [`qemu-alpine-x86_64-install.sh`](qemu-alpine-x86_64-install.sh), [`qemu-debian-arm64-install.sh`](qemu-debian-arm64-install.sh), [`qemu-debian-amd64-install.sh`](qemu-debian-amd64-install.sh), and [`qemu-bliss-install.sh`](qemu-bliss-install.sh) respectively. See [Additional Scripts](#additional-scripts) for details.
- [`nethunter.sh`](DOTshortcuts/nethunter.sh): Boots the Kali Nethunter proot-distro instance with the alias `kali-default` as user `kali` with `isolated` and `fix-low-ports` options.
- [`proot-termux.sh`](DOTshortcuts/proot-termux.sh): Boot the Termux proot.

### Utility Scripts

- [`bashrc.sh`](DOTshortcuts/bashrc.sh): A customized `.bashrc` for Termux with pre-defined aliases, functions, and environment variables for Tor, Git, Go, ANTLR4, etc.
- [`vimrc`](DOTshortcuts/vimrc): A customized `.vimrc`.
- [`gitPull.sh`](DOTshortcuts/gitPull.sh): `git pull` all repositories in `~/gh`.
- [`code.sh`](DOTshortcuts/code.sh), [`download.sh`](DOTshortcuts/download.sh): `cd /storage/emulated/0/Documents/code` and `cd /storage/emulated/0/Download` respectively.
- [`xmrig.sh`](DOTshortcuts/xmrig.sh): Mines XMR to [the repository owner](https://github.com/Willie169)'s wallet, `48j6iQDeCSDeH46gw4dPJnMsa6TQzPa6WJaYbBS9JJucKqg9Mkt5EDe9nSkES3b8u7V6XJfL8neAPAtbEpmV2f4XC7bdbkv`, using [xmrig](https://github.com/xmrig/xmrig), which is not installed in the [Termux Setup](#termux-setup) and can be installed with [`xmrig-install.sh`](xmrig-install.sh). Change the wallet address and other configurations if you need.
- [`shizuku.sh`](DOTshortcuts/shizuku.sh): `cd shizuku` and `sh rish`. This is a shortcuts for [Shizuku](https://github.com/RikkaApps/Shizuku), which is not configured in the scripts in this repository. Please refer to [the section of my tutorial "Android-Non-Root" about it](https://willie169.github.io/Android-Non-Root/#shizuku-systemui-tuner-and-ashell-use-local-adb-of-android-device-on-terminals-such-as-termux-without-another-device-with-shizuku-leave-developer-options-off-when-doing-so-with-systemui-tuner-and-use-adb-with-features-like-autocomplete-suggestion-with-ashell) for more information.
- [`termux-backup-bz.sh`](DOTshortcuts/termux-backup-bz.sh): Creates a compressed backup with the highest compression level of BZIP2 of the `/data/data/com.termux/files/home` and `/data/data/com.termux/files/usr`, then splits the resulting archive into parts, each 4000MB in size.
- [`android-backup-bz.sh`](DOTshortcuts/android-backup-bz.sh): Creates a compressed backup with the highest compression level of BZIP2 of the `/storage/emulated/0/Files`, `/storage/emulated/0/DCIM`, `/storage/emulated/0/Pictures`, `/storage/emulated/0/Alarms`, and `/storage/emulated/0/Documents`, then splits the resulting archive into parts, each 4000MB in size.
- [`start-audio.sh`](start-audio.sh): Starts sound output from Termux. Configured in [Termux Setup](#termux-setup) according to [https://docs.andronix.app/troubleshoot/sound](https://docs.andronix.app/troubleshoot/sound).

---

## Additional Scripts

These scripts are not invoked by [Termux Setup](#termux-setup). Run it separately if you need it.

- [`qemu-alpine-aarch64-install.sh`](qemu-alpine-aarch64-install.sh), [`qemu-alpine-x86_64-install.sh`](qemu-alpine-x86_64-install.sh), [`qemu-debian-arm64-install.sh`](qemu-debian-arm64-install.sh), [`qemu-debian-amd64-install.sh`](qemu-debian-amd64-install.sh), [`qemu-bliss-install.sh`](qemu-bliss-install.sh): Setup and boot the respective QEMU system emulation VMs with `-netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1` option, where the Alpine VMs are created from Virt 3.21.0 ISO images and the Debian VMs are pre-created Bookworm QCOW2 images. [`qemu-bliss-install.sh`](qemu-bliss-install.sh) starts VNC server at the host's `localhost:0` and others are `-nographic`. Remember to `setup-alpine` in Alpine VMs and resize disk in Debian VMs. [Bliss OS](https://blissos.org) is an Android-based open source OS for x86\_64 architecture that incorporates many optimizations, features, and that supports many more devices. 
- [`alpine-docker.sh`](alpine-docker.sh): Installs Docker on an Alpine machine and run hello-world.
- [`debian-waydroid.sh`](debian-waydroid.sh): Installs [Waydroid](https://waydro.id) on Debian derivatives such as the QEMU Debian VMs. Waydroid is a container-based approach to boot a full Android system in a Linux namespace on a GNU/Linux-based platform.
- [`xmrig-install.sh`](xmrig-install.sh): Clones and compiles [xmrig](https://github.com/xmrig/xmrig), an open source Monero (XMR) miner.
- [`proot-install-nethunter.sh`](proot-install-nethunter.sh): Installs the Kali Nethunter ARM64 proot-distro instance from [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter). Follow the screen guide and enter wanted Build ID to install. For example, `KBDEXKMTE` for everything, which occupies about 34GB, and `KBDEXKMTD` for default, which occupies about 13GB. Boot it with `<build id> [` USER `]` or `proot-distro login <build id> [` USER `]`. Open GUI after logged in with `sudo kgui`. Please go to [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter) for more information.

---

## TODO

- Make the configuration in [termux-setup.sh](termux-setup.sh) more customizable.
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
- [https://github.com/termux/proot-distro](https://github.com/termux/proot-distro).
- [https://github.com/termux/termux-app](https://github.com/termux/termux-app).
- [https://github.com/termux/termux-widget](https://github.com/termux/termux-widget).
- [https://github.com/willie169/Android-Non-Root](https://github.com/willie169/Android-Non-Root).
- [https://github.com/Willie169/LaTeX-ToolKit](https://github.com/Willie169/LaTeX-ToolKit).
- [https://github.com/zanjie1999/windows-fonts](https://github.com/zanjie1999/windows-fonts).
- [https://ivonblog.com](https://ivonblog.com).
- [https://ryanfortner.github.io](https://ryanfortner.github.io).
- [https://wiki.termux.com](https://wiki.termux.com).
- [https://willie169.github.io](https://willie169.github.io).
- [https://www.debian.org](https://www.debian.org).
- [https://www.docker.com](https://www.docker.com).
- [https://www.qemu.org](https://www.qemu.org).
- [https://waydro.id](https://waydro.id).
