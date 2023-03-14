# Note: This file is not meant to be executed.
# Each line is meant to be run manually by the user.

# Ignore the following line, it's just to keep people(me) from accidentally executing this script
echo "Don't run this script directly!" && exit

# ---------------------------------------------------------------
#  Now would be the time to setup SSH keys (Ideally copied over)
# ---------------------------------------------------------------

cd ~ # Go home
git clone git@github.com:funnyboy-roks/personal-config.git personal-config --recurse-submodule -j8
cd personal-config
./gen-links.sh
cd ~

# Zsh install & setup
sudo apt install zsh && chsh -s $(which zsh)
# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
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
rm -r ~/Templates ~/Music

# Install yay

# Install unison
yay -S unison

# Install Rust/Cargo and some tools
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install alacritty exa cargo-expand onefetch fd-find proximity-sort

# Install NeoVim
yay -S neovim

# Install i3wm and corrosponding requirements
yay -S i3 i3lock polybar autorandr arandr feh compton flameshot dunst ulauncher

# Remove firefox if pre-installed (Ubuntu)
# Install firefox developer edition
yay -S firefox-developer-edition

# Install snaps (Not sure if necessary with yay)

# Install AutoKey
yay -S autokey-gtk autokey-common

# Install some nodejs things
yay -s nodejs npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Install & Setup Nemo
yay -S nemo
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
gsettings set org.gnome.desktop.background show-desktop-icons false
gsettings set org.nemo.desktop show-desktop-icons true

# Install Apps
yay -S guake spotify discord mupdf

# Random other packages
yay -S jre-openjdk
