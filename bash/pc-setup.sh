#!/bin/bash

# A script to setup the basics of my pc

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

# Install NodeJS
sudo apt install nodejs -y

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
