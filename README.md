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
<li>Sufficient storage: (calculated using GitHub Action, typically a bit less than that on a real device)
<ul>
<li>Previous rows remain default with
<pre><code>TERMUX='termux'
UBUNTU='ubuntu'
UBUNTUINSTALL=0
DEBIAN='debian'
DEBIANINSTALL=0
UBUNTUBOX=''
UBUNTUBOXINSTALL=0
DEBIANBOX=''
DEBIANBOXINSTALL=0
</code></pre>
: approximately 13.25 GB.</li>
<li><code>UBUNTUINSTALL=1</code>: approximately 22.71 GB.</li>
<li><code>DEBIANINSTALL=1</code>: approximately 22.71 GB.</li>
</ul></li>
<li>Sufficient power supply.</li>
<li>Stable internet connection.</li>
<li>It is recommended to turn off the battery optimization for Termux.</li>
<li>It is recommended to hold wakelock while running these scripts. You can do so by opening Termux, pulling down the notification bar, and then tapping <strong>Acquire wakelock</strong> on the notification of Termux.</li>
<li>It is recommended to disable phantom process killer to prevent <code>Process completed (signal 9) - press Enter</code> error from occuring when using Termux in advance. If you have setup Shizuku with <code>rish</code> available in Termux to access interactive ADB shell, you can simply run <a href="disable-phantom-process-killer-rish.sh"><code>disable-phantom-process-killer-rish.sh</code></a> in this repo. If you have ADB connected with <code>adb shell</code> available, you can simply run <a href="disable-phantom-process-killer-adb.sh"><code>disable-phantom-process-killer-adb.sh</code></a> in this repo. Otherwise, refer to my guide about it in my <a href="https://github.com/Willie169/Android-Non-Root#process-completed-signal-9---press-enter-error"><strong>Android Non Root repo</strong></a> or <a href="https://willie169.github.io/Android-Non-Root/#process-completed-signal-9---press-enter-error"><strong>Android Non Root site</strong></a>.</li>
</ul>

### Execution

<ol>
<li>It is suggested to run <code>termux-change-repo</code> and select repo(s) closer to your geographical location for faster download.</li>
<li><pre><code>termux-setup-storage
pkg update && pkg install git -y
cd ~ && git clone https://github.com/Willie169/termux-sh.git
</code></pre></li>
<li>Optionally edit the variables in the beginning of <code>~/termux-sh/termux-setup.sh</code> (e.g. <code>pkg install nano -y && nano ~/termux-sh/termux-setup.sh</code>, <code>pkg install vim -y && vim ~/termux-sh/termux-setup.sh</code>). In proot names variables, <code> </code> (space) will be replaced with <code>_</code>, names that are not allowed will be added a suffix <code>1</code>.
</li>
<li>Run the setup script:
<pre><code>bash ~/termux-sh/termux-setup.sh
</code></pre>
</li>
<li>Follow the prompts until it exits automatically.</li>
</ol>

### Content

The variables below refer to the variables set in the beginning of [`termux-setup.sh`](termux-setup.sh).

