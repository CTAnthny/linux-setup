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
 sudo apt install -y git-core curl wget gdebi-core cmake redis-server alacarte gparted bleachbit vlc \
 xclip gufw zsh rsync wmctrl synaptic gimp filezilla lmms snapd x11-utils locate flatpak \
 qt4-qtconfig net-tools libdvdcss2 libdvdnav4 libdvdread4 wodim lsscsi inxi usbmount
 sudo updatedb
 sudo apt autoremove -y

 sudo add-apt-repository ppa:ubuntubudgie/backports
 sudo apt update && sudo apt install budgie-calendar-applet budgie-haste-applet budgie-screenshot-applet

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
# https://stackoverflow.com/questions/4298960/git-add-and-commit-in-one-command
 git config --global color.ui true
 git config --global user.name "Chris Anthony"
 git config --global user.email "ctanthny@gmail.com"
 git config --global alias.co "git checkout"
 git config --global alias.br "git branch"
 git config --global alias.ci "git commit"
 git config --global alias.st "git status"
 git config --global alias.ac "git add -A && git commit -m"
 ssh-keygen -t rsa -b 4096 -C "ctanthny@gmail.com"

 cat ~/.ssh/id_rsa.pub
 # https://github.com/settings/ssh
 ssh -T git@github.com

# Oh-my-zsh
# https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH
 echo "Installing Oh-My-Zsh"
 zsh --version
 command -v zsh | tee -a /etc/shells
 chsh -s $(which zsh)
 /usr/bin/zsh
 2
 sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Zulu
# zsh plugin and utility manager
 echo "Installing Zulu"
 curl -L https://zulu.molovo.co/install | zsh && zsh
 zulu install autopair completions docker tipz rbenv dpkg utility pretty-time zsh-hooks syntax-highlighting autosuggestions pure node git zsh-hints zsh-hints-integration alias-tips history-search-multi-word homebrew 
 zulu uninstall zulu-theme

 # Tilix config location /usr/share/glib-2.0/schemas/com.gexperts.Tilix.gschema.xml

 # Terminator
 # shell emulator
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
 apt install -y gnome-tweak-tool gnome-weather gnome-shell-extensions chrome-gnome-shell gnome-system-monitor
 # gdm-3
 # gnome-tweaks
 # add browser shell integration
  ## firefox - https://addons.mozilla.org/en-US/firefox/addon/gnome-shell-integration/
 ### gno-menu

### ============ ###
###     APPS     ###
### ============ ###

# Install Slack
# chat client
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
# password database manager
 echo "Installing KeePass"
#  snap install keepassxc
 add-apt-repository ppa:phoerious/keepassxc
 apt update
 apt install keepassxc -y

# Vivaldi
# chromium fork browser with privacy
 echo "Installing Vivaldi"
 wget -qO- http://repo.vivaldi.com/stable/linux_signing_key.pub | sudo apt-key add -
 add-apt-repository "deb [arch=i386,amd64] http://repo.vivaldi.com/stable/deb/ stable main"
 apt install -y vivaldi-stable

# Okular
# pdf / ebook reader
 echo "Installing Okular"
#  wget -O ~/okular.deb http://security.ubuntu.com/ubuntu/pool/universe/o/okular/okular_20.04.1-0ubuntu1_amd64.deb
 sudo apt-get install okular
#  gdebi ~/okular.deb
#  rm ~/okular.deb

# Dropbox
# Cloud file storage
 echo "Installing Dropbox"
 apt install -y nautilus-dropbox 

# Mailspring
# Mail Client
 echo "Installing Mailspring"
 snap install mailspring

# Anbox
# Native Android for linux
# https://docs.anbox.io/userguide/install.html
 echo "Installing Anbox"
 echo "Installing kernel dependencies.."
 wget -nc http://download.opensuse.org/repositories/home:/strycore/xUbuntu_18.04/Release.key
 apt-key add ~/Release.key
 rm ~/Release.key
 add-apt-repository ppa:morphis/anbox-support
 apt update
 apt install linux-headers-generic anbox-modules-dkms -y
 modprobe ashmem_linux
 modprobe binder_linux
 ls -1 /dev/{ashmem,binder}
 cat << EOF
 Expected output:
 /dev/ashmem
 /dev/binder
