#!/bin/bash

# sudo chmod +x setup.sh
# sudo ./setup.sh

# https://linuxconfig.org/things-to-do-after-installing-ubuntu-18-04-bionic-beaver-linux

if [[ $EUID -ne 0 ]]; then
 echo "This script must be run as root" 
 exit 1
else
 # Update and Upgrade
 echo "Updating and Upgrading"
 apt-get update && apt-get upgrade -y

### ============ ###
###     BASE     ###
### ============ ###

 # Base packages
 apt install -y git-core curl wget gdebi-core bleachbit vlc gufw zsh rsync wmctrl synaptic gimp filezilla lmms snapd x11-utils locate skippy-xd
 sudo updatedb
 apt autoremove -y

 add-apt-repository ppa:ubuntubudgie/backports
 apt update && sudo apt install budgie-calendar-applet budgie-haste-applet budgie-screenshot-applet

# Install Build Essentials
 echo "Installing Build Essentials"
 apt install -y build-essential

# Ubuntu Restricted Extras
 echo "Installing Ubuntu Restricted Extras"
 apt install ubuntu-restricted-extras -y

# Remove unwanted
# apt-cache pkgnames | less
# apt-cache show firefox
 echo "Removing Unwanted Packagaes"
 apt remove -y gnome-mahjongg gnome-mines gnome-sudoku peg-solitaire pegsolitaire aisleriot geary
 apt purge cheese

# Git
 git config --global color.ui true
 git config --global user.name "Chris Anthony"
 git config --global user.email "ctanthny@gmail.com"
 ssh-keygen -t rsa -b 4096 -C "ctanthny@gmail.com"

 cat ~/.ssh/id_rsa.pub
 # https://github.com/settings/ssh
 ssh -T git@github.com

# OMZ
# https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH
 echo "Installing Oh-My-Zsh"
 zsh --version
 command -v zsh | tee -a /etc/shells
 chsh -s $(which zsh)
 /usr/bin/zsh
 2
 sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Zulu
 echo "Installing Zulu"
 curl -L https://zulu.molovo.co/install | zsh && zsh
 zulu install autopair completions docker git homebrew tipz rbenv dpkg utility pretty-time
 zulu uninstall zulu-theme

 # Tilix config location /usr/share/glib-2.0/schemas/com.gexperts.Tilix.gschema.xml

 # Terminator
#  echo "Installing Terminator"
#  add-apt-repository ppa:gnome-terminator -y
#  rm /etc/apt/sources.list.d/gnome-terminator-ubuntu-ppa-bionic.list
#  sudo tee -a '/etc/apt/sources.list.d/gnome-terminator-ubuntu-ppa-xenial.list' <<'EOF'
#  deb http://ppa.launchpad.net/gnome-terminator/ppa/ubuntu xenial main
#  # deb-src http://ppa.launchpad.net/gnome-terminator/ppa/ubuntu xenial main
# EOF
#  apt update
#  apt install terminator -y

### ============ ###
###    EXTRAS    ###
### ============ ###

# Gnome Extras
# https://linuxconfig.org/how-to-install-gnome-shell-extensions-on-ubuntu-18-04-bionic-beaver-linux
 echo "Installing Gnome Extras"
 add-apt-repository universe
 apt install -y gnome-tweak-tool gnome-weather gnome-shell-extensions chrome-gnome-shell gnome-shell-extension-pixelsaver gnome-system-monitor
 # gnome-tweaks
 # add browser shell integration
  ## firefox - https://addons.mozilla.org/en-US/firefox/addon/gnome-shell-integration/
 ### gno-menu

### ============ ###
###     APPS     ###
### ============ ###

# Install Slack
 echo "Installing Slack"
 snap install slack --classic
#  wget -O ~/slack.deb "https://downloads.slack-edge.com/linux_releases/slack-desktop-3.1.0-amd64.deb"
#  gdebi ~/slack.deb

# Chrome
 echo "Installing Google Chrome"
 snap install chrome
#  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
#  sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
#  apt-get update 
#  apt-get install google-chrome-stable -y

