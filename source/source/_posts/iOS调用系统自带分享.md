---
title: iOS调用系统自带分享
date: 2018-07-09 11:22:40
tags: 
  - iOS
  - Objective-C
  - ShowMeTheCode
categories:
  - iOS
toc: true
comments: true
---

iOS调用系统自带分享还是很简单的，步骤也很简单，主要就用到 `UIActivityViewController` 。

## Example

```objectivec
NSString *sharedText = @"文字"; //文字
NSURL *sharedFileURL = [NSURL fileURLWithPath:@"文件路径"]; //文件
UIImage *sharedImage = [UIImage imageNamed:@"xxx.jpg"]; //图片
NSURL *sharedURL = [NSURL URLWithString:@"http://www.baidu.com"]; //URL

NSArray *activityItems = @[sharedText, sharedURL, sharedImage, sharedFileURL];

//初始化UIActivityViewController
//applicationActivities 这个参数是自定义的UIActivity，自定义的UIActivity需要继承自UIActivity，并重写部分方法
UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];

//设置不出现在分享面板的项目
activityViewController.excludedActivityTypes = @[UIActivityTypePrint];

//分享回调
activityViewController.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
    NSString *message = completed? @"分享成功": @"分享失败";
    NSLog(@"分享结果: %@, error = %@", message, activityError);
}];

//
[self presentViewController:activityViewController animated:YES completion:nil];
```