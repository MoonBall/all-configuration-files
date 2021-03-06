# 安装 antigen
ANTIGEN_FILE=$HOME/.antigen.zsh
if [ ! -f $ANTIGEN_FILE ]; then
  curl -L git.io/antigen > $ANTIGEN_FILE
fi
source $ANTIGEN_FILE

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle autojump   # 可能需要 brew install autojump 代替

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Load the theme.
antigen theme ys

# Tell Antigen that you're done.
antigen apply

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

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

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=black,bold"

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# don't rm
mkdir -p ~/.trash
alias rm=trash
trash()
{
    mv $@ ~/.trash/
}
alias rm-be-careful=/bin/rm

# This loads nvm
export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
# origin npm registry
alias onpm="npm --registry=https://registry.npmjs.org"

# 先使用 brew 中的命令
export PATH="/usr/local/bin:$PATH"

# jenv
export PATH="$PATH:$HOME/.jenv/bin"
type jenv >/dev/null 2>&1 && eval "$(jenv init -)"

# rvm
export PATH=$PATH:$HOME/.rvm/bin

# android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Maven
export M2_HOME=$HOME/GreenApplications/apache-maven-3.5.2
export PATH=$PATH:$M2_HOME/bin
export MAVEN_OPTS='-Xmn400m -Xms1024m -Xmx1024m -Xss1m -XX:PermSize=384m -XX:MaxPermSize=384m'

# MySQL
export PATH=$PATH:/usr/local/mysql/bin

# Anaconda
export PATH=$PATH:$HOME/anaconda2/bin

# adb
export PATH=$PATH:$HOME/GreenApplications/platform-tools

# VS CODE
export PATH=$PATH:/Applications/Visual\ Studio\ Code\ -\ Insiders.app/Contents/Resources/app/bin

# Go
export PATH=$PATH:/usr/local/go/bin
which go > /dev/null 2>&1 && export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin

# Postgres.app
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

# pyenv 命令：https://github.com/pyenv/pyenv#basic-github-checkout
# 使用 brew install pyenv 后，会报 openssl 不兼容错误。
# 因为如果 brew install openssl 后，pyenv install 时会使用 brew 中的 openssl，而 brew install 的 openssl 可能有问题。
if [ ! -d "$HOME/.pyenv" ]; then git clone --depth 1 https://github.com/pyenv/pyenv.git ~/.pyenv; fi
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi
# http://yyuu.github.io/pythons/ 加速下载 python
export PYTHON_BUILD_MIRROR_URL="http://yoursite.example.com/pythons"

alias my-openssl='/usr/local/Cellar/openssl/1.0.2o_2/bin/openssl'

# git 切换用户
alias git-hb='git config user.email "gangc.cxy@foxmail.com" && git config user.name "Gang Chen"'
alias pm2='/Users/moonball/ByteDance/ee-people-fe/people-fe/people-node/node_modules/.bin/pm2'

# vscode 编辑器
alias vscode='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'

__cloneSource() {
  local sourceBase=~/git-source
  local url=$1
  local sourcePath
  if [[ $url =~ ^git@([^:]*):(.*).git$ ]]; then
    sourcePath=${match[1]}/${match[2]}
  elif [[ $url =~ ^git@([^:]*):(.*)$ ]]; then
    sourcePath=${match[1]}/${match[2]}
  elif [[ $url =~ ^https?://([^/]*)/(.*).git$ ]]; then
    # 使用 git 协议，不用输入密码
    url=git@${match[1]}:${match[2]}
    sourcePath=${match[1]}/${match[2]}
  elif [[ $url =~ ^https?://([^/]*)/(.*)$ ]]; then
    url=git@${match[1]}:${match[2]}
    sourcePath=${match[1]}/${match[2]}
  elif [[ $url =~ ^ssh://[^@]+@([^/:]+)[^/]*/(.*)$ ]]; then
    sourcePath=${match[1]}/${match[2]}
  else
    echo "不支持的 repository url。"
    return 1
  fi

  local sourceDist=$sourceBase/$sourcePath
  echo "git clone $url $sourceDist"
  git clone $url $sourceDist

  # 如果仓库已经被克隆了，直接 cd 到仓库目录里
  local exitCode=$?
  cd $sourceDist

  # 设置 github 账号，避免使用公司账号
  if [[ $sourcePath =~ "github.com" ]]; then
    echo "exec git-hb"
    git-hb
  fi

  if [ $exitCode -ne 0 ]; then
    return $exitCode
  fi
}
alias clone-source="__cloneSource"

__gitSeeBranch() {
  local url=$1
  local remoteName
  local branchName
  local repositoryName
  local remoteUrlPrefix
  if [[ $url =~ ^([^:]*):(.*)$ ]]; then
    remoteName=${match[1]}
    branchName=${match[2]}
  else
    echo "不支持的的分支。请使用 {remoteName}:{branchName}"
    return 1
  fi

  local existRemoteUrl=`git remote -v | grep -oE "((git@[^:]*):([^/]*)/(.*).git)" | head -n1`
  if [[ $existRemoteUrl =~ ^((git@[^:]*):([^/]*)/(.*).git)$ ]]; then
    remoteUrlPrefix=${match[2]}
    repositoryName=${match[4]}
  else
    echo "没有找到 git@ 相似的 remote"
    return 1
  fi

  local newUrl="${remoteUrlPrefix}:${remoteName}/${repositoryName}.git"
  echo "$ git remote add ${remoteName} ${newUrl}\n"
  git remote add $remoteName $newUrl 1>/dev/null 2>&1
  echo "$ git fetch ${remoteName} ${branchName}\n"
  git fetch $remoteName $branchName
  echo "$ git checkout -b $branchName -t ${remoteName}/${branchName}\n"
  git checkout -b $branchName -t ${remoteName}/${branchName}
}
alias git-hbr="__gitSeeBranch"

alias proxy_lantern="export HTTP_PROXY=http://127.0.0.1:56356 HTTPS_PROXY=http://127.0.0.1:56356"

export GEM_HOME=$HOME/.gem
export PATH=/Users/chengang.07/.gem/ruby/2.6.0/bin:$GEM_HOME/bin:$PATH

