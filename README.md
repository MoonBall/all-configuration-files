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
```

## iTerm2
File: com.googlecode.iterm2.plist.

1. 选择 **Preferences...** > **General**。
2. 选择底部 Load Preferences，并选中该文件夹。
3. 勾选退出 iTerm2 后保存配置。

> 需要安装 Source Code Pro 字体，其他字体中文可能会导致中文不友好。
```
brew tap homebrew/cask-fonts && brew cask install font-source-code-pro
```
配置 iTerm2。Preferences -> Profiles -> Text -> Change Font -> Source Code Pro 14pt


## Node.js
安装 [nvm](https://github.com/creationix/nvm)。
执行 `nvm install {version}` 安装 node。

