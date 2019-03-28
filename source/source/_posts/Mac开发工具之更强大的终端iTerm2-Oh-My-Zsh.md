---
title: Mac开发工具之更强大的终端iTerm2+Oh My Zsh
tags:
  - Mac开发工具
categories:
  - Mac
toc: true
comments: true
date: 2019-03-28 14:51:35
---

在开发过程中，难免要用到终端运行命令的情况，一般Mac自带能满足需求了，但是俗话说工欲善其事必先利其器，作为一个开发，没有理由拒绝把终端变得更强。

## iTerm2

[iTerm2](https://www.iterm2.com/index.html)

> iTerm2 is a replacement for Terminal and the successor to iTerm. It works on Macs with macOS 10.12 or newer. iTerm2 brings the terminal into the modern age with features you never knew you always wanted.

安装的过程就不说了，下载下来，移动到Applications目录就好

在安装完成之后，你的终端就可以使用zsh了，Mac终端默认是使用bash，所以需要切换到zsh

```bash
$ chsh -s /bin/zsh
```

### 关于zsh和bash

zsh和bash都是一种shell，那么何为shell？

[鸟哥的Linux私房菜 第十一章、认识与学习 BASH](http://cn.linux.vbird.org/linux_basic/0320bash.php#bash)

总结一下就是shell是壳，是用户与系统内核沟通的命令行解析器，再通俗点说其实也是一个应用，只是它是文字形式的，要做什么必须输入文字命令。

那么Mac支持有几种shell呢？

```bash
# 查看支持的shell
$ cat /etc/shells

# 切换shell
$ chsh -s /bin/zsh

# 查看当前的shell
$ echo $SHELL
```

常见shell如下：

- `/bin/sh`：Bourne shell，被 `bash` 取代
- `/bin/bash`：Bourne-Again Shell，用来替代Bourne shell，多数Linux以及MacOS的默认shell
- `/bin/ksh`：[Korn shell](http://www.kornshell.com/info/)，兼容bash
- `/bin/csh`：语法类似C语言
- `/bin/tcsh`：csh增强版
- `/bin/zsh`：基于ksh，功能更强大的shell，很多其他shell的特点都被引入zsh

## Oh My Zsh

[Oh My Zsh](https://ohmyz.sh)
[Oh My Zsh GitHub](https://github.com/robbyrussell/oh-my-zsh/)

> Oh My Zsh is a delightful, open source, community-driven framework for managing your Zsh configuration. It comes bundled with thousands of helpful functions, helpers, plugins, themes, and a few things that make you shout...
> 
> “Oh My ZSH!”

一句话，Oh My Zsh 是对zsh的功能扩展

### 安装

1. 自动安装

   ```bash
   $ sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
   ```

2. 手动安装

   ```bash
   $ git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
   $ cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
   ```

### 配置

oh-my-zsh的配置文件是 `~/.zshrc`，每次变动了该文件，都需要 `source ~/.zshrc` 使配置生效

### 插件

自带插件目录 `~/.oh-my-zsh/plugins`，也就是 `$ZSH/plugins`
三方插件目录 `~/.oh-my-zsh/custom/plugins`，也就是 `$ZSH_CUSTOM/plugins`

#### zsh-autosuggestions 命令补全

[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

1. 下载到三方插件目录，`$ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
2. 编辑 `~/.zshrc`，加入到 `plugins`，`plugins=(... zsh-autosuggestions)`   
3. 使配置生效，`source ~/.zshrc`

#### zsh-syntax-highlighting 语法高亮

[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

1. 下载到三方插件目录，`$ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting`
2. 编辑 `~/.zshrc`，加入到 `plugins`，`plugins=(... zsh-syntax-highlighting)`   
3. 在 `~/.zshrc` 的末尾加上 `source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh`
4. 使配置生效，`source ~/.zshrc`

### 主题

[主题列表](https://github.com/robbyrussell/oh-my-zsh/wiki/themes)

自带主题目录 `~/.oh-my-zsh/themes`，也就是 `$ZSH/themes`
三方主题目录 `~/.oh-my-zsh/custom/themes`，也就是 `$ZSH_CUSTOM/themes`

设置主题的方法（以设置ys主题为例）：

1. 编辑 `~/.zshrc`，设置 `ZSH_THEME="ys"`
2. 使配置生效，`source ~/.zshrc`

#### agnoster

这个主题应该是网上比较常提到的主题，虽然也是自带的，不过配置这个主题相对麻烦些

1. 安装Poweline
   
   ```bash
   $ sudo easy_install pip # 安装pip，若已安装可忽略
   $ pip install powerline-status --user
   ```

2. 安装PowerFonts
   
   ```bash
   $ mkdir PowerFonts
   $ cd PowerFonts
   $ git clone https://github.com/powerline/fonts.git --depth=1
   $ cd fonts
   $ ./install.sh
   $ cd ..
   $ rm -rf fonts
   ```
   
3. 修改iTerm2字体，`iTerm2 -> Preferences -> Profiles -> Text` ，把字体设成 `Meslo LG`，比如 `Meslo LG S for Powerline`
