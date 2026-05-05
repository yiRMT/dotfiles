typeset -U path

path=(
	/usr/local/bin
	$HOME/bin
	$path
)

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="eastwood"

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST

PROMPT='%F{green}%n@%m%f %F{blue}%~%f%F{yellow}${vcs_info_msg_0_}%f
%F{242}$%f '


DISABLE_UNTRACKED_FILES_DIRTY="true"
DISABLE_AUTO_UPDATE="true"
plugins=(
	git
	zsh-autosuggestions
)
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#9ca1b2"
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source "$ZSH/oh-my-zsh.sh"

# paths (Homebrew を先頭に追加)
if [[ "$(uname -m)" == "arm64" ]]; then
	path=(/opt/homebrew/bin $path)
else
	path=(/usr/local/bin $path)
fi

# gcloud
if [[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]]; then
  function gcloud() {
    unfunction gcloud
    source "$HOME/google-cloud-sdk/path.zsh.inc"
    [[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]] && source "$HOME/google-cloud-sdk/completion.zsh.inc"
    gcloud "$@"
  }
fi

# tex
path+=(/usr/local/texlive/2022/bin/universal-darwin)

# vscode
path+=("/Applications/Visual Studio Code.app/Contents/Resources/app/bin")

# docker
path+=("/Applications/Docker.app/Contents/Resources/bin/")

# rig
alias rig="/usr/local/bin/rig"

# mise
eval "$(mise activate zsh)"

# aliases
alias ll='ls -l --color=auto'
# alias claude-aff='CLAUDE_CONFIG_DIR=~/.claude-aff claude'
alias claude-imlab='CLAUDE_CONFIG_DIR=~/.claude-imlab claude'
alias claude-xirg='CLAUDE_CONFIG_DIR=~/.claude-xirg claude'
alias claude-dfki='CLAUDE_CONFIG_DIR=~/.claude-dfki claude'

# Added by Antigravity
export PATH="/Users/iwashita/.antigravity/antigravity/bin:$PATH"

export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"
export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig"
