# パフォーマンス測定用（測定する場合は下記行のコメントを外す）
# zmodload zsh/zprof

# ============================================
# PATH設定（まとめて設定）
# ============================================
if type brew &>/dev/null
then
	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

typeset -U path  # 重複を自動削除

path=(
  $HOME/bin
  $HOME/.local/bin
  /usr/local/bin
  $path
)

# アーキテクチャ判定（一度だけ）
if [[ "$(uname -m)" == "arm64" ]]; then
  IS_ARM64=1
  export HOMEBREW_PREFIX="/opt/homebrew"
	path=(
    /opt/homebrew/bin
    /opt/homebrew/Cellar
    /opt/homebrew/opt/openssl@3/bin
    /opt/homebrew/opt/openjdk@17/bin
    /opt/homebrew/opt/libpq/bin
    $path
  )
else
  IS_ARM64=0
	export HOMEBREW_PREFIX="/usr/local"
  path=(
    /usr/local/bin
    /usr/local/Cellar
    $path
  )
fi

export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}"

autoload -Uz compinit
compinit -u

# ============================================
# History
# ============================================
HISTSIZE=6000000
SAVEHIST=6000000
HISTFILE=~/.zsh_history
setopt hist_ignore_dups
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt auto_cd  # パスだけでcdできるようにする

# ============================================
# Prompt（vcs_info遅延読み込み）
# ============================================
autoload -Uz vcs_info
setopt prompt_subst

# vcs_info設定
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' max-exports 6
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b@%r' '%c' '%u'
zstyle ':vcs_info:git:*' actionformats '%b@%r|%a' '%c' '%u'

function vcs_echo {
  local st branch color
  STY= LANG=en_US.UTF-8 vcs_info
  st=$(git status 2>/dev/null)
  if [[ -z "$st" ]]; then return; fi
  branch="$vcs_info_msg_0_"
  
  if [[ -n "$vcs_info_msg_1_" ]]; then
    color='%F{green}'  # staged
  elif [[ -n "$vcs_info_msg_2_" ]]; then
    color='%F{red}'    # unstaged
  elif [[ "$st" == *"Untracked"* ]]; then
    color='%F{blue}'   # untracked
  else
    color='%F{cyan}'
  fi
  echo "${color}(${branch})%f"
}

PROMPT='%F{yellow}[%m.`uname -m`:%~]%f $(vcs_echo)
%(?.$.%F{red}$%f) '

# ============================================
# 開発環境PATH
# ============================================
# Ruby
if (( IS_ARM64 )); then
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
  export LDFLAGS="-L$(brew --prefix openssl@1.1)/lib -L/opt/homebrew/opt/readline/lib -L/opt/homebrew/opt/libffi/lib"
  export CPPFLAGS="-I$(brew --prefix openssl@1.1)/include -I/opt/homebrew/opt/readline/include -I/opt/homebrew/opt/libffi/include"
  export PKG_CONFIG_PATH="$(brew --prefix openssl@1.1)/lib/pkgconfig:/opt/homebrew/opt/readline/lib/pkgconfig:/opt/homebrew/opt/libffi/lib/pkgconfig"
fi
export RUBY_CFLAGS="-w"
export optflags="-Wno-error=implicit-function-declaration"

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
path+=(
  $ANDROID_HOME/bin
  $ANDROID_HOME/platform-tools
)

# GEM
export GEM_HOME=$HOME/.gem
path+=($GEM_HOME/bin)

# Dart
path+=($HOME/.pub-cache/bin)

# Go（遅延評価）
if (( $+commands[go] )); then
  path+=($(go env GOPATH)/bin)
fi

# R
disable r
export RSTUDIO_WHICH_R=/opt/homebrew/bin/R

# LM Studio
path+=($HOME/.cache/lm-studio/bin)

# ============================================
# TeX Live
# ============================================
path+=(/usr/local/texlive/2022/bin/universal-darwin)

# ============================================
# Perl（遅延読み込み）
# ============================================
function perl() {
  if [[ -z "$PERL5LIB" ]]; then
    eval "$(command perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
  fi
  command perl "$@"
}

# ============================================
# Google Cloud SDK（遅延読み込み）
# ============================================
if [[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]]; then
  function gcloud() {
    unfunction gcloud
    source "$HOME/google-cloud-sdk/path.zsh.inc"
    [[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]] && source "$HOME/google-cloud-sdk/completion.zsh.inc"
    gcloud "$@"
  }
fi

# ============================================
# Dart Completion（遅延読み込み）
# ============================================
if [[ -f "$HOME/.dart-cli-completion/zsh-config.zsh" ]]; then
  function dart() {
    if ! (( $+functions[_dart] )); then
      source "$HOME/.dart-cli-completion/zsh-config.zsh"
    fi
    command dart "$@"
  }
fi

# ============================================
# mise（rbenv/nodenv代替）完全遅延読み込み
# ============================================
if (( $+commands[mise] )); then
  # shimsへのPATHのみ追加（hookは設定しない）
  export PATH="$HOME/.local/share/mise/shims:$PATH"
  
  # miseコマンド実行時のみ完全初期化
  function mise() {
    unfunction mise
    eval "$(command mise activate zsh)"
    mise "$@"
  }
fi

# ============================================
# Conda/Mamba（遅延読み込み）
# ============================================
export MAMBA_EXE='/Users/iwashita/miniforge3/bin/mamba'
export MAMBA_ROOT_PREFIX='/Users/iwashita/miniforge3'
path+=(/Users/iwashita/miniforge3/bin)

__conda_lazy_init() {
  __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2>/dev/null)"
  if [[ $? -eq 0 ]]; then
    eval "$__mamba_setup"
  else
    alias mamba="$MAMBA_EXE"
  fi
  unset __mamba_setup

  __conda_setup="$('/Users/iwashita/miniforge3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
  if [[ $? -eq 0 ]]; then
    eval "$__conda_setup"
  else
    if [[ -f "/Users/iwashita/miniforge3/etc/profile.d/conda.sh" ]]; then
      source "/Users/iwashita/miniforge3/etc/profile.d/conda.sh"
    fi
  fi
  unset __conda_setup
}

function conda() {
  unfunction conda
  __conda_lazy_init
  conda "$@"
}

function mamba() {
  unfunction mamba  
  __conda_lazy_init
  mamba "$@"
}

# ============================================
# Aliases
# ============================================
alias ll='ls -l --color=auto'
alias claude-aff='CLAUDE_CONFIG_DIR=~/.claude-aff claude'
alias claude-imlab='CLAUDE_CONFIG_DIR=~/.claude-imlab claude'

# iTerm2プロファイル変更
function change_profile() {
  echo -e "\033]1337;SetProfile=$1\a"
}

if (( IS_ARM64 )); then
  change_profile ARM >/dev/null 2>&1
else
  change_profile Intel >/dev/null 2>&1
fi

# Xcodes
export XCODES_USERNAME="yiwashita.cu@gmail.com"

# パフォーマンス測定結果表示
# if (( $+modules[zsh/zprof] )); then
#   zprof
# fi