# Keepass
 echo "Installing KeePass"
 snap install keepassxc
#  add-apt-repository ppa:phoerious/keepassxc
#  apt-get update
#  apt-get install keepassxc

# Vivaldi
 echo "Installing Vivaldi"
 wget -qO- http://repo.vivaldi.com/stable/linux_signing_key.pub | sudo apt-key add -
 add-apt-repository "deb [arch=i386,amd64] http://repo.vivaldi.com/stable/deb/ stable main"
 apt install -y vivaldi-stable

# Dropbox
 echo "Installing Dropbox"
 apt install -y nautilus-dropbox 

# Mailspring
 echo "Installing Mailspring"
 snap install mailspring

# Stacer
# https://linuxconfig.org/system-monitoring-on-ubuntu-18-04-linux-with-stacer
 echo "Installing Stacer"
 wget -O ~/stacer.deb https://jaist.dl.sourceforge.net/project/stacer/v1.0.9/stacer_1.0.9_amd64.deb
 gdebi ~/stacer.deb -n
 rm ~/stacer.deb

# U-Cleaner
 echo "Installing Ubuntu-Cleaner"
 apt install software-properties-common -y
 add-apt-repository ppa:gerardpuig/ppa -y
 apt update
 apt install -y ubuntu-cleaner

# OpenShot
 echo "Installing OpenShot"
 add-apt-repository ppa:openshot.developers/ppa -y
 apt-get update
 apt-get install openshot-qt -y

# Gitbook
 echo "Installing GitBook"
 wget -0 ~/gitbook.deb https://legacy.gitbook.com/editor/linux-64-bit/download
 gedbi ~/gitbook.deb
 rm ~/gitbook.deb

# Gnome Builder
#  echo "Installing Gnome Builder"
#  add-apt-repository ppa:f-muriana/ubuntu-builder -y
#  apt-get update
#  apt install ubuntu-builder -y

 echo "Installing Redis-Desktop-Manager"
 snap install redis-desktop-manager
 echo "Installing Zenkit"
 snap install zenkit
 echo "Installing Bitwarden"
 snap install bitwarden
 echo "Installing Inkscape"
 snap install inkscape
 echo "Installing Fkill"
 snap install fkill
 echo "Installing Discord"
 snap install discord
 echo "Installing Audacity"
 snap install audacity

#  snap install wonderwall
#  snap install wireguard
#  snap install auryo
#  snap install gifcurry
#  snap install obs-studio
#  snap install blender --classic
#  snap install polarr

### ============ ###
###      DEV     ###
### ============ ###

# Install VSCode
# https://code.visualstudio.com/docs/setup/linux#_installation
 echo "Installing VSCode"
 curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
 install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
 sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

 apt install -y apt-transport-https
 apt-get update
 apt install -y code

#  code --list-extensions
#  code --install-extension ( | )

# Install NVM
# https://gist.github.com/d2s/372b5943bce17b964a79
 echo "Installing NVM"
 wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

 sudo tee -a '~/.zshrc' <<'EOF'
# auto ls
chpwd() {
  ls -a
}

# This loads nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
EOF

 nvm install v10.15.1

# Ruby
 echo "Installing Ruby"
 bash
 curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
 curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
 apt install gcc g++ make -y
 echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

 apt update
 apt install -y zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev yarn

# Rbenv
 echo "Installing Rbenv"
 git clone https://github.com/rbenv/rbenv.git ~/.rbenv
 echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
 echo 'eval "$(rbenv init -)"' >> ~/.bashrc
 echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
 echo 'eval "$(rbenv init -)"' >> ~/.zshrc
 /usr/bin/zsh

 git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
 echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
 echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.zshrc
 /usr/bin/zsh

 rbenv install 2.5.3
 rbenv global 2.5.3
 ruby -v
 gem install bundler

# Rails
 gem install rails
 rbenv rehash
 rails -v

