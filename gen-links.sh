#!/bin/bash
# Create the links for all the config files to this directory
# _Note: This will rename any previous dir to "${DIR}_OLD"_

function mkln () {
    from="$1"
    to="$2"

    if ! [ -L "$to" ]; then # Move if it is not a link
        mv "$to" "$to_OLD" > /dev/null && echo "Moved $to to $to_OLD"
    else # Otherwise, yeet it
        target="$(readlink -f "$to")"
        rm "$to" && echo "Removed previous link ${to/$HOME/~} -> ${target/$HOME/~}"
    fi
    ln -s "$(pwd)/$from" "$to"
}

mkln "i3"                  "$HOME/.config/i3"
mkln "fish/config.fish"    "$HOME/.config/fish/config.fish"
mkln ".vimrc"              "$HOME/.vimrc"
mkln "alacritty"           "$HOME/.config/alacritty"
mkln "nvim"                "$HOME/.config/nvim"
mkln "ulauncher"           "$HOME/.config/ulauncher"
mkln "autorandr"           "$HOME/.config/autorandr"
mkln "picom"               "$HOME/.config/picom"
mkln ".xinitrc"            "$HOME/.xinitrc"

mkln "lemurs/config.toml"  "/etc/lemurs/config.toml" # This may need sudo to run
mkln "lemurs/wms"          "/etc/lemurs/wms" # This may need sudo to run
