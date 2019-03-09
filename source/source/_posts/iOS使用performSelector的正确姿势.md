---
title: iOS使用performSelector的正确姿势
date: 2018-07-10 15:26:54
tags: 
  - Objective-C
categories:
  - iOS
toc: true
comments: true
---

首先问个问题，知道方法名，怎么执行这个方法?

## `performSelector`

`performSelector` 应该是我们第一反应蹦出来的答案，代码如下：

```objectivec
SEL selector = NSSelectorFromString(@"方法名");
if (selector && [self respondsToSelector:selector]) {
    [self performSelector:selector];
}
```

运行一下，方法被执行了，但是问题来了，竟然有个黄色警告，怎么解决呢？

进阶一下：

```objectivec
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks" 

//下面调用performSelector
SEL selector = NSSelectorFromString(@"方法名");
if (selector && [self respondsToSelector:selector]) {
    [self performSelector:selector];
}

#pragma clang diagnostic pop
```

## IMP

但是除了 `performSelector` 还有个方法：

```objectivec
SEL selector = NSSelectorFromString(@"方法名");
if (selector && [self respondsToSelector:selector]) {
     IMP imp = [self methodForSelector:selector];
     void (*func)(id, SEL) = (void *)imp;
     func(self, selector);  
}
```