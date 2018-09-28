---
title: 正则表达式在iOS开发中的应用
date: 2018-03-28 17:08:01
tags: 
  - iOS Memo
categories:
  - iOS
  - NSString
toc: true
comments: true
---

在代码开发过程中，我们经常需要用来校验邮箱、手机号等等，这个时候就需要用到正则表达式。在iOS开发中，能用来做正则校验的有两个 `NSPredicate` 和 `NSRegularExpression` 。

## NSPredicate

`NSPredicate` 能用来简单做正则校验，但是它的问题是存在校验不出来的情况。

**NSString+VURegEx.h**

``` objectivec
#import <Foundation/Foundation.h>

@interface NSString (VURegEx)

#pragma mark - NSPredicate

- (BOOL)vu_matchedByPrdicateToRegEx:(NSString *)regEx;

@end
```

**NSString+VURegEx.m**

```objectivec
#import "NSString+VURegEx.h"

@implementation NSString (VURegEx)

#pragma mark - NSPredicate

- (BOOL)vu_matchedByPrdicateToRegEx:(NSString *)regEx{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [predicate evaluateWithObject:self];
}

@end
```

## NSRegularExpression （推荐）

`NSRegularExpression` 相对于 `NSPredicate` 功能就强大的多了，这也是iOS正则校验的正统路子。

**NSString+VURegEx.h**

``` objectivec
#import <Foundation/Foundation.h>

@interface NSString (VURegEx)

#pragma mark - NSRegularExpression

//校验是否匹配
- (BOOL)vu_matchedToRegEx:(NSString *)regEx;

//匹配到的第一个字符串
- (NSString *)vu_firstMatchToRegEx:(NSString *)regEx;

//所有匹配的字符串
- (NSArray *)vu_matchesToRegEx:(NSString *)regEx;

//替换匹配到的字符串
- (NSString *)vu_stringByReplacingMatchesToRegEx:(NSString *)regEx replacingString:(NSString *)replacingString;

@end
```

**NSString+VURegEx.m**

```objectivec
#import "NSString+VURegEx.h"

@implementation NSString (VURegEx)

#pragma mark - NSRegualrExpression

//校验是否匹配
- (BOOL)vu_matchedToRegEx:(NSString *)regEx{
    
    NSError *error;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSUInteger number = [regularExpression numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return number != 0;
}

//匹配到的第一个字符串
- (NSString *)vu_firstMatchToRegEx:(NSString *)regEx{
    NSError *error;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *firstMatch = [regularExpression firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    if (firstMatch) {
        NSString *result = [self substringWithRange:firstMatch.range];
        return result;
    }
    return nil;
}

//所有匹配的字符串
- (NSArray *)vu_matchesToRegEx:(NSString *)regEx{
    NSError *error;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *matchArray = [regularExpression matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    NSMutableArray *array = [NSMutableArray array];
    if (matchArray.count != 0) {
        for (NSTextCheckingResult *match in matchArray) {
            NSString *result = [self substringWithRange:match.range];
            [array addObject:result];
        }
    }
    
    return array;
}

//替换匹配到的字符串
- (NSString *)vu_stringByReplacingMatchesToRegEx:(NSString *)regEx replacingString:(NSString *)replacingString{
    NSError *error;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:NSRegularExpressionCaseInsensitive error:&error];

    return [regularExpression stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:replacingString];
}

@end
```
