---
title: Hexo+Github Page搭建博客
date: 2018-03-28 17:16:02
tags:
  - hexo
categories:
  - hexo
toc: true
---

作为一个程序员时常需要写点文章总结自己的收获，对新技术的了解等等，所以没有自己的博客是说不过去的一件事情。搭建博客的渠道也有很多，也完全可以借助一些技术社区，这里我用的是自己搭建Hexo博客，部署在GitHub Pages上，使用GitHub Pages完全不必担心我们没有服务器没有域名这件事。

在开始操作Hexo之前，需要先学会用Markdown写文章，然后这里有几个链接，绝对有大用：

- [Markdown](http://wowubuntu.com/markdown/index.html)
- [GitHub Pages](https://pages.github.com/)
- [Hexo中文网站](https://hexo.io/zh-cn/)

## GitHub Pages

新建一个repository，可以Public访问的，repository name 设置成 **username.github.io** ，那么repository url 就是 **https://github.com/username/username.github.io.git** , GitHub Pages的访问地址 **https://username.github.io** 。

## Hexo

### 安装Hexo

在安装Hexo之前有两个东西是必须要安装的：
- Node.js: [[官网](https://nodejs.org/en/)] 
- Git：[[官网](http://git-scm.com/)]、[[安装方式](https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-%E5%AE%89%E8%A3%85-Git)]

上面两个依赖安装完成之后，就可以用npm安装Hexo了：

``` bash
$ npm install -g hexo-cli
```

### 新建站点

安装Hexo之后，需要在本地建立一个站点：

``` bash
# 新建username.github.io站点文件夹
$ hexo init username.github.io
$ cd username.github.io
$ npm install
```

### 本地调试

安装完成之后，可以本地调试一下，验证一下是否安装成功了：

1. 需要先安装 **hexo-server**
  
   ```bash
   $ npm install hexo-server --save
   ```

2. 三步命令
  
   ``` bash
   # 清除缓存
   $ hexo clean
   
   # 生产静态文件
   $ hexo g
   
   # 启动本地服务器，本地默认访问地址 http://localhost:4000/
   $ hexo server
   $ hexo server -p 5000 # 这就把端口改到了5000
   ```

最后打开浏览器访问 [http://localhost:4000/](http://localhost:4000/) ，不出意外就可以看到本地的网站了。这三个命令，在以后我们添加了文章或者作了修改，需要调试的时候，会经常用到。

### 部署

1. 打开站点配置文件 **_config.yml** ，修改 **deploy** 相关的参数。

   ```
   deploy:
     type: git
     repository: https://github.com/username/username.github.io.git
     branch: master
   ```
   
2. 安装 **hexo-deployer-git**

	``` bash
	$ npm install hexo-deployer-git --save
	```

3. 部署上传，在经过本地调试没有问题之后，就可以上传了。
  
   ``` bash
   $ hexo d
   ```

### 新建文章

```bash
$ hexo new <title>
```

文章的默认存储在 **/source/_posts** 下，新建完成之后，就可以去编辑文档了。 

### 主题

Hexo是有很多第三方主题可供使用，[hexo themes](https://hexo.io/themes/) 官方收集了一些主题。我安利一下下面这两个：

- [NexT](http://theme-next.iissnan.com/getting-started.html)：曾经用过，作者很用心
- [Pure](https://github.com/cofess/hexo-theme-pure) - [Preview](http://blog.cofess.com) ：这是我目前用的

### 插件

- [hexo-browsersync](https://github.com/hexojs/hexo-browsersync)：这个插件强烈安利，这个插件装上之后，每次只要运行一次 `hexo server` ，然后接着修改，会直接同步到浏览器页面，不需要我们一点点改动都走三个命令了

### 报错解决

1. DTrace错误：

   ```
   { [Error: Cannot find module './build/default/DTraceProviderBindings'] code: 'MODULE_NOT_FOUND' }
   { [Error: Cannot find module './build/Debug/DTraceProviderBindings'] code: 'MODULE_NOT_FOUND' }
   ```
   
   解决办法：
   
   ``` bash
   $ npm install hexo --no-optional
   ```
