# termux-sh

This repository contains Shell scripts for [Termux](https://github.com/termux/termux-app), a terminal emulator for Android. These scripts include setup automation, shortcuts, installations and configurations of development tools and emulation environments such as proot, proot-distro, QEMU system emulation, and box64, and more.

## Table of Contents

* [Termux](#termux)
* [Termux Setup](#termux-setup)
  + [Prerequisites](#prerequisites)
  + [Execution](#execution)
  + [Features](#features)
  + [Invoked VM Setup Scripts](#invoked-vm-setup-scripts)
* [Shortcuts](#shortcuts)
  + [Boot VM Scripts](#boot-vm-scripts)
  + [Utility Scripts](#utility-scripts)
* [Additional Scripts](#additional-scripts)
* [My Related Repositories](#my-related-repositories)
* [TODO](#todo)
* [License](#license)
* [References](#references)

## Termux

Termux (`com.termux`) can be installed from [F-Droid](https://f-droid.org/packages/com.termux).

**WARNING**: If you installed termux from Google Play or a very old version, then you will receive package command errors. Google Play builds are deprecated and no longer supported. It is highly recommended that you update to termux-app v0.118.0 or higher as soon as possible for various bug fixes, including a critical world-readable vulnerability reported at <https://termux.github.io/general/2022/02/15/termux-apps-vulnerability-disclosures.html>. It is recommended that you shift to F-Droid or GitHub releases.

Refer to [**Android-Non-Root**](https://github.com/Willie169/Android-Non-Root) for more information.

## Termux Setup

[`termux-setup.sh`](termux-setup.sh)

### Prerequisites

<ul>
<li>Sufficient storage (calculated on Termux 0.118.3, excluding cleanable caches):
<ul>
<li>Approximately 0.2 GB for the Termux app itself.
<li>Approximately 6.4 GB in total for the minimal configuration with <code>XFCE=0</code>, <code>ANDROID=0</code>, and
<pre><code>TERMUX=''
UBUNTU=''
UBUNTUINSTALL=0
DEBIAN=''
DEBIANINSTALL=0
UBUNTUBOX=''
UBUNTUBOXINSTALL=0
DEBIANBOX=''
DEBIANBOXINSTALL=0
</code></pre></li>
<li>Approximately 0.4 GB more for <code>XFCE=1</code>.</li>
<li>Approximately 2.6 GB more for <code>ANDROID=1</code>.</li>
<li>Approximately 0.1 GB more for a nonempty <code>TERMUX</code>.</li>
<li>Approximately 0.3 GB more for a nonempty <code>UBUNTU</code>.</li>
<li>Approximately 0.2 GB more for a nonempty <code>DEBIAN</code>.</li>
<li>Approximately 31.2 GB more for <code>UBUNTUINSTALL=1</code>.</li>
<li>Approximately 31.2 GB more for <code>DEBIANINSTALL=1</code>.</li>
<li>Approximately 39.3 GB in total for the default configuration with <code>XFCE=1</code>, <code>ANDROID=1</code>, and
<pre><code>TERMUX='termux'
UBUNTU='ubuntu'
UBUNTUINSTALL=1
DEBIAN='debian'
DEBIANINSTALL=0
UBUNTUBOX=''
UBUNTUBOXINSTALL=0
DEBIANBOX=''
DEBIANBOXINSTALL=0
</code></pre></li>
</ul></li>
<li>Sufficient power supply.</li>
<li>Stable internet connection.</li>
<li>It is recommended to turn off the battery optimization for Termux.</li>
<li>It is recommended to hold wakelock while running these scripts. You can do so by opening Termux, pulling down the notification bar, and then tapping <strong>Acquire wakelock</strong> on the notification of Termux.</li>
<li>It is recommended to prevent the <code>Process completed (signal 9) - press Enter</code> error in advance. You may encounter it when using Termux, especially when running VMs. To prevent it from occuring, please read tutorial about it in my <strong>Android Non Root</strong>: <a href="https://willie169.github.io/Android-Non-Root/#process-completed-signal-9---press-enter-error">https://willie169.github.io/Android-Non-Root/#process-completed-signal-9---press-enter-error</a> for the fixes.</li>
</ul>

### Execution

<ol>
<li><pre><code>termux-setup-storage
pkg update &amp;&amp; pkg install git -y
cd ~ &amp;&amp; git clone https://github.com/Willie169/termux-sh.git
</code></pre></li>
<li>Optionally edit the variables in the beginning of <code>~/termux-sh/termux-setup.sh</code> (<code>nano</code> for example). In VM names variables, <code> </code> (space) will be replaced with <code>_</code>, names that are not allowed will be added a suffix <code>1</code>:
<pre><code>pkg install nano
nano ~/termux-sh/termux-setup.sh
</code></pre>
</li>
<li>Run the setup script:
<pre><code>bash ~/termux-sh/termux-setup.sh
</code></pre>
</li>
<li>Follow the prompts until it exits automatically.</li>
<li>Run <code>gh auth login --scopes repo,read:org,admin:org,workflow,gist,notifications,delete_repo,write:packages,read:packages</code> to login to GitHub.</li>
<li>Run <code>git config --global user.name [your_name] && git config --global user.email [your_email]</code> to config git.</li>
</ol>

### Content

The variables below refer to the variables set in the beginning of [`termux-setup.sh`](termux-setup.sh).

1. **Termux properties adjustments**: Enables external app access in `termux.properties`.
2. **Shortcut configuration**: Copies shortcuts from **[`DOTshortcuts`](DOTshortcuts)** into `~/.shortcuts` folder (for **Termux:Widget**) and `Documents.sh`, `Download.sh`, `Storage.sh` into home directory `~`. See [Shortcuts](#shortcuts) section for more information.
2. **Bashrc configuration**: Copies `~/.bashrc.d` and `~/.bashrc` from my [**bashrc**](https://github.com/Willie169/bashrc) repo (can be updated with `update_bashrc`).
2. **Termux packages installation**: Installs Termux packages set in `$PKG`. The default ones include tools for C, C++, Python3, Java21, Node.js, Rust, Go, Ruby, Perl, GitHub CLI, GitLab CLI, OpenSSL, OpenSSH, JQ, Ghostscript, FFMPEG, Maven, Zsh, PRoot, RARLAB UnRAR, Icarus Verilog, Ngspice, jpegoptim, optipng, libheif, LibWebP, ImageMagick, Inkscape, XMLStarlet, GTKWave, Matplotlib, Ninja, SciPy, SQLite 3, and more.
2. **XFCE desktop environment**: Installs TigerVNC server and XFCE desktop environment, and configures `vncserver` to launch XFCE4 desktop environment if not `XFCE=0`.
2. **Android Build Environment Setup**: Setup Android apps build environment if not `ANDROID=0` using script modified from my [**termux-android-sdk-ndk**](https://github.com/Willie169/termux-android-sdk-ndk) repo. Refer to it for more information.
2. **Vim and Neovim configuration**: Installs lazy.nvim, jupytext.nvim, and [my modified version](https://github.com/Willie169/vimrc) of [vimrc by Amir Salihefendic (amix)](https://github.com/amix/vimrc) for both Vim and Neovim if not `VIMRC=0`.
2. **NPM packages**: Installs NPM packages set in `$NPM` locally in `~` and NPM packages set in `$NPMG` globally. The default `$NPM` is `jsdom markdown-toc marked marked-gfm-heading-id node-html-markdown showdown`. The default `$NPMG` is `http-server`.
2. **Pip packages**: Installs pip packages set in `PIP`. The default one is `pipx pip-autoremove plotly pydub requests selenium==4.9.1 setuptools sympy`.
2. **Pipx packages**: Installs pip packages set in `PIPX`. The default one is `notebook jupyterlab jupytext meson`.
2. **Go packages**: Installs Go packages set in `GO`. The default one is empty.
2. **JARs**: Installs ANTLR 4 (JAR in `/usr/local/java`) if not `ANTLR=0` and PlantUML (JAR in `/usr/local/java`) if not `PLANTUML=0`.
2. **Proot-distro Termux environment**: Installs an Termux proot-distro environment with alias `$TERMUX` and add boot script `proot-$TERMUX.sh` into home directory `~` and `~/.shortcuts` folder (for **Termux:Widget**) if `$TERMUX` is not empty string.
2. **Proot-distro Ubuntu environment**: Installs an Ubuntu ARM64 proot-distro environment with alias `$UBUNTU` and add boot script `proot-$UBUNTU.sh` into home directory `~` and `~/.shortcuts` folder (for **Termux:Widget**) if `$UBUNTU` is not empty string, and runs [`ubuntu-debian.sh`](ubuntu-debian.sh) in it if `$UBUNTU` is not empty string and `$UBUNTUINSTALL` is not `0`. See [Invoked VM Setup Scripts](#invoked-vm-setup-scripts) section for more information.`ollama pull llama3.2`, 
2. **Proot-distro Debian environment**: Installs Debian ARM64 proot-distro environment with alias `$DEBIAN` and add boot script `proot-$DEBIAN.sh` into home directory `~` and `~/.shortcuts` folder (for **Termux:Widget**) if `$DEBIAN` is not empty string, and runs [`ubuntu-debian.sh`](ubuntu-debian.sh) in it if `$DEBIAN` is not empty string and `$DEBIANINSTALL` is not `0`. See [Invoked VM Setup Scripts](#invoked-vm-setup-scripts) section for more information.
2. **Proot-distro Ubuntu environment with Box64, Wine64, and Winetricks (not invoked by default)**: Installs Ubuntu ARM64 proot-distro environment with alias `$UBUNTUBOX` and add boot script `proot-$UBUNTUBOX.sh` into home directory `~` and `~/.shortcuts` folder (for **Termux:Widget**) if `$UBUNTUBOX` is not empty string, and runs [`box64-wine64-winetricks.sh`](box64-wine64-winetricks.sh) (no longer actively maintained) in it if `$UBUNTUBOX` is not empty string and `$UBUNTUBOXINSTALL` is not `0`. See [Invoked VM Setup Scripts](#invoked-vm-setup-scripts) section for more information.
2. **Proot-distro Debian environment with Box64, Wine64, and Winetricks (not invoked by default)**: Installs Debian ARM64 proot-distro environment with alias `$DEBIANBOX` and add boot script `proot-$DEBIANBOX.sh` into home directory `~` and `~/.shortcuts` folder (for **Termux:Widget**) if `$DEBIANBOX` is not empty string, and runs [`box64-wine64-winetricks.sh`](box64-wine64-winetricks.sh) (no longer actively maintained) in it if `$DEBIANBOX` is not empty string and `$DEBIANBOXINSTALL` is not `0`. See [Invoked VM Setup Scripts](#invoked-vm-setup-scripts) section for more information.

### Invoked VM Setup Scripts

These scripts will be invoked by [Termux Setup](#termux-setup) if corresponding configuration is set.

- [`ubuntu-debian.sh`](ubuntu-debian.sh): Configures PulseAudio and installs development tools, runtime environments, and utilities for C, C++, Python3, Java 21, Node.js 24 (via NVM), Yarn, Rust, Go, Ruby, Perl, Fortran, Qt5, .NET SDK 10, ASP.NET Core Runtime 10, Aptitude, GitHub CLI, OpenSSL, OpenSSH, JQ, Ghostscript, GHC Filesystem, FFMPEG, Pandoc, TeX Live (via regular installation instead of APT, for unrestricted `tlmgr` and updates), Maven, Zsh, iproute2, net-tools, nvm, pnpm, Yarn, NPM packages `jsdom markdown-toc marked marked-gfm-heading-id node-html-markdown showdown` locally in `~` and `http-server @google/gemini-cli @openai/codex` globally, Bun, Miniforge, pipx, uv, Jupyter Notebook, JupyterLab, Jupytext, Meson, lazy.nvim, jupytext.nvim, XITS fonts, Noto CJK fonts, RARLAB UnRAR, Icarus Verilog, Verilator, Ngspice, jpegoptim, optipng, libheif, LibWebP, ImageMagick, Inkscape, XMLStarlet, GTKWave, SDL2, SDL2 BGI, Aider, Ollama with `llama3.2:1b` pulled, Claude Code, Open Code, llmfit, ANTLR 4 (JAR in `/usr/local/java`), Firefox, TigerVNC server, XFCE desktop environment with fix for stuck `elementary-xfce-icon-theme` (see my [**fix-elementary-xfce-icon-theme**](https://github.com/Willie169/fix-elementary-xfce-icon-theme) repo for more information), PlantUML (JAR in `/usr/local/java`), SQLite 3, PostgreSQL 17, KataGo (`~/KataGo/cpp/katago` and can be run with `katago`) and KataGo network `kata1-b6c96-s175395328-d26788732` (in `~/katago-networks`, other networks can be downloaded from <https://katagotraining.org/networks>), LizzieYzy (can be launched by running `lizzieyzy` or with desktop entry `~/.local/share/applications/lizzieyzy.desktop` or `~/desktop/lizzieyzy.desktop`, runtime directory `~/.lizzieyzy`, KataGo network `kata1-b6c96-s175395328-d26788732` configured as default engine and estimate engine in `~/.lizzieyzy/config.txt`, which can be updated by running `update_lizzieyzy_config`), Fairy-Stockfish (`~/Fairy-Stockfish/src/stockfish` and can be run with `stockfish`), Cute Chess (GUI at `~/cutechess/build/cutechess` and can be launched by running `cutechess` or with desktop entry `~/.local/share/applications/cutechess.desktop` or `~/desktop/cutechess.desktop`, CLI at `~/cutechess/build/cutechess-cli` and can be run with `cutechess-cli`, Fairy-Stockfish configured as engine in `~/.config/cutechess/engines.json`, which can be updated by running `update_cutechess_config`), Sylvan (GUI at `~/Sylvan/projects/gui/sylvan` and can be launched by running `sylvan` or with desktop entry `~/.local/share/applications/sylvan.desktop` or `~/desktop/sylvan.desktop`, CLI at `~/Sylvan/projects/cli/sylvan-cli` and can be run with `sylvan-cli`, Fairy-Stockfish configured as engine in `~/.config/EterCyber/engines.json`, which can be updated by running `update_sylvan_config`), [my modified version](https://github.com/Willie169/vimrc) of [vimrc by Amir Salihefendic (amix)](https://github.com/amix/vimrc) for both Vim and Neovim (can be updated by running `update_vimrc`), my LaTeX package [`physics-patch`](https://github.com/Willie169/physics-patch) and my LaTeX template [`LaTeX-ToolKit`](https://github.com/Willie169/LaTeX-ToolKit) (can be updated with `update_latex`), and more, and copies `~/.bashrc.d` and `~/.bashrc` from my [**bashrc**](https://github.com/Willie169/bashrc) repo (can be updated by running `update_bashrc`), on Ubuntu or Debian ARM64 Proot environment.

- [`box64-wine64-winetricks.sh`](box64-wine64-winetricks.sh): Installs `box64`, `wine64`, and `winetricks` for running x86\_64 Linux and Windows applications on Debian derivatives ARM64. (No longer actively maintained.)

## Shortcuts

Shortcuts are located in [`DOTshortcuts`](DOTshortcuts). Some of them are intended for tools that is not installed or configured in the [Termux Setup](#termux-setup), such as QEMU. Some related scripts are in [Additional Scripts](#additional-scripts).

### Boot VM Scripts

- [`qemu-alpine-aarch64.sh`](DOTshortcuts/qemu-alpine-aarch64.sh), [`qemu-alpine-aarch64-vnc.sh`](DOTshortcuts/qemu-alpine-aarch64-vnc.sh), [`qemu-alpine-x86_64.sh`](DOTshortcuts/qemu-alpine-x86_64.sh), [`qemu-alpine-x86_64-vnc.sh`](DOTshortcuts/qemu-alpine-x86_64-vnc.sh), [`qemu-debian-aarch64.sh`](DOTshortcuts/qemu-debian-aarch64.sh), [`qemu-debian-aarch64-vnc.sh`](DOTshortcuts/qemu-debian-aarch64-vnc.sh), [`qemu-alpine-amd64.sh`](DOTshortcuts/qemu-alpine-amd64.sh), [`qemu-debian-amd64-vnc.sh`](DOTshortcuts/qemu-debian-amd64-vnc.sh), [`qemu-bliss-vnc.sh`](DOTshortcuts/qemu-bliss-vnc.sh): Boot respective QEMU system emulation VMs with `-netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1` option, where files with `-vnc` in their names start VNC server at the host's `localhost:0` and others are `-nographic`. Those VMs can be installed with [`qemu-alpine-aarch64-install.sh`](qemu-alpine-aarch64-install.sh), [`qemu-alpine-x86_64-install.sh`](qemu-alpine-x86_64-install.sh), [`qemu-debian-arm64-install.sh`](qemu-debian-arm64-install.sh), [`qemu-debian-amd64-install.sh`](qemu-debian-amd64-install.sh), and [`qemu-bliss-install.sh`](qemu-bliss-install.sh) respectively. See [Additional Scripts](#additional-scripts) for details. (No longer actively maintained.)
- [`nethunter.sh`](DOTshortcuts/nethunter.sh): Boots the Kali Nethunter proot-distro instance with the alias `kali-default` as user `kali` with `isolated` and `fix-low-ports` options.

### Utility Scripts

- [`code.sh`](DOTshortcuts/code.sh), [`download.sh`](DOTshortcuts/download.sh): `cd /storage/emulated/0/Documents/code` and `cd /storage/emulated/0/Download` respectively.
- [`xmrig.sh`](DOTshortcuts/xmrig.sh): Mines XMR to [the repository owner](https://github.com/Willie169)'s wallet, `48j6iQDeCSDeH46gw4dPJnMsa6TQzPa6WJaYbBS9JJucKqg9Mkt5EDe9nSkES3b8u7V6XJfL8neAPAtbEpmV2f4XC7bdbkv`, using [xmrig](https://github.com/xmrig/xmrig), which is not installed in the [Termux Setup](#termux-setup) and can be installed with [`xmrig-install.sh`](xmrig-install.sh). Change the wallet address and other configurations if you need.
- [`shizuku.sh`](DOTshortcuts/shizuku.sh): `cd shizuku` and `sh rish`. This is a shortcuts for [Shizuku](https://github.com/RikkaApps/Shizuku), which is not configured in the scripts in this repository. Please refer to [the section of my tutorial "Android-Non-Root" about it](https://willie169.github.io/Android-Non-Root/#shizuku-systemui-tuner-and-ashell-use-local-adb-of-android-device-on-terminals-such-as-termux-without-another-device-with-shizuku-leave-developer-options-off-when-doing-so-with-systemui-tuner-and-use-adb-with-features-like-autocomplete-suggestion-with-ashell) for more information.
- [`termux-backup-bz.sh`](DOTshortcuts/termux-backup-bz.sh): Creates a compressed bzip2 backup with the highest compression level of `/data/data/com.termux/files/home` and `/data/data/com.termux/files/usr` split into 4000MB parts.

## Additional Scripts

These scripts are not invoked by [Termux Setup](#termux-setup). Run it separately if you need it.

- [`qemu-alpine-aarch64-install.sh`](qemu-alpine-aarch64-install.sh), [`qemu-alpine-x86_64-install.sh`](qemu-alpine-x86_64-install.sh), [`qemu-debian-arm64-install.sh`](qemu-debian-arm64-install.sh), [`qemu-debian-amd64-install.sh`](qemu-debian-amd64-install.sh), [`qemu-bliss-install.sh`](qemu-bliss-install.sh): Setup and boot the respective QEMU system emulation VMs with `-netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1` option, where the Alpine VMs are created from Virt 3.21.0 ISO images and the Debian VMs are pre-created Bookworm QCOW2 images. [`qemu-bliss-install.sh`](qemu-bliss-install.sh) starts VNC server at the host's `localhost:0` and others are `-nographic`. Remember to `setup-alpine` in Alpine VMs and resize disk in Debian VMs. [Bliss OS](https://blissos.org) is an Android-based open source OS for x86\_64 architecture that incorporates many optimizations, features, and that supports many more devices. (No longer actively maintained.)
- [`xmrig-install.sh`](xmrig-install.sh): Clones and compiles [xmrig](https://github.com/xmrig/xmrig), an open source Monero (XMR) miner, on Termux.
- [`proot-install-nethunter.sh`](proot-install-nethunter.sh): Installs Kali Nethunter ARM64 proot-distro environment from [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter). Follow the screen guide and enter wanted Build ID to install, e.g., `KBDEXKMTE` for everything and `KBDEXKMTD` for default. Boot it with `<build id> [` USER `]` or `proot-distro login <build id> [` USER `]`. Open GUI after logged in with `sudo kgui`. Please go to [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter) for more information.
- [`debian-buster-xfce-mod.sh`](debian-buster-xfce-mod.sh): Modified version of [`Andronix's debian-xfce.sh`](https://github.com/AndronixApp/AndronixOrigin/blob/master/Installer%2FDebian%2Fdebian-xfce.sh), which installs and configures XFCE desktop environment and VNC server for Debian Buster ARM64 PRoot environment.
- [`proot-install-buster-cli.sh`](proot-install-buster-cli.sh): Installs Andronix Debian Buster ARM64 PRoot CLI-only environment in `~/$BUSTERCLI` if `$BUSTERCLI` is not empty string using [`Andronix's debian.sh`](https://github.com/AndronixApp/AndronixOrigin/blob/master/Installer%2FDebian%2Fdebian.sh). Configure the `BUSTERCLI` variable in the file to change the directory.
- [`proot-install-buster-xfce.sh`](proot-install-buster-xfce.sh): Installs Andronix Debian Buster ARM64 PRoot environment with XFCE desktop environment and VNC server in `~/$BUSTERXFCE` if `$BUSTERXFCE` is not empty string using [`debian-buster-xfce-mod.sh`](debian-buster-xfce-mod.sh).

## License

This repository is licensed under GNU General Public License General Public License, see [LICENSE.md](LICENSE.md) for details.

## Credits

- [https://andronix.app](https://andronix.app)
- [https://github.com/amix/vimrc](https://github.com/amix/vimrc)
- [https://github.com/AndronixApp/AndronixOrigin](https://github.com/AndronixApp/AndronixOrigin)
- [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter)
- [https://github.com/termux/proot-distro](https://github.com/termux/proot-distro)
- [https://ivonblog.com](https://ivonblog.com)
- [https://wiki.termux.com](https://wiki.termux.com)
- [https://www.qemu.org](https://www.qemu.org)
- [https://waydro.id](https://waydro.id)