# Postgres
 echo "Installing Postgresql"
 sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
 wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
 apt update
 apt install -y postgresql-common
 apt install -y postgresql-9.5 libpq-dev

 # sudo -u postgres createuser chris -s

 # If you would like to set a password for the user, you can do the following
 # sudo -u postgres psql
 # postgres=# \password chris

 echo "Downloading config files"
 git clone git@github.com:CTAnthny/linux-setup.git $HOME/os-config
 echo "Copying config files"
 cp ~/os-config/colors/Cobalt_Neon.itermcolors $HOME/.config/colors/Cobalt_Neon.itermcolors
 cp ~/os-config/colors/Molokai.itermcolors $HOME/.config/colors/Molokai.itermcolors
 cp ~/os-config/vscode.settings.json $HOME/.config/Code/User/settings.json
 cp ~/os-config/vscode.keybindings.json $HOME/.config/Code/User/keybindings.json

 PKGS=$(<$HOME/os-config/vscode.packages)
 for pkg in "${PKG[@]}"
 do
  code --install-extension $pkg
 done
 
 # Extras
 echo "Installing Bacula"
 apt install -y bacula
 
 echo "Installing Docker"
 snap install docker
 
 echo "Installing Heroku"
 snap install heroku --classic

 echo "Installing Dry"
 curl -sSf https://moncho.github.io/dry/dryup.sh | sudo sh
 chmod 755 /usr/local/bin/dry

# Python
# https://www.digitalocean.com/community/tutorials/how-to-install-python-3-and-set-up-a-programming-environment-on-ubuntu-18-04-quickstart
 echo "Checking Python"
 apt update
 apt -y upgrade
 python3 -V
 apt install -y python3-pip python3-dev

# Electron
# npm i -D electron@latest

### ============ ###
###      GPU     ###
### ============ ###

# Steam
 echo "Installing Steam"
 dpkg --add-architecture i386
 apt update
 apt install -y libgl1-mesa-dri:i386 libgl1-mesa-glx:i386
 wget http://media.steampowered.com/client/installer/steam.deb
 gdebi steam.deb -y

# PlayOnLinux
 echo "Installing Play On Linux"
 apt install -y playonlinux

# Wine
# https://wiki.winehq.org/Ubuntu
 echo "Installing Wine"
 wget -nc https://dl.winehq.org/wine-builds/winehq.key
 apt-key add winehq.key

 apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu bionic main'
 apt update
 apt install --install-recommends winehq-stable -y

# Lutris
# https://lutris.net/downloads/
 echo "Installing Lutris"
 ver=$(lsb_release -sr); if [ $ver != "18.10" -a $ver != "18.04" -a $ver != "16.04" ]; then ver=18.04; fi
 echo "deb http://download.opensuse.org/repositories/home:/strycore/xUbuntu_$ver/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
 wget -q https://download.opensuse.org/repositories/home:/strycore/xUbuntu_$ver/Release.key -O- | sudo apt-key add -
 apt update
 apt install -y lutris

### ============ ###
###      GTK     ###
### ============ ###

 echo "Installing Extra Fonts"

# MS
 echo "Installing Microsoft Fonts"
 apt install -y ttf-mscorefonts-installer

# Hack
 echo "Installing Hack Font" 
 apt install -y fonts-hack-ttf fonts-hack-web

# Summersby
 echo "Installing Summersby"
 apt install -y ttf-summersby

# Inconsolata
 echo "Installing Inconsolata"
 apt install -y fonts-inconsolata

# Fira
 echo "Installing Fira"
 apt install -y fonts-firacode

# Fantasque
 echo "Installing Fantasque"
 apt install -y fonts-fantasque-sans

# Roboto
 echo "Installing Roboto"
 apt install -y fonts-roboto fonts-roboto-fontface

 echo "Installing Extra Themes and Icons"
 # https://itsfoss.com/best-icon-themes-ubuntu-16-04/
 # /etc/apt/sources.list
 # /etc/apt/sources.list.d

#Arc Theme
#  echo "Installing Arc Theme"
#  add-apt-repository ppa:noobslab/themes -y
#  apt-get update
#  apt-get install arc-theme -y