EOF
 echo "Snap installing anbox"
 snap install --devmode --beta anbox
 echo "Installing Android Tools ADB"
 apt install android-tools-adb -y

 # adb install my-app.apk
 # anbox.appmgr

 # uninstall
 # snap remove anbox
 # sudo apt install ppa-purge
 # sudo ppa-purge ppa:morphis/anbox-support

# Github Desktop
# https://github.com/shiftkey/desktop
#  echo "Installing Github Desktop"
#  snap connect github-desktop:password-manager-service

# Variety
# wallpaper slideshow
# echo "Installing Variety"
# add-apt-repository ppa:peterlevi/ppa
# apt-get update
# apt-get install variety variety-slideshow -y

Komorebi
# parallax wallpaper effects for linux
echo "Installing Komorebi"
wget -O ~/komorebi.deb https://github.com/cheesecakeufo/komorebi/releases/download/v2.1/komorebi-2.1-64-bit.deb
gdebi ~/komorebi.deb -y
rm ~/komorebi.deb

# manual
# sudo add-apt-repository ppa:gnome3-team/gnome3 -y
# sudo add-apt-repository ppa:vala-team -y
# sudo add-apt-repository ppa:gnome3-team/gnome3-staging -y
# sudo apt install cmake valac libgtk-3-dev libgee-0.8-dev libclutter-gtk-1.0-dev libclutter-1.0-dev libwebkit2gtk-4.0-dev libclutter-gst-3.0-dev -y
# git clone https://github.com/cheesecakeufo/komorebi.git
# cd komorebi
# mkdir build && cd build
# cmake .. && sudo make install && ./komorebi

# Stacer
# conky alternative, system overview
# https://linuxconfig.org/system-monitoring-on-ubuntu-18-04-linux-with-stacer
 echo "Installing Stacer"
 wget -O ~/stacer.deb https://jaist.dl.sourceforge.net/project/stacer/v1.0.9/stacer_1.0.9_amd64.deb
 gdebi ~/stacer.deb -n
 rm ~/stacer.deb

# MineTime
# calendar app
# https://minetime.ai/
#  echo "Installing Minetime"
#  wget -0 ~/minetime.deb https://minetime-deploy.herokuapp.com/download/linux_deb_64
#  gdebi ~/minetime.deb -n
#  rm ~/minetime.deb

# MindForger
# markdown power organizer
# https://github.com/dvorka/mindforger-repository/blob/master/memory/mindforger/installation.md#ubuntu-
 echo "Installing MindForger"
 add-apt-repository ppa:ultradvorka/productivity
 apt update
 apt install mindforger

# Pithos
# pandora desktop client
# echo "Installing Pithos"
# add-apt-repository ppa:jonathonf/pithos
# apt update
# apt install pithos

# Keybindings
sudo apt-get install xbindkeys xdotool -y
xbindkeys --defaults > ~/.xbindkeysrc
sudo tee -a ~/.xbindkeysrc <<'EOF'
"xdotool key --clearmodifiers Home"
    Release + Alt + Prior

"xdotool key --clearmodifiers End"
    Release + Alt + Next
EOF

# U-Cleaner
 echo "Installing Ubuntu-Cleaner"
 apt install software-properties-common -y
 add-apt-repository ppa:gerardpuig/ppa -y
 apt update
 apt install -y ubuntu-cleaner

# OpenShot
#  echo "Installing OpenShot"
#  add-apt-repository ppa:openshot.developers/ppa -y
#  apt-get update
#  apt-get install openshot-qt -y

# Gitbook
#  echo "Installing GitBook"
#  wget -0 ~/gitbook.deb https://legacy.gitbook.com/editor/linux-64-bit/download
#  gedbi ~/gitbook.deb
#  rm ~/gitbook.deb

# Gnome Builder
#  echo "Installing Gnome Builder"
#  add-apt-repository ppa:f-muriana/ubuntu-builder -y
#  apt-get update
#  apt install ubuntu-builder -y

