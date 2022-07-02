export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

DENO_INSTALL="$HOME/.deno"

cowsay_styles=("apt" "fox" "sheep" "bud-frogs" "ghostbusters" "skeleton" "bunny" "gnu" "snowman" "calvin" "hellokitty" "stegosaurus" "cheese" "kangaroo" "stimpy" "cock" "kiss" "suse" "cower" "koala" "three-eyes" "daemon" "kosh" "turkey" "default" "luke-koala" "turtle" "dragon" "mech-and-cow" "tux" "dragon-and-cow" "milk" "unipony" "duck" "moofasa" "unipony-smaller" "elephant" "moose" "vader" "elephant-in-snake" "pony" "vader-koala" "eyes" "pony-smaller" "www" "flaming-sheep" "ren")
COWSAY_STYLE=${cowsay_styles[$RANDOM % ${#cowsay_styles[@]} ]}

fortune | cowsay -f $COWSAY_STYLE

PROJDIR=~/Projects

# mkcd <directory>
mkcd () {
    mkdir $1 && cd $1
}

# extract <files...>
extract () {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
        return 1
    else
        for n in $@
        do
            if [ -f "$n" ] ; then
                case "${n%,}" in
                    *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                    tar xvf "$n"       ;;
                    *.lzma)      unlzma ./"$n"      ;;
                    *.bz2)       bunzip2 ./"$n"     ;;
                    *.rar)       unrar x -ad ./"$n" ;;
                    *.gz)        gunzip ./"$n"      ;;
                    *.zip)       unzip ./"$n"       ;;
                    *.z)         uncompress ./"$n"  ;;
                    *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                    7z x ./"$n"        ;;
                    *.xz)        unxz ./"$n"        ;;
                    *.exe)       cabextract ./"$n"  ;;
                    *)
                        echo "extract: '$n' - unknown archive method"
                        return 1
                    ;;
                esac
            else
                echo "'$n' - file does not exist"
                return 1
            fi
        done
    fi
}

home () {
    cd ~
    clear
    source ~/.bashrc
}

# projdir [project]
projdir () {
    cd $PROJDIR
    if ! [ -z $1 ] ; then
        cd $1
    fi
}

# reload () {
#     unalias -a
#     source ~/.bashrc
# }

my-ip () {
    printf " --- IP Information --- \n"
    printf "${blue}Internal: ${reset}%s\n" $(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -1)
    printf "${blue}External: ${reset}%s\n" $(curl -s http://ifconfig.io)
    printf " ---------------------- \n"
}

# bg <command>
bg () {
    nohup $@ &> /dev/null &
}

# gcme <repo>
gcme () {
    git clone git@github.com:funnyboy-roks/$1.git $2
}

# idea [file]
idea () {
    bg intellij-idea-ultimate $@ > /dev/null
}

# -------
# Aliases
# -------
alias l="ls"
alias ll="ls -Al"
alias lsa="ls -A"
alias lha="ls -lhA"
alias open="nemo"
alias instdir="cd ~/.config/gdlauncher_next/instances"
alias please="sudo"
alias python="python3"
alias python="python3"
alias mkdir="mkdir -pv"
alias ghdir="proj"
alias t="$HOME/Documents/todo-cli/todo.sh"


# ----------------------
# Git Aliases
# ----------------------
alias ga='git add'
alias gaa='git add -A'
alias gas='git add src/'
alias gc='git commit'
alias gcm='git commit -m'
alias gd='git diff'
alias gi='git init'
alias gl='git log'
alias gp='git pull'
alias gpsh='git push'
alias gss='git status -s'
alias gsa='git-stats -a'

PATH=$PATH:$HOME/.local/bin
source $HOME/.cargo/env