export PATH=$HOME/bin:$PATH
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# oh-my-zsh
export ZSH="/Users/iwashita/.oh-my-zsh"
ZSH_THEME="alanpeabody"
DISABLE_UNTRACKED_FILES_DIRTY="true"
DISABLE_AUTO_UPDATE="true"
plugins=(
	git
	zsh-autosuggestions
)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source "$ZSH/oh-my-zsh.sh"

# TexLive 2021
export PATH="/usr/local/texlive/2022/bin/universal-darwin:$PATH"

# brew-perl
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

if [ "$(uname -m)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="/opt/homebrew/bin:$PATH"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

# alias
# iterm
alias change_profile='(){echo -e "\033]1337;SetProfile=$1\a"}'

if [ "$(uname -m)" = "arm64" ]; then
  # arm64
	# homebrew	
  export PATH="/opt/homebrew/Cellar/:$PATH"

	# iterm
  change_profile ARM
else
  # x86_64
	# homebrew	
  export PATH="/usr/local/Cellar/:$PATH"
  
	# iterm
	change_profile Intel
fi

export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

# ruby
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export RUBY_CFLAGS="-w"
export PATH="$(brew --prefix openssl@1.1)/bin:$PATH"
export LDFLAGS="-L$(brew --prefix openssl@1.1)/lib"
export CPPFLAGS="-I$(brew --prefix openssl@1.1)/include"
export PKG_CONFIG_PATH="$(brew --prefix openssl@1.1)/lib/pkgconfig"

export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools
export PATH=$ANDROID_HOME/bin:$PATH

# GEM
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

# dart
export PATH="$PATH":"$HOME/.pub-cache/bin"

export LDFLAGS="-L/opt/homebrew/opt/readline/lib"
export CPPFLAGS="-I/opt/homebrew/opt/readline/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/readline/lib/pkgconfig"
export optflags="-Wno-error=implicit-function-declaration"
export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"

# go
export PATH="$PATH:$(go env GOPATH)/bin"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f "$HOME/.dart-cli-completion/zsh-config.zsh" ]] && . "$HOME/.dart-cli-completion/zsh-config.zsh" || true
## [/Completion]


# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.cache/lm-studio/bin"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/iwashita/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/iwashita/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/iwashita/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/iwashita/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/iwashita/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/Users/iwashita/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

eval "$(mise activate zsh)"

# Xcodes
XCODES_USERNAME="yiwashita.cu@gmail.com"

# Claude
alias claude-aff='CLAUDE_CONFIG_DIR=~/.claude-aff claude'
alias claude-imlab='CLAUDE_CONFIG_DIR=~/.claude-imlab claude'

# R
disable r
export RSTUDIO_WHICH_R=/opt/homebrew/bin/R

# libpq
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"


if (which zprof > /dev/null 2>&1) ;then
  zprof
fi

