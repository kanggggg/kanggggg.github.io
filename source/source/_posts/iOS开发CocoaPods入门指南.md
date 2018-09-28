---
title: iOS开发CocoaPods入门指南
date: 2018-09-28 17:57:31
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

简单来说，就是可以帮助你方便地导入三方库，并导入库的依赖，免去了手动完成三方库导入配置。除了导入，你还可以利用CocoaPods搭建你自己的私有库体系。因为这些功能，CocoaPods基本上所有iOS 开发者都在使用。
    
## CocoaPods环境搭建

CocoaPods是使用Ruby构建的，所以需要在本地准备好Ruby环境。不过Mac默认已经有了Ruby环境，可以免去搭建Ruby环境了。打开终端（Terminal），我们开始操作。

### 第一步. 更换RubyGems源

RubyGems在国内的访问速度极其感人，所以要进行更换，换成国内的镜像源。例子中我使用的是 [Ruby China](https://gems.ruby-china.com/) 的源。

1. 查看当前的源，这个时候我们能看到当前的源是 `https://rubygems.org`
   
   ```bash
   $ gem sources -l
   ```

2. 移除当前源，并添加新的源

   ```bash
   # Ruby China有https和http两种源，我一开始添加的是https的源会报SSL错误，改成了http就没问题
   $ gem sources --add http://gems.ruby-china.com/ --remove https://rubygems.org/
   ```
   
3. 再次查看当前源，这个时候就变成了 `http://gems.ruby-china.com`

   ```bash
   $ gem sources -l
   ```

### 第二步. 安装CocoaPods

1. 安装，执行完下面的命令，等待一会就好

   ```bash
   $ sudo gem install cocoapods
   
   # Mac OS X EI Capitan 以后系统请用下面这个安装命令
   $ sudo gem install -n /usr/local/bin cocoapods
   
   # 卸载
   $ sudo gem uninstall cocoapods
   ```

2. 查看pod版本，验证是否安装成功
   
   ```bash
   $ pod --version
   ```

3. 在安装完成之后，进行设置。这一步的主要作用就是把官方的 Specs repo ([The CocoaPods Master Repo](https://github.com/CocoaPods/Specs)) 拉到本地，本地仓库的存放目录是 `~/.cocoapods/repos/master` 

   ```bash
   $ pod setup
   ```
   
   **友情提醒1，这一步很慢很慢，请耐心等待**
   **友情提醒2，如果你很没有耐心，你可以偷懒从其他安装好了CocoaPods的电脑上，拷贝一份repos到你的电脑上**
   
## CocoaPods管理依赖库

经过上面的折腾，CocoaPods已经安装成功了，我们要用来管理依赖库了，下面以导入AFNetworking进行演示。

1. 查看可用的三方库

   ```bash
   $ pod search AFNetworking
   
   # Ctrl+Z 退出
   ```
   
   ![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/20180928165151.jpg)
   
   从输出里，看到现在AFNetworking最新的版本是3.2.1。
    
2. 终端进入工程目录，新建Podfile
   
   ```bash
   $ cd ~/Desktop/CocoaPodsDemo/
   $ pod init
   ```
   
3. 编辑Podfile，`vi` 的相关操作自行了解
   
   ```bash
   $ vi Podfile
   
   # 编辑完成之后，:wq 保存退出
   ```
   
   ![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/20180928165353.jpg)

4. 导入
   
   ```bash
   $ pod install
   ```
   
   ![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/20180928165418.jpg)

5. `Pod install` 成功之后，目录结构就变成了下面这个样子，双击 `CocoaPodsDemo.xcworkspace` 打开项目
   
   ![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/20180928165446.jpg)

### Podfile简单说明

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/20180928165353.jpg)

```ruby
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
```

这一段是指定工程所支持的最低系统版本

```ruby
# Uncomment the next line if you're using Swift or would like to use dynamic frameworks
# use_frameworks!
```

这一段是设置是否以动态库的形式编译Pods

- `# use_frameworks` 是以静态库的形式编译，产出的库是 `.a`
- `use_frameworks` 是以动态库的形式编译，产出的库是 `.framework`

```ruby
pod 'AFNetworking', '~> 3.2.1'  
```

这一句是设置三方库, `'~> 3.2.1'` 是指定了库的版本。

有的时候也这么写，这样子就是导入最新版本的：

```ruby
pod 'AFNetworking' 
```

## CocoaPods创建私有库

利用CocoaPods导入三方库，是大多数情况下的使用场景，但是CocoaPods还有一个大杀器是创建私有库。

开源三方库能用CocoaPods导入工程，是因为CocoaPods官方维护了一个公开的索引仓库。那么如果我们自己维护私有库和私有的索引仓库呢？

### 创建Pod项目工程

为什么私有库能被正确地导入工程，自动完成配置？这主要依赖的是Pod项目工程中的podspec文件。这个文件的创建有两种方法：

- 第一种自行编写测试工程，再用 `pod spec creare <库名>` 新建podspec。这个更适合于把已有项目转为Pod项目
- 第二种利用 `pod lib create <库名>` ，自动创建Pod项目工程。下面的演示就在这种形式上进行。

#### pod lib create

[Using Pod Lib Create](http://guides.cocoapods.org/making/using-pod-lib-create)

`pod lib create` 是Pod提供的一个自动化创建私有pod工程的命令，实质上是下载一个Pod工程模板到本地，再做修改。命令在运行过程中，会弹出几个配置项进行配置，按需设置就行，很简单。

```bash
$ cd ~/Desktop
$ pod lib create MyUtils
```

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/20180928165625.jpg)

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/20180928165643.jpg)

看一下MyUtils的目录结构，Example目录是测试工程，MyUtils是私有库代码。我们双击Example里的`MyUtils.xcworkspace` 打开这个工程。

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/20180928165717.jpg)

