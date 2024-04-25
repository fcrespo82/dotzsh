export POWERLEVEL9K_INSTANT_PROMPT=quiet
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

[[ ! -z ${DEBUG+x} ]] && echo "Starting personal zsh config"

#Set enviroment variables
# Não é necessário setar o $ZDOTDIR no arquivo ~/.zshenv já faz isso
# source ${ZDOTDIR:-$HOME}/.zshenv

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename "${ZDOTDIR:-$HOME}/.zshrc"
fpath=(${HOME}/.zsh/completions $fpath)

autoload -Uz compinit
compinit
# End of lines added by compinstall


source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.asdf/asdf.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# Load WSL Host Patcher
source ${ZDOTDIR:-$HOME}/wsl/host-patcher.zsh

# Bun completions
[ -s "/home/fernando/.bun/_bun" ] && source "/home/fernando/.bun/_bun"

# Helpers
ls-count-grouped-by-extensions() {
  ONLY_LOCAL='1'
  if [ "$1" = "-h" ]; then
    echo "Usage: $0 [options] <path>"
    echo ""
    echo "path  Optional path to look for, if not passed assumes ."
    echo "-h    Show this help"
    echo "-r    List extensions count recursively"
    shift
    return
  fi
  if [ "$1" = "-r" ]; then
    ONLY_LOCAL="99999"
    shift
  fi
  PATH=$1
  find $PATH -maxdepth $ONLY_LOCAL -type f | perl -ne 'print lc($1) if m/\.([^.\/]+)$/' | sort | uniq -c | sort -n
}
alias lse=ls-count-grouped-by-extensions

# Load bindings
source ${ZDOTDIR:-$HOME}/bindings.zsh
# Load aliases
source ${ZDOTDIR:-$HOME}/aliases.zsh

# Load 1password integration
source ${ZDOTDIR:-$HOME}/1password/integration.zsh

