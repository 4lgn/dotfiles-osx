# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    keychain
    gpg-agent
    zsh-autosuggestions
    zsh-syntax-highlighting
    $plugins
)

# Keychain/gpg-agent settings
# IMPORTANT: put these settings before the line that sources oh-my-zsh
zstyle :omz:plugins:keychain agents gpg,ssh
zstyle :omz:plugins:keychain identities id_rsa 866F004188E5F995

source $ZSH/oh-my-zsh.sh

# Auto-suggestions
bindkey '^ ' autosuggest-accept

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Custom shell stuff
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export GPG_TTY=$TTY
export PATH="/opt/homebrew/opt/postgresql@15/bin:/$HOME/bin:$PATH"
alias pn=pnpm

# pnpm
export PNPM_HOME="/Users/algn/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Added by Windsurf
export PATH="/Users/algn/.codeium/windsurf/bin:$PATH"

alias docker-remote='DOCKER_HOST=tcp://docker.lan:2375 docker'