### 编写库代码

我这里就简单写一个测试类 `MUAppInfo`，写完之后再 `pod install` 进行开发模式下的导入，**我把这个测试项目放到了码云上面** ：

**MUAPPInfo.h**

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/20180928165739.jpg)

**MUAPPInfo.m**

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/20180928165758.jpg)

**MUViewController.m**

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/20180928165824.jpg)

### 编辑Podspec

- [Podspec Syntax Reference](https://guides.cocoapods.org/syntax/podspec.html#specification)
- [AFNetworking.podspec](https://github.com/AFNetworking/AFNetworking/blob/master/AFNetworking.podspec) 
- [如何选择开源许可证？](http://blog.csdn.net/wadefelix/article/details/6384317)

Podspec是这个pod的配置文件，当我们引用这个pod到工程的时候，就会按这个文件里的配置项进行配置。这边顺便提一下，podspec是Ruby文件，我们可以用 [Visual Studio Code](https://code.visualstudio.com/) 再装上Ruby插件来编辑，真的很好用。

那我们来看一下 `MyUtils.podspec` 这个文件，经过配置如下（可以作为模板使用）：

```ruby
Pod::Spec.new do |s|
  s.name             = 'MyUtils'
  s.version          = '0.1.0'
  s.summary          = 'MyUtils'
  s.description      = <<-DESC
  CocoaPods私有库测试工程
                         DESC

  s.homepage         = 'https://gitee.com/vincedev/MyUtils'

  # 证书
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  # 作者信息
  s.author           = { 'superman' => 'superman@gmail.com' }

  # 源地址
  s.source           = { :git => 'https://gitee.com/vincedev/MyUtils.git', :tag => s.version.to_s }

  # 支持最低系统版本
  s.ios.deployment_target = '8.0'

  # 源文件
  s.source_files = 'MyUtils/Classes/**/*'

  # 公开的头文件
  s.public_header_files = 'MyUtils/Classes/**/*.h'

  # 资源，多个用逗号隔开
  # s.resource = 'MyUtils/Assets/resource.bundle'

  # 是否arc
  s.requires_arc = true

  # 依赖的系统Frameworks，多个用逗号隔开
  s.frameworks = 'UIKit'

  # 依赖的系统Library，多个用逗号隔开
  # s.libraries = 'stdc++.6.0.9'

  # 依赖的三方库，有多个依赖就写多行
  # s.dependency 'AFNetworking', '~> 2.3'
  # s.dependency 'MJRefresh'
end
```

### 验证podspec

Podspec写好了，接下来需要验证是否正确，验证也有两个方法 `pod spec lint` 和 `pod lib lint` ：

```ruby
# 会去匹配 s.source 的配置
$ pod spec lint # 不指定，默认当前文件夹内的podspec
$ pod spec lint MyUtils.podspec # 指定podspec

# 忽略 s.source 的配置
$ pod lib lint # 不指定，默认当前文件夹内的podspec
$ pod lib lint MyUtils.podspec # 指定podspec
```

当看到终端打印 `passed validation.` ，就说明验证通过，不通过就根据提示进行修改。

当验证通过之后，打上tag，推送到远程仓库

```
$ git tag 0.1.0
$ git push origin --tags # 推送到远程
```

### 创建私有 Specs repo

其实私有 Specs repo 不是必须的，它的作用是让你在导入私有库的时候像导入官方开源库一样，但是我觉得更大的作用是解决私有库间的互相依赖。

如果该私有库没有依赖其他私有库，可以直接这样导入：

```bash
pod 'MyUtils', :git => 'https://gitee.com/vincedev/MyUtils.git'
```

那接下来进行私有 Specs repo 的创建，打开 `~/.cocoapods/repos` 目录，就看到里面只有 `master` 这个目录，该目录即存放着上面我们提到的官方 `Specs repo`。我们来添加自己的 `Specs repo` ：

1. 先创建一个git仓库，我这里也还是在码云上操作，新建了一个 `VinceSpecs` 项目
2. 添加到本地 `repos` 目录
   
   ```bash
   pod repo add VinceSpecs https://gitee.com/vincedev/VinceSpecs
   ```
   
   添加完成之后，`~/.cocoapods/repos` 目录下就多了一个 `VinceSpecs` 目录。
   
### 把私有Pod添加到私有 Specs repo 中

```bash
$ cd ~/Desktop/MyUtils
$ pod repo push VinceSpecs MyUtils.podspec
```

添加成功之后，就能看到 `~/.cocoapods/repos/VinceSpecs` 多了 `MyUtils`，`VinceSpecs` 的远程仓库同步更新了。

### 测试工程导入私有库

这里拿出上面的 `CocoaPodsDemo` 这个工程进行测试，编辑 Podfile ，编辑完成之后执行 install

![](https://myblog-image.oss-cn-shanghai.aliyuncs.com/20180928165859.jpg)
   
这一步的重点在于指定私有 `Specs repo` 仓库，而且还要指定官方的 `Specs repo` 仓库。

## 结语

这篇文章算是我自己在使用CocoaPods过程中的一个入门记录，私有库创建中还踩了很多坑，这里就不写了，请看下回分解吧。如果各位看管搜到了这篇文章并耐心看完了，本文如对你有所帮助，就达到我的目的了！！！保佑看官们代码无bug！！！

### 参考链接

- [CocoaPods](https://cocoapods.org/)
- [CocoaPods Guides](https://guides.cocoapods.org/)
- [CocoaPods Github](https://github.com/CocoaPods/CocoaPods)
- [用CocoaPods做iOS程序的依赖管理](http://blog.devtang.com/2014/05/25/use-cocoapod-to-manage-ios-lib-dependency/#u4F7F_u7528_CocoaPods__u7684_u955C_u50CF_u7D22_u5F15)
- [CocoaPods安装和使用教程](http://www.code4app.com/article/cocoapods-install-usage)
