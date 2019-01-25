---
title: iOS开发之CocoaPods：入门篇 管理依赖库
date: 2019-01-25 16:58:53
tags:
  - iOS Memo
categories:
  - iOS
  - CocoaPods
toc: true
comments: true
---

> WHAT IS COCOAPODS
> CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects. It has over 52 thousand libraries and is used in over 3 million apps. CocoaPods can help you scale your projects elegantly.

[CocoaPods](https://cocoapods.org/) 官网上的这段话翻译一下就是：CocoaPods是Swift和Objective-C Cocoa项目的依赖管理器。他拥有超过52000个库，并在超过300万个应用程序中使用。CocoaPods可以帮助您优雅地扩展项目。

简单来说，就是可以帮助你方便地导入三方库，并导入库的依赖，免去了手动完成三方库导入配置。除了导入，你还可以利用CocoaPods搭建你自己的私有库体系。因为这些功能，CocoaPods基本上所有iOS开发者必用的。那么现在就从如何使用CocoaPods管理依赖库开始入门。

## 安装

CocoaPods是使用Ruby构建的，所以需要在本地准备好Ruby环境。不过Mac默认已经有了Ruby环境，可以免去搭建Ruby环境了，但是还需要进行简单配置。打开终端（Terminal），我们开始操作。

### 第一步 更换RubyGems源

RubyGems在国内的访问速度极其感人，所以要进行更换，换成国内的镜像源。我使用的是 [Ruby China](https://gems.ruby-china.com/) 的源。

1. 查看当前的源，默认情况下我们能看到当前的源是 `https://rubygems.org`
   
   ```bash
   $ gem sources -l
   ```

2. 移除当前源，并添加新的源

   ```bash
   # Ruby China有https和http两种源，我一开始添加的是https的源会报SSL错误，改成了http就没问题
   $ gem sources --add http://gems.ruby-china.com/ --remove https://rubygems.org/
   ```
   
3. 再次查看当前源，这个时候就变成了 `http://gems.ruby-china.com/`

   ```bash
   $ gem sources -l
   ```

### 第二步 安装CocoaPods

1. 安装，执行完下面的命令，等待一会就好

   ```bash
   $ sudo gem install cocoapods
   
   # Mac OS X EI Capitan 以后系统请用下面这个安装命令
   $ sudo gem install -n /usr/local/bin cocoapods
   ```
   
   这里提一下，如何卸载呢？
   
   ```bash
   $ sudo gem uninstall cocoapods
   ```

2. 查看pod版本，验证是否安装成功
   
   ```bash
   $ pod --version
   ```

3. 在安装完成之后，进行设置。这一步的主要作用就是把官方的Specs repo ([The CocoaPods Master Repo](https://github.com/CocoaPods/Specs)) 拉到本地，本地的存放目录是 `~/.cocoapods/repos/master` 

   ```bash
   $ pod setup
   ```
   
   何为Sepec repo? 以AFNetworking举例，AFNetworking在CocoaPods体系中，它是一个Pod，每一个Pod都有一个podspec文件，这个文件指定了Pod的版本、源码、公共头文件、依赖等等。那么Specs repo里就存有所有官方的podspec（官方是xxx.podspec.json，私有的是xxx.podspec）
   
   **友情提醒1，这一步很慢很慢，请耐心等待**
   **友情提醒2，如果你很没有耐心，你可以偷懒从其他安装好了CocoaPods的电脑上，拷贝一份repos到你的电脑上**

## CocoaPods管理依赖库

经过上面的折腾，CocoaPods已经安装成功了，我们要用来管理依赖库了。下面以CocoaPodsDemo工程导入AFNetworking进行演示。

### 第一步 创建Podfile

终端进入工程目录，新建Podfile，并编辑
   
```bash
$ cd ~/Desktop/CocoaPodsDemo/
$ pod init # 在工程目录下创建Podfile文件
$ vi Podfile # 编辑
```

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/15481240442711.jpg)
   
编辑Podfile，初始文件内容如下图。这里直接用的vi编辑器，不知如何使用的，请点[Linux vi/vim](http://www.runoob.com/linux/linux-vim.html)

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/15481245106076.jpg)
   
### 第二步 引入依赖

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/15481237443868.jpg)
   
AFNetworking GitHub的这段话告诉我们，我们要想导入，要编辑Podfile，指定要导入它。但是这时候我们还不能直接编辑，因为我们要确定一下是否真的支持导入AFNetworking。
   
```bash
$ pod search AFNetworking
```

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/15481263983217.jpg)
   
search的结果告诉我们，确实支持导入AFNetworking，当前的最新版是3.2.1，还有很多历史版本可以导入，AFNetworking里还有子库。现在可以来编辑Podfile：

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/15481249314614.jpg)

