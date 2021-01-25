HOST_NAME=funnyboy_roks

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
bldgrn='\e[1;32m' # Bold Green
bldpur='\e[1;35m' # Bold Purple
txtrst='\e[0m'    # Text Reset

clocks=("🕛" "🕐" "🕑" "🕒" "🕓" "🕔" "🕕" "🕖" "🕗" "🕘" "🕙" "🕚" "🕛" "🕐" "🕑" "🕒" "🕓" "🕔" "🕕" "🕖" "🕗" "🕘" "🕙" "🕚")
CLOCK=${clocks[$(date +"%H")]} # Get the clock for the current hour


prefixes=("$txtcynπ" "$txtcynλ" "💻" "🌎" "⚙ " "$txtcyn</>" "✅" "$CLOCK")

# Cowsay styles
cowsay_styles=("apt" "fox" "sheep" "bud-frogs" "ghostbusters" "skeleton" "bunny" "gnu" "snowman" "calvin" "hellokitty" "stegosaurus" "cheese" "kangaroo" "stimpy" "cock" "kiss" "suse" "cower" "koala" "three-eyes" "daemon" "kosh" "turkey" "default" "luke-koala" "turtle" "dragon" "mech-and-cow" "tux" "dragon-and-cow" "milk" "unipony" "duck" "moofasa" "unipony-smaller" "elephant" "moose" "vader" "elephant-in-snake" "pony" "vader-koala" "eyes" "pony-smaller" "www" "flaming-sheep" "ren")

PREFIX=${prefixes[$RANDOM % ${#prefixes[@]} ]}
COWSAY_STYLE=${cowsay_styles[$RANDOM % ${#cowsay_styles[@]} ]}

print_before_the_prompt () {
    dir=$PWD
    home=$HOME
    dir=${dir/"$HOME"/"~"}
    printf "\n $txtred%s: $bldpur%s $txtgrn%s\n$txtrst" "$HOST_NAME" "$dir" "$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')"
}

PROMPT_COMMAND=print_before_the_prompt
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
PS1="$PREFIX$txtrst> "

fortune | cowsay -f $COWSAY_STYLE

mkcd () {
	mkdir $1 && cd $1
}

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

# -------
# Aliases
# -------
alias l="ls"
alias ll="ls -Al"
alias lsa="ls -A"
alias lha="ls -lhA"
alias open="nautilus"
alias ghdir="cd ~/Documents/GitHub/"
alias please="sudo"
alias python="python3"

# ----------------------
# Git Aliases
# ----------------------
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gd='git diff'
alias gi='git init'
alias gl='git log'
alias gp='git pull'
alias gpsh='git push'
alias gss='git status -s'
