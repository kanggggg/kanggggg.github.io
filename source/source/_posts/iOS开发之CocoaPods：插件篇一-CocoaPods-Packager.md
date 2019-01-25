---
title: iOS开发之CocoaPods：插件篇一 CocoaPods Packager
tags:
  - iOS Memo
categories:
  - iOS
  - CocoaPods
toc: true
comments: true
date: 2019-01-25 18:30:16
---

经过我们的不懈努力，CocoaPods的私有库写完了，现在进入集成阶段了，倘若对方工程也在使用CocoaPods，我们也乐意开放源码，那就是开心愉快了，倘若对方工程还是个老古董，我们也不乐意开放源码，这时候就需要我们自行打包了。我们也知道打包又要考虑架构考虑真机和模拟器，很繁琐，CocoaPods Packager就可以来拯救我们。

[Packaging Closed Source SDKs](https://guides.cocoapods.org/plugins/using-pods-for-closed-source-libs.html)
[CocoaPods Packager](https://github.com/CocoaPods/cocoapods-packager)

> CocoaPods plugin which allows you to generate a framework or static library from a podspec.
> 
> This plugin is for CocoaPods developers, who need to distribute their Pods not only via CocoaPods, but also as frameworks or static libraries for people who do not use Pods.

## 安装

打开终端，执行下面命令：

```bash
$ gem install cocoapods-packager

# 安装完成之后，验证一下，也可用来查看帮助
$ pod package
```

## 命令说明

```bash
# Overwrite existing files.
# 是否覆盖已存在的文件
--force 

# Do not mangle symbols of depedendant Pods.
--no-mangle

# Generate embedded frameworks. 
# 生成静态Framework
--embedded

# Generate static libraries.
# 生成静态Library
--library

# Generate dynamic framework. 
# 生成动态Framework
--dynamic

# Bundle identifier for dynamic framework
# 动态Framework Bundle identifier
--bundle-identifier 

# Exclude symbols from dependencies.
# 不包含依赖的符号表，动态库不能包含这个命令
--exclude-deps 

# Build the specified configuration (e.g. Debug). Defaults to Release
# 生成的库是Debug还是Release，默认是Release。--configuration=Debug 
--configuration

# Only include the given subspecs
# 只给指定的子库打包
--subspecs

# The sources to pull dependant pods from (defaults to https://github.com/CocoaPods/Specs.git)
# 存在私有依赖
--spec-sources=private,https://github.com/CocoaPods/Specs.git 
```

## Example

```bash
$ cd 工程目录
$ pod package MyLib.podspec --force --embedded --no-mangle --exclude-deps --configuration=DEBUG
```

这边提供一个懒人方法，把命令写成Shell可执行文件放在目录下，就不用每次都敲命令了：

1. 新建 `package.sh` 文件放在跟podspec同目录下，输入：

   ```bash
   #!/bin/bash
   pod package MyLib.podspec --force --embedded --no-mangle --exclude-deps --configuration=DEBUG
   ```
   
2. 给予可执行权限

   ```bash
   $ chmod u+x package.sh
   ```
   
3. 执行

   ```bash
   $ cd 项目目录
   $ ./package.sh
   ```