编辑完成之后，执行下面命令完成导入：
   
```bash
$ pod install
```
   
导入完成之后，Xcode打开工程的时候不再使用 **CocoapodsDemo.xcodeeproj**，使用 **CocoaPods.xcworkspace** 打开工程，此时的工程目录如下图：

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/15481250903053.jpg)
   
## Podfile

[Podfile Syntax Reference](https://guides.cocoapods.org/syntax/podfile.html)

> The Podfile is a specification that describes the dependencies of the targets of one or more Xcode projects.

Podfile是一个描述一个或多个Xcode项目的目标依赖项的规范，更直白的说就是指定项目要导入什么依赖，并指定一些导入设置。

接下来简单分析一下CocoaPodsDemo这个工程里的Podfile：

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/15481258803893.jpg)

这里指定工程所支持的最低系统版本

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/15481259105045.jpg)

这里指定是否以动态库的形式编译Pods

- `# use_frameworks` 是以Static Library的形式编译
- `use_frameworks` 默认是以Dynamic Framework的形式编译

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/15481260080281.jpg)

这里指定要导入的依赖，这里的写法有很多种。

```ruby
pod 'AFNetworking'
```

例子中的这种写法，指定导入最新版的AFNetworking。我们也可以指定版本号：

```ruby
pod 'AFNetworking', '~>3.2.1'
```

## 更多Pod使用以及脱坑
### pod install 很慢怎么办?

```bash
$ pod install --verbose --no-repo-update
```

每次 `pod install` 的时候，都会去更新repo，但是速度又很慢，这条命令可以直接跳过更新
   
### 目前工程导入了多个依赖，如何更新依赖，如何更新指定依赖？

```bash
$ pod update # 更新所有依赖
$ pod update AFNetworking # 只更新AFNetworking
```

`pod update` 也会更新repo，速度很慢，所以也可以这样跳过更新：

```bash
$ pod update AFNetworking --verbose --no-repo-update
```

### 如何更新repo?

```bash
$ pod repo update
```

### pod报CocoaPods was not able to update the \`master\` repo

```bash
#第一步 删除缓存
$ sudo rm -fr ~/Library/Caches/CocoaPods/

#第二步 清空本地Repos
$ sudo rm -fr ~/.cocoapods/repos/master/

#第三部 重新setup
$ pod setup
```

### pod search 报错 [!] Unable to find a pod with name, author, summary, or descriptionmatching `JSON`

``` bash
#第一步 删除search_index.json
$ rm ~/Library/Caches/CocoaPods/search_index.json

#第二步 重新search
$ pod search JSON
```

### 安装Pods失败，提示Ruby版本过低，这需要去升级Ruby（这里采用RVM方式升级）

``` bash
# 第一步 安装RVM
$ curl -L get.rvm.io | bash -s stable

# 第二步 安装成功之后
$ source ~/.bashrc
$ source ~/.bash_profile
$ rvm -v # 查看RVM版本

# 第三步 升级Ruby
# 查看现有Ruby版本
$ ruby -v

# 列出可安装的版本
$ rvm list known

# 安装最新版
$ rvm install 2.3.0
```

### gem版本过老

``` bash
#升级gem
$ sudo gem update --system

#查看gem版本
$ gem --version
```