#  echo "Installing Redis-Desktop-Manager"
#  snap install redis-desktop-manager
#  echo "Installing Zenkit"
#  snap install zenkit
#  echo "Installing Bitwarden"
#  snap install bitwarden
 echo "Installing Inkscape"
 snap install inkscape
 echo "Installing Fkill"
 snap install fkill
 echo "Installing Discord"
 snap install discord
 echo "Installing Audacity"
 snap install audacity
 echo "Installing GitKraken"
 snap install gitkraken --classic

 # snap install tor
 # snap install spotify
 # snap install ghex-udt
 # snap install buka
 # snap install wallpaperdownloader
 # snap install wireguard
 # snap install auryo
 # snap install gifcurry
 # snap install obs-studio
 # snap install blender --classic
 # snap install polarr
 # sudo apt install kazam

# Hybrid
#  echo "Installing Hybrid"
#  wget -O ~/Downloads/Hybrid.zip http://www.selur.de/sites/default/files/hybrid_downloads/Hybrid_190223_64bit_binary_qt551.zip
#  unzip ~/Downloads/Hybrid.zip -d hybrid
#  rm ~/Downloads/Hybrid.zip
#  chmod 777 ~/Downloads/hybrid
#  ./hybrid/Hybrid

# # FFmpeg
#  echo "Installing FFmpeg"
#  add-apt-repository ppa:mc3man/trusty-media
#  apt update
# https://www.deb-multimedia.org/dists/stable/main/binary-amd64/

# AudioRecorder
 echo "Installing AudioRecorder"
 add-apt-repository ppa:audio-recorder/ppa
 apt update -y
 apt install audio-recorder -y

# Lollypop
# music player
# add-apt-repository ppa:gnumdk/lollypop
# apt update
# apt install lollypop

# guayadeque
# music player
# add-apt-repository ppa:anonbeat/guayadeque
# apt update
# apt install guayadeque

# Handbrake
#  echo "Installing Handbrake"
#  add-apt-repository ppa:stebbins/handbrake-releases
#  apt update
#  apt install handbrake-gtk
#  apt install handbrake-cli

# mkusb gui
#  echo "Installing mkusb/gui"
#  sudo add-apt-repository ppa:mkusb/ppa
#  apt update
#  apt install mkusb mkusb-nox usb-pack-efi -y

# Phonascus
# http://www.lenmus.org/en/phonascus/download-linux
# http://www.lenmus.org/en/phonascus/faq01
#  echo "Installing Phonascus/Lenmus"
#  sudo add-apt-repository ppa:lenmus-phonascus/ppa
#  sudo apt-get update
#  sudo apt-get install lenmus

#  # req synthesizer
#  # https://help.ubuntu.com/community/Midi/SoftwareSynthesisHowTo
#  wget -O ~/Downloads/zynadd.tar.bz2 https://sourceforge.net/projects/zynaddsubfx/files/zynaddsubfx/3.0.3/zynaddsubfx-3.0.3.tar.bz2/download
#  tar -vxjf zynadd.tar.bz2
#  cd zynadd/
#  sudo make install
#  rm ~/zynadd.tar.bz2

## Flatpaks
### commands: http://docs.flatpak.org/en/latest/flatpak-command-reference.html
### flatpak search, flatpak run

# AppEditor
#  echo "Installing AppEditor"
#  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#  flatpak install flathub com.github.donadigo.appeditor
#  # flatpak run com.github.donadigo.appeditor
#  cp /var/lib/flatpak/exports/share/applications/com.github.donadigo.appeditor.desktop /usr/share/applications/alacarte.desktop

# Bookworm
# pdf / ebook reader
#  echo "Installing Bookworm"
#  add-apt-repository ppa:bookworm-team/bookworm
#  apt update
#  apt install com.github.babluboy.bookworm
# flatpak install --from https://flathub.org/repo/appstream/com.github.babluboy.bookworm.flatpakref
# flatpak run com.github.babluboy.bookworm

# add the desktop file to gnome menu
# https://developer.gnome.org/integration-guide/stable/desktop-files.html.en
# /var/lib/flatpak/exports/share/applications/com.github.babluboy.bookworm.desktop
# cp /var/lib/flatpak/exports/share/applications/com.github.babluboy.bookworm.desktop /usr/share/applications/bookworm.desktop

