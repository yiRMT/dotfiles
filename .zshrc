# zsh-completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# If you come from bash you might have to change your $PATH
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/Users/iwashita/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="refined"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


export PATH=$HOME/bin:$PATH # コメントアウト
source ~/.bash_profile

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

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# homebrew packages
if [ "$(uname -m)" = "arm64" ]; then
  export PATH="/opt/homebrew/Cellar/:$PATH"
else
  export PATH="/usr/local/Cellar/:$PATH"
fi

# iterm
alias change_profile='(){echo -e "\033]1337;SetProfile=$1\a"}'

if [ "$(uname -m)" = "arm64" ]; then
  # arm64
  change_profile ARM
else
  # x86_64
  change_profile Intel
fi

# nodeenv
eval "$(nodenv init -)"

export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

export RUBY_CFLAGS="-w"
export PATH="$(brew --prefix openssl@1.1)/bin:$PATH"
export LDFLAGS="-L$(brew --prefix openssl@1.1)/lib"
export CPPFLAGS="-I$(brew --prefix openssl@1.1)/include"
export PKG_CONFIG_PATH="$(brew --prefix openssl@1.1)/lib/pkgconfig"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools
export PATH=$ANDROID_HOME/bib:$PATH

# GEM
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

# fvm
export PATH="$PATH":"$HOME/fvm/default/bin"

# dart
export PATH="$PATH":"$HOME/.pub-cache/bin"

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
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
[[ -f /Users/iwashita/.dart-cli-completion/zsh-config.zsh ]] && . /Users/iwashita/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/iwashita/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/iwashita/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/iwashita/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/iwashita/google-cloud-sdk/completion.zsh.inc'; fi

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"


# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/iwashita/.cache/lm-studio/bin"

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

# Added by Windsurf
export PATH="/Users/iwashita/.codeium/windsurf/bin:$PATH"

# Claude
alias claude-aff='CLAUDE_CONFIG_DIR=~/.claude-aff claude'
