---
title: iOS由Hex创建UIColor
date: 2018-07-17 19:58:01
tags: 
  - Objective-C
  - UIColor
  - ShowMeTheCode
categories:
  - iOS
toc: true
comments: true
---

**UIColor+Hex.h**

```objectivec
#import <UIKit/UIKit.h>

@interface UIColor (Hex)

#pragma mark - 构造

/**
 由Hex创建UIColor
 */
+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end

static inline UIColor *ColorWithHex(NSInteger hex) {
    return [UIColor colorWithHex:hex alpha:1.0];
}

static inline UIColor *ColorWithHexAndAlpha(NSInteger hex, CGFloat alpha) {
    return [UIColor colorWithHex:hex alpha:alpha];
}

static inline UIColor *ColorWithHexString(NSString *hexString) {
    return [UIColor colorWithHexString:hexString alpha:1.0];
}

static inline UIColor *ColorWithHexAndAlpha(NSString *hexString, CGFloat alpha) {
    return [UIColor colorWithHexString:hexString alpha:alpha];
}
```

**UIColor+Hex.m**

```objectivec
#import "UIColor+Hex.h"

@implementation UIColor (Hex)

#pragma mark - 构造

+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
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