# add a desktop icon
# /usr/share/icons
# alacarte

# Gnome-Books
# cp /var/lib/flatpak/exports/share/applications/org.gnome.Books.desktop /usr/share/applications/gnome-books.desktop

# qt apps theme env (?)
# /etc/environment

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
 wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

 sudo tee -a ~/.zshrc <<'EOF'
# auto ls
chpwd() {
  ls -a
}

# This loads nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
EOF

#  nvm install node
#  nvm use node

# NPM packages
 echo "Installing NPM packages"
 # ungit
npm install -g ungit

# Ruby
 echo "Installing Ruby"
# curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
# curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
 apt install gcc g++ make -y
 echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

 apt update
 sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev

# Rbenv
#  echo "Installing Rbenv"
#  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
# echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
# echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
# echo 'eval "$(rbenv init -)"' >> ~/.bashrc
# echo 'eval "$(rbenv init -)"' >> ~/.zshrc
#  /usr/bin/zsh

#  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
#  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
#  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.zshrc
#  /usr/bin/zsh

#  rbenv install 2.5.3
#  rbenv global 2.5.3

# Chruby
#  echo "Installing Chruby"
#  wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
#  tar -xzvf chruby-0.3.9.tar.gz
#  cd chruby-0.3.9/
#  sudo make install
#  rm ~/chruby-0.3.9.tar.gz

#  # Ruby-Install
#  echo "Installing Ruby-Install"
#  wget -O ruby-install-0.7.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.7.0.tar.gz
#  tar -xzvf ruby-install-0.7.0.tar.gz
#  cd ruby-install-0.7.0/
#  sudo make install
#  rm ~/ruby-install-0.7.0.tar.gz

#  ruby-install ruby

#  ruby -v
#  gem install bundler

# Rails
 gem install rails
 rbenv rehash
 rails -v

# Postgres
#  echo "Installing Postgresql"
#  sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
#  wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
#  apt update
#  apt install -y postgresql-common
#  apt install -y postgresql-9.5 libpq-dev

 # sudo -u postgres createuser chris -s

 # If you would like to set a password for the user, you can do the following
 # sudo -u postgres psql
 # postgres=# \password chris

 echo "Downloading config files"
 git clone git@github.com:CTAnthny/linux-setup.git $HOME/linux-setup-master
 echo "Copying config files"
 cp ~/linux-setup-master/colors/Cobalt_Neon.itermcolors $HOME/.config/colors/Cobalt_Neon.itermcolors
 cp ~/linux-setup-master/colors/Molokai.itermcolors $HOME/.config/colors/Molokai.itermcolors
 cp ~/linux-setup-master/vscode.settings.json $HOME/.config/Code/User/settings.json
 cp ~/linux-setup-master/vscode.keybindings.json $HOME/.config/Code/User/keybindings.json
 cp ~/linux-setup-master/.zulu/alias $HOME/.zulu/alias

# bash
#  PKGS=$(<$HOME/linux-setup-master/vscode.packages)
#  for pkg in "${PKG[@]}"
#  do
#   code --install-extension $pkg
#  done

# zsh
while read pkg; do code --install-extension "$pkg"; done < $HOME/linux-setup-master/vscode.packages

# Docker
# https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository
  echo "Installing Docker"
  apt update
  apt install apt-transport-https ca-certificates gnupg-agent software-properties-common -y
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  # verify
  # apt-key fingerprint 0EBFCD88
  # 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
  add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
  apt update
  apt install docker-ce docker-ce-cli containerd.io -y

 echo "Installing Docker-compose"
 sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
 chmod +x /usr/local/bin/docker-compose
 docker-compose --version

 echo "Adding docker-compose command completion"
 # bash
 sudo curl -L https://raw.githubusercontent.com/docker/compose/1.25.5/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
 # oh-my-zsh (~/.zshrc)
 # plugins=(docker)
 mkdir -p ~/.zsh/completion
 curl -L https://raw.githubusercontent.com/docker/compose/1.25.5/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
