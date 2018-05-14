---
title: Mac开发环境之Homebrew
date: 2018-04-13 15:42:00
tags: 
- Mac开发环境
categories:
- Mac
toc: true
comments: true
---

[Homebrew](https://brew.sh/index_zh-cn.html) ，macOS缺失的软件包管理器。实际上手之后，你会发现真的是不可获缺的，能方便地帮助我们完成包的安装、更新、卸载等等。

## 安装

```bash
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## 基本使用

```bash
$ brew update # 更新Homebrew
$ brew -v # 查看Homebrew版本
$ brew help [COMMAND] # 查看帮助

# 包
$ brew list # 查看已安装的包
$ brew search <packageName> # 查询可用包
$ brew install <packageName> # 安装包
$ brew uninstall <packageName> # 卸载包
$ brew upgrade <packageName> # 更新包
$ brew info <packageName> # 查看包信息
```

以安装git为例：

```bash
$ brew search git # 查询
$ brew install git # 安装
$ brew uninstall git # 卸载
$ brew upgrade git # 更新
```

## 注意

1. 错误提示 `Error: The /usr/local directory is not writable`
   
   ```bash
   $ sudo chown -R $(whoami):admin /usr/local
   ```