# Plata Theme
# https://www.linuxuprising.com/2018/11/plata-is-new-gtk-theme-based-on-latest.html
 echo "Installing Plata Theme"
 add-apt-repository ppa:tista/plata-theme -y
 apt update
 apt install plata-theme -y
 rm /etc/apt/sources.list.d/tista-ubuntu-plata-theme-bionic.list

# Xenlism Icons
 echo "Installing Xenlism Icons"
 apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 2B80AC38
 add-apt-repository ppa:xenatt/xenlism -y
 apt-get update
 apt-get install xenlism-minimalism-theme
 apt install xenlism-wildfire-icon-theme -y

# Noobslab Icons
 echo "Installing Arc Icons"
 add-apt-repository ppa:noobslab/icons -y
 apt-get update
 apt-get install arc-icons -y

 echo "Installing Obsidian Icons"
 apt-get install obsidian-1-icons

 echo "Installing Shadow Icons"
 apt-get install shadow-icon-theme

# Numix Icons
 echo "Installing Numic Icons"
 apt-add-repository ppa:numix/ppa -y
 apt-get update
 apt-get install numix-icon-theme numix-icon-theme-circle -y

# Oranchelo Icons
 echo "Installing Oranchelo Icons"
 add-apt-repository ppa:oranchelo/oranchelo-icon-theme -y
 apt-get update
 apt-get install oranchelo-icon-theme -y

# Ravefinity Icons
 echo "Installing Ravefinity Icons"
 add-apt-repository ppa:ravefinity-project/ppa
 rm /etc/apt/sources.list.d/ravefinity-project-ubuntu-ppa-bionic.list
 rm /etc/apt/sources.list.d/ravefinity-project-ubuntu-ppa-bionic.list.save
 sudo tee -a '/etc/apt/sources.list.d/ravefinity-project-ubuntu-ppa-xenial.list' <<'EOF'
 deb http://ppa.launchpad.net/ravefinity-project/ppa/ubuntu xenial main 
 # deb-src http://ppa.launchpad.net/ravefinity-project/ppa/ubuntu xenial main
EOF
 apt update
 apt install vibrancy-colors -y
#  apt install ravefinity-x-icons -y

# ls -la /etc/apt/sources.list.d

apt autoremove -y
apt upgrade -y

 # Others
 ## Minimalist - https://www.gnome-look.org/p/1235451/
 ## W10 - https://www.gnome-look.org/p/1216281/
 ## Glassful - https://www.gnome-look.org/p/1013022/
 ## Darqlassic - https://www.gnome-look.org/p/1012941/
 ## Petitlepton - https://www.gnome-look.org/p/1012903/

 # Notes
 ## Setup wmctrl keybindings
 ### http://xahlee.info/linux/linux_add_keyboard_shortcuts_to_switch_to_app.html
 ### https://www.linuxjournal.com/magazine/hack-and-automate-your-desktop-wmctrl
 ### https://www.freedesktop.org/wiki/Software/wmctrl/
 ### http://tripie.sweb.cz/utils/wmctrl/
 ## Zenity
 ### https://www.howtogeek.com/107537/how-to-make-simple-graphical-shell-scripts-with-zenity-on-linux/
 
 ## Create System Image
 ### https://tutorials.ubuntu.com/tutorial/create-your-own-core-image#0

 ## Find package names
 ### https://www.howtogeek.com/229682/how-to-find-out-exact-package-names-for-applications-in-linux/
 ### apt-cache pkgnames <name>
 ### apt-cache show <name>
 ### apt-cache showpkg <name>

 ## Setup Application Keybindings
 ### http://xahlee.info/linux/linux_add_keyboard_shortcuts_to_switch_to_app.html
 ### wmctrl -xa vivaldi
 ### wmctrl -xa tilix
 ### wmctrl -xa slack
 ### wmctrl -xa code
 ### wmctrl -xa stacer

 ## Skippy
 ### https://code.google.com/archive/p/skippy-xd/wikis/SetupGuide.wiki
 ### skippy-xd --activate-window-picker
 ### startup: skippy-xd --start-daemon
