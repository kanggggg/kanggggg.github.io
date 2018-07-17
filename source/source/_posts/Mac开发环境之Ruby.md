---
title: Mac开发环境之Ruby
date: 2018-04-13 15:45:21
tags: 
  - Mac开发环境
categories:
  - Mac
toc: true
comments: true
---

Mac默认已经集成了Ruby环境，但是时间长了，难免版本过旧需要更新。

## RVM

> RVM is a command-line tool which allows you to easily install, manage, and work with multiple ruby environments from interpreters to sets of gems.

[RVM](http://www.rvm.io/) 即 Ruby Version Manager，它是一套命令行工具，可用来方便地安装、管理、切换Ruby环境。

- [Ruby China](https://ruby-china.org/)

### 安装RVM

``` bash
# 先安装RVM
$ curl -L get.rvm.io | bash -s stable

# 安装成功之后
$ source ~/.bashrc  
$ source ~/.bash_profile 

# 查看RVM版本
$ rvm -v
```

### 基本使用

```bash
# 查看现有Ruby版本
$ ruby -v

# 列出可安装的版本
$ rvm list known

# 安装版本
$ rvm install 2.3.0

# 切换版本
$ rvm use 2.3.0

# 设置默认版本
$ rvm use 2.3.0 --default

# 列出已安装的版本
$ rvm list

# 删除版本
$ rvm remove 2.3.0
```
