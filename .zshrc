[[ ! -z ${DEBUG+x} ]] && echo "Starting personal zsh config"

source ${ZDOTDIR:-$HOME}/.zshenv

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

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
zstyle :compinstall filename "${ZDOTDIR:-$HOME}.zshrc"
fpath=(${HOME}/.zsh/completions $fpath)

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Accepts autosuggestion with Ctrl+space
bindkey '^ ' autosuggest-accept
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[3~" delete-char


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.asdf/asdf.sh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# pnpm
export PNPM_HOME="/home/fernando/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Run wslpatcher
if [ -e /mnt/d/wsl/WSLHostPatcher/WSLHostPatcher.exe ]; then
  /mnt/d/wsl/WSLHostPatcher/WSLHostPatcher.exe > /dev/null
fi

# I DON'T REMEMBER WHAT THIS IS FOR
# export EMSDK_QUIET=1
# source "/usr/lib/emsdk/emsdk_env.sh"

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

reset-1password-integration() {
  killall socat
  source $OP_INTEGRATION_SCRIPT
}
alias reset1p="reset-1password-integration"

# Aliases
if type exa > /dev/null; then 
  # exa is installed
  alias ls="exa --icons -g"
else
  alias ls="ls -g"
fi
alias la="ls -a"
alias ll="ls -lg"
alias lla="ls -alg"
alias ls1="ls -1"
if type bat > /dev/null; then 
  # bat is installed
  alias cat="bat --style=auto"
fi
if type nvim > /dev/null; then 
  # nvim is installed
  alias vim="nvim"
fi

alias yt-dlp-mp4="yt-dlp -S res,ext:mp4:m4a --recode mp4"
alias restartexplorer="taskkill.exe /f /im explorer.exe; explorer.exe &"
alias explorer="explorer.exe"
alias winget="winget.exe"
alias taskkill="taskkill.exe"
alias nslookup="nslookup.exe"
alias debug="exec env DEBUG=1 zsh"

# Defaults
source $OP_INTEGRATION_SCRIPT
