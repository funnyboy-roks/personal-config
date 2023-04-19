if status is-interactive
    atuin init fish --disable-up-arrow | source
    sh ~/.config/nvim/base16/shell/scripts/base16-circus.sh

    set JAVA_HOME "/usr/lib/jvm/default"
    set PATH "$PATH:$HOME/.cargo/bin:$HOME/scripts:$HOME/.local/bin:/var/lib/snapd/snap/bin"

    thefuck --alias | source

    # Init fzf (^T)
    #[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
end
 
set PROJDIR ~/dev

# mkcd <directory>
function mkcd
    mkdir $argv[1] && cd $argv[1]
end

# extract <files...>
function extract
    if test -z $argv[1]
        # display usage if no parameters given
        echo 'Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>'
        echo '       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]'
    else
        for n in $argv
            if test -f $n
                switch (n%,)
                    case '*.tar' '*.tar.*'
                        tar xvf "$n"
                    case '*.lzma'
                        unlzma ./"$n"
                    case '*.bz2'
                        bunzip2 ./"$n"
                    case '*.rar'
                        unrar x -ad ./"$n"
                    case '*.gz'
                        gunzip ./"$n"
                    case '*.zip'
                        unzip ./"$n"
                    case '*.z'
                        uncompress ./"$n"
                    case '*.7z' '*.arj' '*.cab' '*.chm' '*.deb' '*.dmg' '*.iso' '*.lzh' '*.msi' '*.rpm' '*.udf' '*.wim' '*.xar'
                        7z x ./"$n"
                    case '*.xz'
                        unxz ./"$n"
                    case '*.exe'
                        cabextract ./"$n"
                    case '*'
                        echo "extract: '$n' - unknown archive method"
                end
            else
                echo "'$n' - file does not exist"
            end
        end
    end
end

# Sync local files with server files
function fsa
    # Requires server and client to be setup with unison (https://github.com/bcpierce00/unison)
    # `server` hostname is from ssh config
    unison -auto -batch ~/sync ssh://server/sync
end

# Sync local files with server files
function fs
    unison -auto ~/sync ssh://server/sync
end

function my-ip
    printf " --- IP Information --- \n"
    printf "{$blue}Internal: {$reset}%s\n" $(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
    printf "{$blue}External: {$reset}%s\n" $(curl -s http://ifconfig.io)
    printf " ---------------------- \n"
end

# bg <command>
function bg
    setsid $argv &> /dev/null &
end

# gcme <repo>
function gcme
    # I'm used to bash :P
    set 1 $argv[1]
    set 2 $argv[2]

    git clone git@github.com:funnyboy-roks/$1.git $2

    if not test -z $2
        cd $2
    else
        cd $1
    end
end

function gcd
    git clone $argv[1] $argv[2]
    if not test -z $argv[2]
        cd $argv[2]
    else
        cd (path change-extension '' (basename $argv[1]))

    end
end

# Abbreviations
abbr -a vim nvim
abbr -a vimdiff 'nvim -d'

# Aliases (Not abbrs because I don't want all of this garbage in the console)
alias l "exa"
alias ll "exa -lhFa --icons --git"
alias instdir "cd ~/.config/gdlauncher_next/instances"
alias python "python3"
alias mkdir "mkdir -pv"
alias :q "exit"

# Git Aliases
alias ga 'git add'
alias gaa 'git add -A'
alias gas 'git add src'
alias gc 'git commit'
alias gcm 'git commit -m'
alias gd 'git diff'
alias gl 'git log'
alias gp 'git pull'
alias gpsh 'git push'
alias gss 'git status -s'
