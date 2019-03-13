---
title: iOS开发之CocoaPods：工具篇 VSCode
tags:
  - iOS
  - CocoaPods
  - VSCode
categories:
  - iOS
  - CocoaPods
toc: true
comments: true
date: 2019-03-10 00:50:01
---

What is VSCode? VSCode全称Visual Studio Code，是微软出的轻量且强大的代码编辑器。来看下官方对它的描述：

> Visual Studio Code is a lightweight but powerful source code editor which runs on your desktop and is available for Windows, macOS and Linux. It comes with built-in support for JavaScript, TypeScript and Node.js and has a rich ecosystem of extensions for other languages (such as C++, C#, Java, Python, PHP, Go) and runtimes (such as .NET and Unity). Begin your journey with VS Code with these introductory videos.

VSCode的插件很多，经过配置，可以成为一个很顺手的利器。这篇文章主要讲怎么把VSCode配置成好用CocoaPods工具。

## 安装Command Line支持

`Command+Shitf+P` 打开Command Palette（命令面板），输入 `Shell Command: Install 'code' command in PATH` 回车安装。成功之后就可以直接在终端使用 `code` 命令用VSCode打开文件，比如：

```bash
$ code Podfile
```

## 安装插件

可以先阅读官方的插件指导文档 [Visual Studio Code - Extension Marketplace](https://code.visualstudio.com/docs/editor/extension-gallery)

那么让VSCode支持CocoaPods需要什么插件：

- Ruby
  
  CocoaPods是用Ruby写的，不管是编辑Podfile还是podspec，Ruby支持可以使代码高亮和更加格式化

- CocoaPods Snippets

  Podfile和podpspec文件的代码段

- Path AutoComplete

  路径补全

- Terminal

  在VSCode里直接运行终端

