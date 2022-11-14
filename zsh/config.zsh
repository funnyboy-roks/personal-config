PROJDIR=~/dev

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

# dev [project-group]
dev () {
    cd $PROJDIR
    if ! [ -z $1 ] ; then
        cd $1
    fi
}

# Sync local files with server files
fsa () {
    # Requires server and client to be setup with unison (https://github.com/bcpierce00/unison)
    # `server` hostname is from ssh config
    unison -auto -batch ~/sync ssh://server/sync
}

# Sync local files with server files
fs () {
    unison -auto ~/sync ssh://server/sync
}

my-ip () {
    printf " --- IP Information --- \n"
    printf "${blue}Internal: ${reset}%s\n" $(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
    printf "${blue}External: ${reset}%s\n" $(curl -s http://ifconfig.io)
    printf " ---------------------- \n"
}

# bg <command>
bg () {
    setsid $@ &> /dev/null &
}

# gcme <repo>
gcme () {
    git clone git@github.com:funnyboy-roks/$1.git $2

    if ! [ -z $2 ] ; then
        cd $2
    else
        cd $1
    fi
}

unalias gcd
gcd () {
    git clone $1 $2
    if ! [ -z $2 ] ; then
        cd $2
    else
        cd "${"$(basename $1)"%.*}"
    fi
}

# Aliases
alias ll="ls -Al"
alias instdir="cd ~/.config/gdlauncher_next/instances"
alias python="python3"
alias mkdir="mkdir -pv"
#alias idea="bg idea"

# Git Aliases
alias ga='git add'
alias gaa='git add -A'
alias gas='git add src'
alias gc='git commit'
alias gcm='git commit -m'
alias gd='git diff'
alias gl='git log'
alias gp='git pull'
alias gpsh='git push'
alias gss='git status -s'