#  sudo tee -a ~/.zshrc << EOF
  # # docker compose completions
  # fpath=(~/.zsh/completion $fpath)
  # autoload -Uz compinit && compinit -i
# EOF
 # Add user permissions to docker group
 # https://techoverflow.net/2017/03/01/solving-docker-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket/
 # https://stackoverflow.com/questions/48957195/how-to-fix-docker-got-permission-denied-issue
 sudo groupadd docker
 sudo usermod -a -G docker $USER
 sudo systemctl restart docker
 # reload shell
 # exec $SHELL -l
 # TODO add docker id variable to sh

# Google Cloud SDK
 echo "Installing Google Cloud SDK"
# Create environment variable for correct distribution
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-293.0.0-linux-x86_64.tar.gz
tar zxvf google-cloud-sdk-293.0.0-linux-x86_64.tar.gz google-cloud-sdk
./google-cloud-sdk/install.sh

# Initialize the SDK
# gcloud init

# Kubernetes CLI
# https://kubernetes.io/docs/tasks/tools/install-kubectl/
echo "Installing Kubernetes CLI"
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
# zsh autocompletion
sudo tee -a ~/.zshrc << EOF
# kubernetes cli autocompletion
source <(kubectl completion zsh)
EOF
# If you get an error like complete:13: command not found: compdef, then add the following to the beginning of your ~/.zshrc file:
# autoload -Uz compinit
# compinit

# Jenkins X
# https://jenkins-x.io/getting-started/install/
echo "Installing Jenkins X"
mkdir -p ~/.jx/bin
curl -L https://github.com/jenkins-x/jx/releases/download/v1.3.980/jx-linux-amd64.tar.gz | tar xzv -C ~/.jx/bin
export PATH=$PATH:~/.jx/bin
echo 'export PATH=$PATH:~/.jx/bin' >> ~/.bashrc
echo 'export PATH=$PATH:~/.jx/bin' >> ~/.zshrc

# Mongo
# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/
#  echo "Installing MongoDB"
#  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
#  echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
#  apt update
#  apt install -y mongodb-org
 # sudo service mongod start
 # sudo cat /var/log/mongodb/mongod.log | grep [initandlisten]
 # sudo service mongod restart
 # mongo (connect to a mongod that is running on your localhost with default port 27017)

# Android Studio
# sudo snap install android-studio --classic

# Gitlab
# https://about.gitlab.com/install/#ubuntu
# apt update
# apt install -y openssh-server ca-certificates
# apt install -y postfix
# curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
# EXTERNAL_URL="http://gitlab.ctanthny.com" apt install gitlab-ee

# echo "Adding Gitlab SSH"
# # https://docs.gitlab.com/ee/ssh/
# ssh-keygen -o -t rsa -b 4096 -C "ctanthny@gmail.com"
# $HOME/.ssh/gl_id_rsa
# eval $(ssh-agent -s)
# ssh-add ~/.ssh/gl_id_rsa
# sudo tee ~/.ssh/config <<EOF
# # GitLab.com
# Host gitlab.com
#   Preferredauthentications publickey
#   IdentityFile ~/.ssh/gl_id_rsa

# # GitHub.com
# Host github.com
#   Preferredauthentications publickey
#   IdentityFile ~/.ssh/id_rsa
# EOF

# xclip -sel clip < ~/.ssh/gl_id_rsa.pub
# # add to gitlab origin
# # https://gitlab.com/profile/keys
# ssh -T git@gitlab.com

# Wiki.js
# https://docs.requarks.io/wiki/install/installation
# cd ~ && mkdir Work && cd ~/Work && mkdir Blog && cd Blog
# curl -sSo- https://wiki.js.org/install.sh | bash
# node wiki configure
# visit localhost:3000

# Extras
#  echo "Installing Bacula"
#  apt install -y bacula

# Bad! Permission issues:
# snap install docker

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

# Lector
# pdf / ebook reader
# echo "Installing Lector"
# apt install python3-pyqt5
# pip3 install lxml beautifulsoup4 xmltodict pymupdf setuptools
# cd ~ && git clone git@github.com:BasioMeusPuga/Lector.git
# cd Lector && python3 setup.py build
# sudo python3 setup.py install
# lector/__main__.py

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
 rm steam.deb

