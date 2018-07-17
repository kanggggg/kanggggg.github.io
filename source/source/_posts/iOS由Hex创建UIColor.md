---
title: iOS由Hex创建UIColor
date: 2018-07-17 19:58:01
tags: 
  - iOS Memo
  - 代码段
categories:
  - iOS
  - UIColor
toc: true
comments: true
---

**UIColor+VUHex.h**

```objectivec
#import <UIKit/UIKit.h>

@interface UIColor (VUHex)

#pragma mark - 构造

/**
 由Hex创建UIColor
 */
+ (UIColor *)vu_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;
+ (UIColor *)vu_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
```

**UIColor+VUHex.m**

```objectivec
#import "UIColor+VUHex.h"

@implementation UIColor (VUHex)

#pragma mark - 构造

+ (UIColor *)vu_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:alpha];
}

+ (UIColor *)vu_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r/255.0f) green:((float)g/255.0f) blue:((float)b/255.0f) alpha:alpha];
}

@end
```
