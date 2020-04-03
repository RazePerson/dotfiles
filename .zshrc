# Le my zshrc

# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.oh-my-zsh"
export DOTFILES_HOME=$(dirname $0)

ZSH_THEME="amuse"

plugins=(git docker docker-compose)

source $ZSH/oh-my-zsh.sh

#if [ -d "/opt/java/jdk-12.0.1/bin" ]; then
#	export JAVA_HOME=/opt/java/jdk-12.0.1
#	export PATH=$PATH:$JAVA_HOME
#fi

export PATH="$PATH:$HOME/bin"

export PATH="$PATH:$HOME/scripts"

export PATH=$PATH:~/.vim/bundle/vim-live-latex-preview/bin
export PATH=$PATH:~/tools/bin

export READER='qpdfview'
export PROMPT_EOL_MARK=''

# VIM MODE:
# bindkey -v
#
# function zle-line-init zle-keymap-select {
#     RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#     RPS2=$RPS1
#     zle reset-prompt
# }
#
# zle -N zle-line-init
# zle -N zle-keymap-select

# ALIAS FILE
source $DOTFILES_HOME/.zsh_aliases