# PlayOnLinux
 echo "Installing Play On Linux"
 apt install -y playonlinux

# Wine
# https://wiki.winehq.org/Ubuntu
 echo "Installing Wine"
 wget -nc https://dl.winehq.org/wine-builds/winehq.key
 apt-key add winehq.key
 rm ~/winehq.key

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

# Droid Sans
 echo "Installing Droid Sans"
 wget -O ~/Downloads/droid-sans.zip "https://www.fontsquirrel.com/fonts/download/droid-sans"
 unzip droid-sans.zip
 rm droid-sans.zip

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
 sudo add-apt-repository ppa:xenatt/xenlism
 sudo apt-get update
 sudo apt-get install xenlism-minimalism-theme -y
 sudo apt-get install xenlism-wildfire-icon-theme

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
#  sudo add-apt-repository ppa:landronimirc/skippy-xd -y
 ### skippy-xd --activate-window-picker
 ### startup: skippy-xd --start-daemon

 ## Configure redis
 ### https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-18-04
 ### supervised [directive] no -> systemd
 ### sudo systemctl restart redis.service

 ## Postgres
 ### (?) necessary?
 ### https://stackoverflow.com/questions/2942485/psql-fatal-ident-authentication-failed-for-user-postgres
 ### sudo -u postgres psql
 ### \password
 ### postgres
 ### \q

 ## Sophos
 ### https://community.sophos.com/kb/en-us/14378
 ### https://docs.sophos.com/esg/SAV-Linux/help/en-us/PDF/sav_linux_sg.pdf
 ### http://docs.sophos.com/esg/SAV-Linux/help/en-us/PDF/sav_linux_cg.pdf
 
 ### status: /opt/sophos-av/bin/savdstatus
 ### boot startup: sudo /opt/sophos-av/bin/savdctl enableOnBoot savd
 ### check startup success: savd: sudo /opt/sophos-av/bin/savconfig query EnableOnStart
 ### start on-access scanning: sudo /opt/sophos-av/bin/savdctl enable
 ### start the installed service sav-protect: sudo /etc/init.d/sav-protect start OR service sav-protect start
 ### stop on-access scanning: sudo /opt/sophos-av/bin/savdctl disable

 #### https://community.sophos.com/kb/en-us/12176
 ### schedule on-demand scan: crontab -u root -e // i (insert) // esc (exit) // ZZ (create)
 ### minute(0-59) hour(0-23) day_of_month(1-31) month(1-12) day_of_week(0-7) /path/script.sh
 ### 0 10 * * * /path/script.sh is the same as 0 10 1-31 1-12 0-7 /path/script.sh

 ### start on-demand scan: savscan /
 ### scan all file types (not just exe, but likely false positives): savscan / --all
 ### scan bootsector of all logical drives: savscan -bs
 ### scan mbr of all drives: savscan -mbr
 ### quarantine (path is location): savscan path --quarantine
 ### disinfect: savscan path -di
 ### disinfect all: savscan / -di
 ### remove: savscan path --remove
 ### log: savlog

 ## Sync accounts under settings

 ## Set Plank (Plank Preferences) to 'autohide'

 ## Budgie keyboard shortcuts fix
 ### https://discourse.ubuntubudgie.org/t/volume-up-down-calculator-ctr-altl-t-windows-key-a-and-more-not-working-anymore/140/67
 ### nohup budgie-wm --replace &
 ### add as a startup command
 ### gnome settings -> region&language and there, click on “manage installed languages” then changed “keyboard input method system” to none instead of ibus. Logout and login.

 # Resources:
 # https://www.ubuntupit.com/an-ultimate-list-of-ethical-hacking-and-penetration-testing-tools-for-kali-linux/
 # https://github.com/archerysec/archerysec/releases
 # http://qwinff.github.io/features.html

 ## video drivers
 # https://linuxconfig.org/how-to-install-the-nvidia-drivers-on-ubuntu-18-04-bionic-beaver-linux
