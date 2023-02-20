# Note: This file is not meant to be executed.
# Each line is meant to be run manually by the user.

sudo apt update
sudo apt upgrade

# ------------------------------------------------
#  Now would be the time to setup GitHub SSH keys
# ------------------------------------------------

cd ~ # Go home
git clone git@github.com:funnyboy-roks/personal-config.git config --recurse-submodule -j8
cd config
./gen-links.sh
cd ~

# Zsh install & setup
sudo apt install zsh && chsh -s $(which zsh)
# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# You're supposed to restart zsh now in order to activate pl10k, however for
# the configuration, I'd recommend waiting until after settup links to the
# personal-config repo.
# Restart using `exec zsh` or just restart the terminal

# Setup some filesystem stuff
mkdir -p ~/dev # This is for dev stuff
mkdir -p ~/sync # This is for syncing via Unison
# I really don't like these default dir names :P
mv ~/Documents ~/documents
mv ~/Downloads ~/downloads
mv ~/Pictures  ~/pictures
mv ~/Videos    ~/videos
mv ~/Desktop   ~/desktop
rm -r ~/Music
sudo apt install unison

# Install Rust/Cargo and some tools
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install alacritty exa cargo-expand onefetch fd-find proximity-sort

# Install NeoVim
cd /usr/bin/
sudo curl -Lo nvim https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod +x
cd ~

# Install i3wm and corrosponding requirements
sudo apt install i3 i3lock polybar autorandr arandr feh compton flameshot dunst numlockx
sudo add-apt-repository ppa:agornostal/ulauncher && sudo apt update && sudo apt install ulauncher

# Remove default firefox (like in Ubuntu)
# If firefox is not installed, this can be ignored
sudo apt-get remove firefox
sudo snap remove firefox

# Install firefox developer edition
sudo mkdir -p /opt
cd /opt
curl --location "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US" | sudo tar --extract --verbose --preserve-permissions --bzip2
sudo ln -s /opt/firefox/firefox /usr/bin/firefox
cd ~

# Install some snaps
# (Make sure snap is installed first...)
sudo snap install discord
sudo snap install spotify

# Install AutoKey
sudo apt install autokey-gtk

# Install some nodejs things
sudo apt install nodejs nvim -y
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Install & Setup Nemo
sudo apt install nemo -y
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
gsettings set org.gnome.desktop.background show-desktop-icons false
gsettings set org.nemo.desktop show-desktop-icons true

# Install VSCode
sudo snap install code --classic

# Note: Install JetBrains toolbox from https://www.jetbrains.com/toolbox-app/

# Install Guake
sudo apt install guake

# Random other packages
sudo apt install mupdf openjdk-18-jdk