1. **Termux properties adjustments**: Enables external app access and adjusts extra keys to my configuration designed for swipe gesture navigation, Vim, and Markdown users in `termux.properties`. (Extra keys need relaunching Termux to take effect. `Zp` and `Z` are for my fork of [termux-clipboard](https://github.com/Willie169/termux-clipboard) plugin for Vim and Neovim.)
2. **JetBrainsMono Nerd Font**: Download and change terminal font to JetBrainsMono Nerd Font.
2. **Shortcut configuration**: Copies shortcuts from **[`DOTshortcuts`](DOTshortcuts)** into `~/.shortcuts` folder (for **Termux:Widget**) and [`Documents.sh`](DOTshortcuts/Documents.sh), [`Download.sh`](DOTshortcuts/Download.sh), [`Scripts.sh`](DOTshortcuts/Scripts.sh), [`Storage.sh`](DOTshortcuts/Storage.sh), [`proot-termux.sh`](DOTshortcuts/proot-termux.sh), [`proot-ubuntu.sh`](DOTshortcuts/proot-ubuntu.sh), [`proot-debian.sh`](DOTshortcuts/proot-debian.sh), [`proot-ubuntubox.sh`](DOTshortcuts/proot-ubuntubox.sh), [`proot-debianbox.sh`](DOTshortcuts/proot-debianbox.sh) into home directory `~`. See [Shortcuts](#shortcuts) section for more information.
2. **Bashrc configuration**: Copies `~/.bashrc.d` and `~/.bashrc` from my [**bashrc**](https://github.com/Willie169/bashrc) repo (can be updated with `update_bashrc`, tools installed by this script and package managers can be updated by running `update_all`). `proot-distro login` and `run` with my bindings used in [`proot-ubuntu.sh`](DOTshortcuts/proot-ubuntu.sh) etc. are defined as functions `pdl` and `pdr`, e.g., `pdl ubuntu` and `pdr ubuntu bash -c 'echo a'`.
2. **PulseAudio installation startup**: Installs PulseAudio and starts it automatically in `~/.bashrc`.
2. **VirGL server installation and startup**: Installs VirGL server and starts it automatically in `~/.bashrc` according to my [**termux-x11-virgl-gpu-acceleration**](https://github.com/Willie169/termux-x11-virgl-gpu-acceleration) repo with variables exported in `~/.bashrc`.
2. **Termux packages installation**: Installs Termux packages set in `$PKG`. The default ones include tools for C, C++, Python3, Java21, Node.js LTS and NPM (via APT), Rust, Go, Ruby, Perl, GitHub CLI, GitLab CLI, OpenSSL, OpenSSH, jq, mikefarah's yq, FFMPEG, Maven, Zsh, PRoot, RARLAB UnRAR, Icarus Verilog, Ngspice, jpegoptim, optipng, libheif, LibWebP, ImageMagick, Inkscape, Poppler, qpdf, PDFtk, Ghostscript, rclone-extra, XMLStarlet, Matplotlib, Ninja, SciPy, SQLite 3, Termux:X11, Octave, QEMU, and more. Note that you need to download and install APK from <https://github.com/termux/termux-x11> release to use Termux:X11.
2. **git-delta**: Installs git-delta and configures git to use it if not `$GITDELTA=0`.
2. **yt-dlp**: Installs yt-dlp if not `$YTDLP=0`.
2. **XFCE desktop environment**: Installs XFCE desktop environment, which can be started with Termux:X11 by running `termux-x11 :0 -xstartup "dbus-launch --exit-with-session xfce4-session"`, where `0` can be replaced with other numbers, which has been defined as a function `xxfce` with an optional argument for display (e.g., `:0`).
2. **Android Build Environment Setup**: Runs install script from my [**termux-android-sdk-ndk**](https://github.com/Willie169/termux-android-sdk-ndk) repo with `platform-tools` installed, if not `ANDROID=0`. Refer to it for more information.
2. **Vim and Neovim configuration**: Installs [my modified version](https://github.com/Willie169/vimrc) of [vimrc by Amir Salihefendic (amix)](https://github.com/amix/vimrc) for both Vim and Neovim, and lazy.nvim and Neovim plugins from my [**bashrc**](https://github.com/Willie169/bashrc) repo (can be updated by running `update_nvim`) for Neovim, if not `$VIMRC=0`.
2. **rclone-extra**: Installs rclone-extra, an unofficial fork of rclone, with additional enhancements such as Alist, Alist, iCloud Photos, Teldrive and Terabox support, if not `$RCLONEEXTRA=0`.
2. **mozlz4**: Installs mozlz4 if not `$MOZLZ4=0`.
2. **Phice**: Installs Phice, a lightweight privacy-friendly alternative front-end for Facebook, if not `$PHICE=0`. It can be started by running `cd ~/phice && uv run gunicorn -b 127.0.0.1:<port> -w 4 "app:app"` or `phice [port]` (defined in my [**bashrc**](https://github.com/Willie169/bashrc), and if port is not specified, `5001` is used) and accessed on `localhost:<port>`.
2. **CyberChef**: Installs CyberChef, a web app for encryption, encoding, compression and data analysis, if not `$CYBERCHEF=0`. It can be started by optionally editing config in `$PREFIX/var/lib/proot-distro/containers/cyberchef/rootfs/etc/nginx/conf.d/default.conf` and running `proot-distro run cyberchef`, or running `cyberchef [port]` (defined in my [**bashrc**](https://github.com/Willie169/bashrc), and if port is not specified, `8081` is used) and accessed on `localhost:<port>`.
2. **Stirling PDF**: Installs Stirling PDF, a powerful, open-source PDF editing platform, with English, Chinese - Simplified, Chinese - Simplified (vertical), Chinese - Traditional, and Chinese - Traditional (vertical) Tesseract OCR, if not `$STIRLINGPDF=0`. It can be started by optionally editing config in `$PREFIX/var/lib/proot-distro/containers/stirling-pdf/rootfs/configs/custom_settings.yml` and running `proot-distro run stirling-pdf -e SECURITY_ENABLELOGIN=false -e LANGS=en_GB`, or running `stirlingpdf [port]` (defined in my [**bashrc**](https://github.com/Willie169/bashrc), and if port is not specified, `9000` is used) and accessed on `localhost:<port>`. It's normal that startup needs a while.
2. **npm packages**: Installs npm packages set in `$NPMG` globally.
2. **pip packages**: Installs pip packages set in `$PIP`.
2. **uv packages**: Installs uv tools set in `$UV`.
2. **Go packages**: Installs Go packages set in `$GO`.
2. **Apktool**: Installs Apktool in `/$PREFIX/local/bin` if not `$APKTOOL=0`.
2. **JARs**: Installs ANTLR 4 (JAR in `/usr/local/java`) if not `$ANTLR=0` and PlantUML (JAR in `/usr/local/java`) if not `$PLANTUML=0`.
2. **EFF Large Wordlist for Passphrases**: Downloads EFF Large Wordlist for Passphrases in `~/.eff_large_wordlist.txt`.
2. **Proot-distro Termux environment**: Installs an Termux proot-distro environment with alias `$TERMUX`, which can be booted using script `proot-termux.sh` in home directory `~` and `~/.shortcuts` folder (for **Termux:Widget**), if `$TERMUX` is set as a nonempty string.
2. **Proot-distro Ubuntu environment**: Installs an Ubuntu ARM64 proot-distro environment with alias `$UBUNTU` if `$UBUNTU` is set as a nonempty string, and runs [`ubuntu-debian.sh`](ubuntu-debian.sh) in it if `$UBUNTU` is set as a nonempty string, machine is of AArch64 (aka ARM64) architecture, and `$UBUNTUINSTALL` is not `0`. See [Invoked VM Setup Scripts](#invoked-vm-setup-scripts) section for more information. 
2. **Proot-distro Debian environment**: Installs Debian ARM64 proot-distro environment with alias `$DEBIAN` if `$DEBIAN` is set as a nonempty string, and runs [`ubuntu-debian.sh`](ubuntu-debian.sh) in it if `$DEBIAN` is set as a nonempty string, machine is of AArch64 (aka ARM64) architecture, and `$DEBIANINSTALL` is not `0` (less recommended than running it in Ubuntu since some tools are not supported and some tools are of older versions than in Ubuntu). See [Invoked VM Setup Scripts](#invoked-vm-setup-scripts) section for more information.
2. **Proot-distro Ubuntu environment with Box64, Wine64, and Winetricks (not invoked by default and no longer actively maintained)**: Installs Ubuntu ARM64 proot-distro environment with alias `$UBUNTUBOX` if `$UBUNTUBOX` is set as a nonempty string, and runs [`box64-wine64-winetricks.sh`](box64-wine64-winetricks.sh) (no longer actively maintained) in it if `$UBUNTUBOX` is set as a nonempty string, machine is of AArch64 (aka ARM64) architecture, and `$UBUNTUBOXINSTALL` is not `0`. See [Invoked VM Setup Scripts](#invoked-vm-setup-scripts) section for more information.
2. **Proot-distro Debian environment with Box64, Wine64, and Winetricks (not invoked by default and no longer actively maintained)**: Installs Debian ARM64 proot-distro environment with alias `$DEBIANBOX` if `$DEBIANBOX` is set as a nonempty string, and runs [`box64-wine64-winetricks.sh`](box64-wine64-winetricks.sh) (no longer actively maintained) in it if `$DEBIANBOX` is set as a nonempty string, machine is of AArch64 (aka ARM64) architecture, and `$DEBIANBOXINSTALL` is not `0`. See [Invoked VM Setup Scripts](#invoked-vm-setup-scripts) section for more information.

### Invoked VM Setup Scripts

These scripts will be invoked by [Termux Setup](#termux-setup) if corresponding configuration is set.

- [`ubuntu-debian.sh`](ubuntu-debian.sh) (Only Ubuntu >= 24.04 and Debian >= 13 is supported. Running in Ubuntu is more recommended than in Debian since in Debian, some tools are not supported and some tools are of older versions.): Configures PulseAudio and VirGL (according to my [**termux-x11-virgl-gpu-acceleration**](https://github.com/Willie169/termux-x11-virgl-gpu-acceleration) repo and with variables exported in `~/.bashrc`) and installs development tools, runtime environments, and utilities for C, C++, Python3, Java 21, 
  Rust, Go, Perl, Aptitude, GitHub CLI, GitLab CLI, GVim, OpenSSL, OpenSSH, JQ, FFMPEG, Pandoc, TeX Live (via regular installation instead of APT for unrestricted `tlmgr` and updates, can be updated with `update_texlive`), Maven, Zsh, XFCE desktop environment, iproute2, 
  net-tools, Nmap, Node.js LTS (via NVM), npm, Yarn, Deno, http-server, LintHTML, OpenCode, Codex, yt-dlp, Lazygit, Homebrew, Glow, bat, fd, ncdu, dust, fzf, Delta, ripgrep (rg), Yazi, zoxide, Miniforge, uv, gallery-dl, procs, tldr, xmljson, JADX, Apktool, broot, bottom (btm), hyperfine, lsd, 
  gh2md, img2pdf, English, Chinese - Simplified, Chinese - Simplified (vertical), Chinese - Traditional, and Chinese - Traditional (vertical) Tesseract OCR, OCRmyPDF, LibreTranslate, Jupyter Notebook, JupyterLab, Jupytext, Meson, Tree-sitter CLI, pylatexenc, lazy.nvim and Neovim plugins from my [**bashrc**](https://github.com/Willie169/bashrc) repo (can be updated by running `update_nvim`), LSP servers, 
  RARLAB UnRAR, Verilator, Ngspice, jpegoptim, optipng, libheif, LibWebP, ImageMagick, Inkscape, Poppler, qpdf, PDFtk, Ghostscript, Bookletimposer, 
  Audacity, w3m, XMLStarlet, GTKWave, llmfit, ANTLR 4 (JAR in `/usr/local/java`), Octave, XFCE desktop environment (can be started with Termux:X11 by running `termux-x11 :0 &`, logging into Proot-distro with `--shared-tmp` option, and running `export DISPLAY=:0` 
  and `xfce` inside, where `0` can be replaced with other numbers), fix for stuck `elementary-xfce-icon-theme` from my [**fix-elementary-xfce-icon-theme**](https://github.com/Willie169/fix-elementary-xfce-icon-theme) repo, PlantUML (JAR in `/usr/local/java`), SQLite 3, 
  mpv, iotop-c, netcat, NetHogs, net-tools, iftop, KataGo (`~/KataGo/cpp/katago` and can be run with `katago`) and KataGo network `kata1-b6c96-s175395328-d26788732` (in `~/katago-networks`, other networks can be downloaded from <https://katagotraining.org/networks>), LizzieYzy (can be launched by running `lizzieyzy` or 
  with desktop entry `~/.local/share/applications/lizzieyzy.desktop` or `~/desktop/lizzieyzy.desktop`, runtime directory `~/.lizzieyzy`, KataGo network `kata1-b6c96-s175395328-d26788732` configured as default engine and estimate engine in `~/.lizzieyzy/config.txt`, which 
  can be updated by running `update_lizzieyzy_config`), Fairy-Stockfish (`~/Fairy-Stockfish/src/stockfish` and can be run with `stockfish`), Cute Chess (GUI at `~/cutechess/build/cutechess` and can be launched by running `cutechess` or with 
  desktop entry `~/.local/share/applications/cutechess.desktop` or `~/desktop/cutechess.desktop`, CLI at `~/cutechess/build/cutechess-cli` and can be run with `cutechess-cli`, Fairy-Stockfish configured as engine in `~/.config/cutechess/engines.json`, which can be 
  updated by running `update_cutechess_config`), Sylvan (GUI at `~/Sylvan/projects/gui/sylvan` and can be launched by running `sylvan` or with desktop entry `~/.local/share/applications/sylvan.desktop` or `~/desktop/sylvan.desktop`, CLI at 
  `~/Sylvan/projects/cli/sylvan-cli` and can be run with `sylvan-cli`, Fairy-Stockfish configured as engine in `~/.config/EterCyber/engines.json`, which can be updated by running `update_sylvan_config`), mozlz4, Noto Fonts (set as default font for system ui), Noto CJK Fonts (set as fallback font for system ui), Noto Color Emoji (set as fallback font for system ui), 全字庫正楷體 TW-Kai (set as fallback font for 標楷體 DFKai-SB),
  全字庫正宋體 TW-Sung (set as fallback font for 細明體 MingLiu and 新細明體 PMingLiu), 文泉驛正黑 WenQuanYi Zen Hei (set as fallback font for 微軟正黑體 Microsoft JhengHei), [my modified version](https://github.com/Willie169/vimrc) 
  of [vimrc by Amir Salihefendic (amix)](https://github.com/amix/vimrc) for both Vim and Neovim (can be updated by running `update_vimrc`), my LaTeX package [`physics-patch`](https://github.com/Willie169/physics-patch) (in `~/texmf/tex/latex/physics-patch`, checked out `dev` branch, and can be updated with `update_latex`), my LaTeX template [`LaTeX-ToolKit`](https://github.com/Willie169/LaTeX-ToolKit) (in `/usr/share/LaTeX-ToolKit/template.tex` and can be updated
  with `update_latex`), downloads EFF Large Wordlist for Passphrases in `~/.eff_large_wordlist.txt`, copies `~/.bashrc.d` and `~/.bashrc` from my [**bashrc**](https://github.com/Willie169/bashrc) 
  repo (can be updated by running `update_bashrc`, tools installed by this script that is not managed by a package manager can be updated by running `update_tools`, tools installed by this script and package managers can be updated by running `update_all`), and more, on Ubuntu or Debian ARM64 Proot environment.
- [`box64-wine64-winetricks.sh`](box64-wine64-winetricks.sh) (no longer actively maintained): Installs `box64`, `wine64`, and `winetricks` for running x86\_64 Linux and Windows applications on Debian derivatives ARM64.

## Shortcuts

Shortcuts are located in [`DOTshortcuts`](DOTshortcuts). Some of them are intended for tools that is not installed or configured in the [Termux Setup](#termux-setup), such as QEMU. Some related scripts are in [Additional Scripts](#additional-scripts).

### Boot VM Scripts

- [`proot-termux.sh`](DOTshortcuts/proot-termux.sh): Boot Termux Proot-distro environments installed in [`termux-setup.sh`](termux-setup.sh) with `--isolated --fix-low-ports --no-arch-warning`. See [Termux Setup](termux-setup) section for more information.
- [`proot-ubuntu.sh`](DOTshortcuts/proot-ubuntu.sh), [`proot-debian.sh`](DOTshortcuts/proot-debian.sh), [`proot-ubuntubox.sh`](DOTshortcuts/proot-ubuntubox.sh), [`proot-debianbox.sh`](DOTshortcuts/proot-debianbox.sh): Boot those Proot-distro environments installed in [`termux-setup.sh`](termux-setup.sh) respectively with `--isolated --fix-low-ports --shared-tmp --no-arch-warning --bind /apex --bind /data/dalvik-cache --bind /system --bind /linkerconfig --bind /vendor --bind /data/data/com.termux/files/usr/bin --bind /data/data/com.termux/files/usr/lib --bind /data/data/com.termux/files/usr/libexec`, and environmental variables `THIS` pointing to the rootfs of the current Proot-distro, `TERMUX_HOME` pointing to `$HOME` of Termux, and `TERMUX_PREFIX` pointing to `$PREFIX` of Termux. See [Termux Setup](termux-setup) section for more information.
- [`qemu-alpine-aarch64.sh`](DOTshortcuts/qemu-alpine-aarch64.sh), [`qemu-alpine-aarch64-vnc.sh`](DOTshortcuts/qemu-alpine-aarch64-vnc.sh), [`qemu-alpine-x86_64.sh`](DOTshortcuts/qemu-alpine-x86_64.sh), [`qemu-alpine-x86_64-vnc.sh`](DOTshortcuts/qemu-alpine-x86_64-vnc.sh), [`qemu-debian-aarch64.sh`](DOTshortcuts/qemu-debian-aarch64.sh), [`qemu-debian-aarch64-vnc.sh`](DOTshortcuts/qemu-debian-aarch64-vnc.sh), [`qemu-alpine-amd64.sh`](DOTshortcuts/qemu-alpine-amd64.sh), [`qemu-debian-amd64-vnc.sh`](DOTshortcuts/qemu-debian-amd64-vnc.sh), [`qemu-bliss-vnc.sh`](DOTshortcuts/qemu-bliss-vnc.sh) (no longer actively maintained): Boot respective QEMU system emulation VMs with `-netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1` option, where files with `-vnc` in their names start VNC server at the host's `localhost:0` and others are `-nographic`. Those VMs can be installed with [`qemu-alpine-aarch64-install.sh`](qemu-alpine-aarch64-install.sh), [`qemu-alpine-x86_64-install.sh`](qemu-alpine-x86_64-install.sh), [`qemu-debian-arm64-install.sh`](qemu-debian-arm64-install.sh), [`qemu-debian-amd64-install.sh`](qemu-debian-amd64-install.sh), and [`qemu-bliss-install.sh`](qemu-bliss-install.sh) respectively. See [Additional Scripts](#additional-scripts) for details.
- [`nethunter.sh`](DOTshortcuts/nethunter.sh) (no longer actively maintained): Boots the Kali Nethunter Proot-distro instance with the alias `kali-default` as user `kali` with `isolated` and `fix-low-ports` options.

### Utility Scripts

- [`storage.sh`](DOTshortcuts/storage.sh): `cd /storage/emulated/0`.
- [`documents.sh`](DOTshortcuts/Documents.sh), [`download.sh`](DOTshortcuts/Download.sh), [`scripts.sh`](DOTshortcuts/Scripts.sh): `cd` those directories in `/storage/emulated/0` respectively.
- [`xmrig-xmr.sh`](DOTshortcuts/xmrig-xmr.sh): Mines XMR to [the repository owner](https://github.com/Willie169)'s wallet, `48j6iQDeCSDeH46gw4dPJnMsa6TQzPa6WJaYbBS9JJucKqg9Mkt5EDe9nSkES3b8u7V6XJfL8neAPAtbEpmV2f4XC7bdbkv`, using my modified version of [XMRig](https://github.com/Willie169/xmrig) and through Tor, which is not installed in the [Termux Setup](#termux-setup) and can be installed with [`xmrig-install.sh`](xmrig-install.sh). Change the wallet address and other configurations if you want.

## Additional Scripts

These scripts are not invoked by [Termux Setup](#termux-setup). Run it separately if you need it.

- [`persistent-notifications-rish.sh`](persistent-notifications-rish.sh): On Android 14+, let persistent notifications posted by all apps of user 0 and user 10 not be dismissible through the UI (i.e. behave as they did prior to Android 14) (run in ADB shell) assuming that interactive ADB shell can be accessed with `rish`. See my [**Samsung-Android-Debloat-List**](https://github.com/Willie169/Samsung-Android-Debloat-List) repo for more information.
- [`persistent-notifications-adb.sh`](persistent-notifications-adb.sh): On Android 14+, let persistent notifications posted by all apps of user 0 and user 10 not be dismissible through the UI (i.e. behave as they did prior to Android 14) (run in ADB shell) assuming that ADB is connected with <code>adb shell</code> available. See my [**Samsung-Android-Debloat-List**](https://github.com/Willie169/Samsung-Android-Debloat-List) repo for more information.
- [`disable-phantom-process-killer-rish.sh`](disable-phantom-process-killer-rish.sh): Disable phantom process killer to resolve `Process completed (signal 9) - press Enter` error assuming that interactive ADB shell can be accessed with `rish`. See <https://willie169.github.io/Android-Non-Root/#process-completed-signal-9---press-enter-error> for more information. 
- [`disable-phantom-process-killer-adb.sh`](disable-phantom-process-killer-adb.sh): Disable phantom process killer to resolve `Process completed (signal 9) - press Enter` error assuming that ADB is connected with <code>adb shell</code> available. See <https://willie169.github.io/Android-Non-Root/#process-completed-signal-9---press-enter-error> for more information. 
- [`xmrig-install.sh`](xmrig-install.sh): Builds my modified version of [XMRig](https://github.com/Willie169/xmrig), an open source, cross-platform RandomX, KawPow, CryptoNight and GhostRider CPU/GPU miner, RandomX benchmark, and stratum proxy, on Termux.
- [`qemu-alpine-aarch64-install.sh`](qemu-alpine-aarch64-install.sh), [`qemu-alpine-x86_64-install.sh`](qemu-alpine-x86_64-install.sh), [`qemu-debian-arm64-install.sh`](qemu-debian-arm64-install.sh), [`qemu-debian-amd64-install.sh`](qemu-debian-amd64-install.sh), [`qemu-bliss-install.sh`](qemu-bliss-install.sh) (no longer actively maintained): Setup and boot the respective QEMU system emulation VMs with `-netdev user,id=n1,dns=8.8.8.8,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1` option, where the Alpine VMs are created from Virt 3.21.0 ISO images and the Debian VMs are pre-created Bookworm QCOW2 images. [`qemu-bliss-install.sh`](qemu-bliss-install.sh) starts VNC server at the host's `localhost:0` and others are `-nographic`. Remember to `setup-alpine` in Alpine VMs and resize disk in Debian VMs. [Bliss OS](https://blissos.org) is an Android-based open source OS for x86\_64 architecture that incorporates many optimizations, features, and that supports many more devices.
- [`proot-install-nethunter.sh`](proot-install-nethunter.sh) (no longer actively maintained): Installs Kali Nethunter ARM64 proot-distro environment from [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter). Follow the screen guide and enter wanted Build ID to install, e.g., `KBDEXKMTE` for everything and `KBDEXKMTD` for default. Boot it with `<build id> [` USER `]` or `proot-distro login <build id> [` USER `]`. Open GUI after logged in with `sudo kgui`. Please go to [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter) for more information.
- [`debian-buster-xfce-mod.sh`](debian-buster-xfce-mod.sh) (no longer actively maintained): Modified version of [`Andronix's debian-xfce.sh`](https://github.com/AndronixApp/AndronixOrigin/blob/master/Installer%2FDebian%2Fdebian-xfce.sh), which installs and configures XFCE desktop environment and VNC server for Debian Buster ARM64 PRoot environment.
- [`proot-install-buster-cli.sh`](proot-install-buster-cli.sh) (no longer actively maintained): Installs Andronix Debian Buster ARM64 PRoot CLI-only environment in `~/$BUSTERCLI` if `$BUSTERCLI` is set as a nonempty string using [`Andronix's debian.sh`](https://github.com/AndronixApp/AndronixOrigin/blob/master/Installer%2FDebian%2Fdebian.sh). Configure the `BUSTERCLI` variable in the file to change the directory.
- [`proot-install-buster-xfce.sh`](proot-install-buster-xfce.sh) (no longer actively maintained): Installs Andronix Debian Buster ARM64 PRoot environment with XFCE desktop environment and VNC server in `~/$BUSTERXFCE` if `$BUSTERXFCE` is set as a nonempty string using [`debian-buster-xfce-mod.sh`](debian-buster-xfce-mod.sh).

## License

This repository is licensed under GNU General Public License General Public License, see [LICENSE.md](LICENSE.md) for details.

## Credits

- <https://andronix.app>
- <https://github.com/AndronixApp/AndronixOrigin>
- <https://github.com/sagar040/proot-distro-nethunter>
- <https://github.com/robertkirkman/termux-on-gha>
- <https://github.com/termux/proot-distro>
- <https://github.com/termux/termux-app>
- <https://ivonblog.com>
- <https://wiki.termux.com>
- <https://www.qemu.org>
