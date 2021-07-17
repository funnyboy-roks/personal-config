HOST_NAME=funnyboy_roks
GHDIR='~/Documents/GitHub'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

shopt -s autocd
shopt -s histappend

export PATH=$PATH:$HOME/bin

export HISTSIZE=5000
export HISTFILESIZE=10000

# bind '"\e[A": history-search-backward'
# bind '"\e[B": history-search-forward'

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtcyn='\e[0;36m' # Cyan
txtblu='\e[0;34m' # Blue
bldgrn='\e[1;32m' # Bold Green
bldpur='\e[1;35m' # Bold Purple
txtrst='\e[0m'  # Text Reset

# clocks=("🕛" "🕐" "🕑" "🕒" "🕓" "🕔" "🕕" "🕖" "🕗" "🕘" "🕙" "🕚" "🕛" "🕐" "🕑" "🕒" "🕓" "🕔" "🕕" "🕖" "🕗" "🕘" "🕙" "🕚")
# CLOCK=${clocks[$(date +"%H")]} # Get the clock for the current hour

cl_prefixes=("$txtbluπ" "$txtbluλ" "💻" "🌎" "$txtblu⚙ " "$txtblu</>" "✅" "$CLOCK")

# Cowsay styles
cowsay_styles=("apt" "fox" "sheep" "bud-frogs" "ghostbusters" "skeleton" "bunny" "gnu" "snowman" "calvin" "hellokitty" "stegosaurus" "cheese" "kangaroo" "stimpy" "cock" "kiss" "suse" "cower" "koala" "three-eyes" "daemon" "kosh" "turkey" "default" "luke-koala" "turtle" "dragon" "mech-and-cow" "tux" "dragon-and-cow" "milk" "unipony" "duck" "moofasa" "unipony-smaller" "elephant" "moose" "vader" "elephant-in-snake" "pony" "vader-koala" "eyes" "pony-smaller" "www" "flaming-sheep" "ren")

CL_PREFIX=${cl_prefixes[$RANDOM % ${#cl_prefixes[@]} ]}
COWSAY_STYLE=${cowsay_styles[$RANDOM % ${#cowsay_styles[@]} ]}

print_before_the_prompt () {
    dir=$PWD
    home=$HOME
    dir=${dir/"$HOME"/"~"}
    printf "\n $txtred%s: $bldpur%s $txtgrn%s\n$txtrst" "$HOST_NAME" "$dir" "$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')"
}

PROMPT_COMMAND=print_before_the_prompt
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# PS1="$CL_PREFIX$txtrst> "
PS1="$CL_PREFIX$txtgrn> "

fortune | cowsay -f $COWSAY_STYLE

mkcd () {
    mkdir $1 && cd $1
}

git-log () {
    git log --author=$1 --shortstat $2 | \
    awk '/^ [0-9]/ { f += $1; i += $4; d += $6 } \
    END { printf("%d files changed, %d insertions(+), %d deletions(-)", f, i, d) }'
}

js () {
    node "$HOME/.scripts/$1.js" $2
}

function extract {
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

html-template () {
    touch index.js
    echo '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    
    <script src="index.js"></script>
</body>
</html>' > index.html
}

mvncp () {
    cp "$GHDIR/$1/target/$2" "./plugins/"
}

# -------
# Aliases
# -------
alias l="ls"
alias ll="ls -Al"
alias lsa="ls -A"
alias lha="ls -lhA"
alias open="nautilus"
alias ghdir="cd ~/Documents/GitHub && cd ./"
alias please="sudo"
alias python="python3"

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
