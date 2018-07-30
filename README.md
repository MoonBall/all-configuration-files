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
ln -s "`pwd`/.vimrc" ~/.vimrc
```

## Zsh
先[安装 Zsh](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH)。
安装后执行下面命令。

```
ln -sf "`pwd`/.zshrc" ~/.zshrc
source ~/.zshrc
```

## iTerm2
File: com.googlecode.iterm2.plist.

1. 选择 **Preferences...** > **General**。
2. 选择底部 Load Preferences，并选中该文件夹。
3. 勾选退出 iTerm2 后保存配置。

## Node.js
安装 [nvm](https://github.com/creationix/nvm)。
执行 `nvm install {version}` 安装 node。

