source ~/.config/nvim/base16/shell/scripts/base16-circus.sh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZDOTDIR=~/.zsh/zim

#prompt_newline="​ "
zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:git:dirty color 242


# Start configuration added by Zim install {{{
setopt HIST_IGNORE_ALL_DUPS

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
#bindkey -v

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# Module configuration

# git
# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

# input
# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

# termtitle
# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

# zsh-autosuggestions
# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# zsh-syntax-highlighting

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# Initialize Zim Modules
ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# Post-init module configuration
# zsh-history-substring-search
zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



# Personal Config

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
        for n in $@; do
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

gcd () {
    git clone $1 $2
    if ! [ -z $2 ] ; then
        cd $2
    else
        cd "${"$(basename $1)"%.*}"
    fi
}

# Takes an optional time and then copies the discord format
# to the keyboard and prints to stdout
# 
# If time is not specified, then uses the current time
dt () {
    flag=""
    case "$1" in;
        '-d') flag=":d" ;;
        '-D') flag=":D" ;;
        '-t') flag=":t" ;;
        '-T') flag=":T" ;;
        '-f') flag=":f" ;;
        '-R') flag=":R" ;;
    esac
    echo "$flag"

    args=$(echo "$@")
    out=""
    if ! [ -z $args ]; then
        out=$(date +"<t:%s$flag>" -d "$args")
    else
        out=$(date +"<t:%s$flag>")
    fi
    echo "$out"
    printf "$out" | xclip -i -selection clipboard
}

sh ~/.config/nvim/base16/shell/scripts/base16-circus.sh

JAVA_HOME="/usr/lib/jvm/default"
PATH="$PATH:$HOME/.cargo/bin:$HOME/scripts:$HOME/.local/bin:/var/lib/snapd/snap/bin"

eval $(thefuck --alias)
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Init fzf (^T)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias l="exa"
alias ll="exa -lhFa --icons --git"
alias instdir="cd ~/.config/gdlauncher_next/instances"
alias python="python3"
alias mkdir="mkdir -pv"
alias tree="exa -ThFa --icons --git -I 'target|node_modules|venv'"
alias :q="exit"

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

#eval "$(atuin init zsh --disable-up-arrow)"
source ~/.zsh/atuin.zsh # This is needed because ^^^ outputs on a single line
