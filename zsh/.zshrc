# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export JAVA_HOME="/usr/lib/jvm/default"
export PATH="$PATH:$HOME/scripts:$HOME/.local/bin:/var/lib/snapd/snap/bin"

source $HOME/.cargo/env

# Setup OMZ
export ZSH="/home/funnyboy_roks/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
eval $(thefuck --alias)

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Init fzf (^T)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Init [atuin](https://github.com/ellie/atuin) (but keep my up arrow key)
eval "$(atuin init zsh --disable-up-arrow)"
