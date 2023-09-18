# all-configuration-files

个人所有的配置文件备份。

先将项目克隆到本地，后面的命令都将在项目目录下执行。

```
git clone git@github.com:MoonBall/all-configuration-files.git
cd all-configuration-files/
```

## Vim

File: .vimrc

```
ln -sf "`pwd`/.vimrc" ~/.vimrc
```

## Zsh

先[安装 Zsh](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH)。
安装后执行下面命令。

```
ln -sf "`pwd`/.zshrc" ~/.zshrc
source ~/.zshrc
chsh -s /bin/zsh
```

## Git

File: .gitconfig, .gitignore_global

```
ln -sf "`pwd`/.gitconfig" ~/.gitconfig
ln -sf "`pwd`/.gitignore_global" ~/.gitignore_global

# 公司的用户配置设置在全局，避免将公司配置上传到 github
git config  --system user.email "x" && git config user.name "陈刚"
```

## iTerm2

File: com.googlecode.iterm2.plist.

1. 选择 **Preferences...** > **General**。
2. 选择底部 Load Preferences，并选中该文件夹。
3. 勾选退出 iTerm2 后保存配置。

> 需要安装 Source Code Pro 字体，其他字体中文可能会导致中文不友好。

```
brew tap homebrew/cask-fonts && brew install font-source-code-pro --cask
```

配置 iTerm2。Preferences -> Profiles -> Text -> Change Font -> Source Code Pro 14pt

## Node.js

安装 [nvm](https://github.com/creationix/nvm)。
执行 `nvm install {version}` 安装 node。


## Go

1. 安装 [gvm](https://github.com/moovweb/gvm)
2. 安装最新版本的 Go，`brew install go`。因为 gvm 依赖 Go
3. 执行 `gvm listall` 查看所有可用的 Go 版本
4. 执行 `gvm install {version}` 安装指定版本的 Go
5. 卸载 homebrew 安装的 Go，`brew uninstall go`
6. 设置刚刚 gvm 安装的 go 为默认的 go 版本，`gvm alias create default {version}`

# Rust

```
mkdir -p ~/.cargo
ln -sf "`pwd`/.cargo/config" ~/.cargo/config
curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh

source "$HOME/.cargo/env"
```

# JetBrains

## 快捷键设置

1. Alt + 1, Other -> Bookmarks -> Select File in Project View
2. Alt + 2, Pin Active Tab
3. Alt + 3, Close All but Pinned


