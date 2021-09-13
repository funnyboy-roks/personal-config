#!/bin/bash

# A script to setup the basics of my pc
# Run with curl -sL https://raw.githubusercontent.com/funnyboy-roks/personal-config/main/bash/pc-setup.sh | bash

sudo apt update
sudo apt upgrade

# Uninstall defaults
sudo apt-get remove firefox

# Install Firefox
sudo mkdir -p /opt
cd /opt
curl --location "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US" | sudo tar --extract --verbose --preserve-permissions --bzip2
sudo ln -s /opt/firefox/firefox /usr/bin/firefox

# Install Discord
sudo snap install discord

# Install AutoKey
sudo apt install autokey-qt
cd ~/.config/autokey/data
curl -o .PipeChar.json https://gist.githubusercontent.com/funnyboy-roks/fa2f5e4c03ddf5bdb71c60c441e552b0/raw/30d177cc3308f8d094bf3902a13d3850c9dc20b3/.PipeChar.json
echo '|' >> PipeChar.txt
curl -o .Backslash.json https://gist.githubusercontent.com/funnyboy-roks/2cfa90233aaa0d0c40105dd405f05124/raw/ba064f4c670235fadc97db78ba5facfd2ec88134/.Backslash.json
echo '\' >> Backslash.txt
cd ~

# Install NodeJS
sudo apt install nodejs npm -y
# Install Nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# Basic npm packages
sudo npm i -g npm license gitignore lite-server

# Install nemo
sudo apt install nemo -y
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
gsettings set org.gnome.desktop.background show-desktop-icons false
gsettings set org.nemo.desktop show-desktop-icons true

# Install IDES
sudo snap install intellij-idea-community --classic
sudo snap isntall code --classic

# Install Guake
sudo apt-get install guake

# Setup file system
mkdir -p ~/Projects

# Setup .bashrc
curl https://raw.githubusercontent.com/funnyboy-roks/personal-config/main/bash/.bashrc >> ~/.bashrc

# Install required cli tools
sudo apt install git -y

# Install useful cli tools
sudo apt install cowsay fortune-mod -y
