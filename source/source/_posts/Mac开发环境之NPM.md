---
title: Mac开发环境之NPM
date: 2018-04-13 15:45:04
tags: 
  - NPM
  - 开发环境
  - Mac开发环境
categories:
  - Mac
toc: true
comments: true
---


[NPM](https://www.npmjs.com) 即 Node Package Manager，是NodeJS的包管理器，且是随同NodeJS一起安装的。

- [Node.js 官网](https://nodejs.org/en/)
- [Node.js 中文网](http://nodejs.cn)

## 安装

``` bash
# Homebrew安装Node
$ brew install node
```

## 基本使用

``` bash
$ npm help <term> # 查看<term>帮助，exp. npm help install 查看install的帮助
$ npm ls [-g] # 查看安装的模块及依赖，option：[-g]全局
$ npm root [-g] #查看node_modules的路径，option：[-g]全局

# 安装包
$ npm install <packageNmae> [-g] # 安装，option：[-g]全局
$ npm uninstall <packageNmae> # 卸载
$ npm update <packageNmae> # 更新
```

以安装Hexo为例：

```bash
$ npm install hexo [-g] # 安装，option：[-g]全局
$ npm uninstall hexo # 卸载
$ npm update hexo # 更新
```

## 注意

1. 包下载不下来，需要更换源
   
   ```bash
   $ npm config set registry https://registry.npm.taobao.org --global
   $ npm config set disturl https://npm.taobao.org/dist --global
   ```
