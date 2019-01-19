---
title: 正则表达式在iOS开发中的应用
date: 2018-03-29 17:08:01
tags: 
  - iOS Memo
  - 正则
categories:
  - iOS
  - NSString
toc: true
comments: true
---

在代码开发过程中，我们经常需要用来校验邮箱、手机号等等，这个时候就需要用到正则表达式。在iOS开发中，能用来做正则校验的有两个 `NSPredicate` 和 `NSRegularExpression` 。

## NSPredicate

`NSPredicate` 能用来简单做正则校验，但是它的问题是存在校验不出来的情况。

**NSString+RegEx.h**

``` objectivec
#import <Foundation/Foundation.h>

@interface NSString (RegEx)

#pragma mark - NSPredicate

- (BOOL)matchedByPrdicateToRegEx:(NSString *)regEx;

@end
```

**NSString+RegEx.m**

```objectivec
#import "NSString+RegEx.h"

@implementation NSString (RegEx)

#pragma mark - NSPredicate

- (BOOL)matchedByPrdicateToRegEx:(NSString *)regEx{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [predicate evaluateWithObject:self];
}

@end
```

## NSRegularExpression （推荐）

`NSRegularExpression` 相对于 `NSPredicate` 功能就强大的多了，这也是iOS正则校验的正统路子。

**NSString+RegEx.h**

``` objectivec
#import <Foundation/Foundation.h>

@interface RegExMacthResult : NSObject

@property (nonatomic, copy) NSString *string;
@property (nonatomic, assign) NSRange range;

@end

@interface NSString (RegEx)

#pragma mark - NSRegularExpression

//校验是否匹配
- (BOOL)matchedToRegEx:(NSString *)regEx;

//匹配到的第一个结果
- (RegExMacthResult *)firstMatchToRegEx:(NSString *)regEx;

//所有匹配的结果
- (NSArray <RegExMacthResult *> *)matchesToRegEx:(NSString *)regEx;

//替换匹配到的字符串
- (NSString *)stringByReplacingMatchesToRegEx:(NSString *)regEx replacingString:(NSString *)replacingString;

@end
```

**NSString+RegEx.m**

```objectivec
#import "NSString+RegEx.h"

@implementation RegExMacthResult

+ (instancetype)resultWithString:(NSString *)string range:(NSRange)range {
    RegExMacthResult *result = [[RegExMacthResult alloc] init];
    result.string = string;
    result.range = range;
    return result;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, string = %@, range= %@>", [self class], self, self.string, NSStringFromRange(self.range)];
}

@end

@implementation NSString (RegEx)

#pragma mark - NSRegualrExpression

//校验是否匹配
- (BOOL)matchedToRegEx:(NSString *)regEx{
    
    NSError *error;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSUInteger number = [regularExpression numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return number != 0;
}

//匹配到的第一个字符串
- (RegExMacthResult *)firstMatchToRegEx:(NSString *)regEx{
    NSError *error;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *firstMatch = [regularExpression firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    if (firstMatch) {
        NSString *string = [self substringWithRange:firstMatch.range];
        
        return [RegExMacthResult resultWithString:string range:firstMatch.range];

        return result;
    }
    return nil;
}

//所有匹配的字符串
- (NSArray <RegExMacthResult *> *)matchesToRegEx:(NSString *)regEx{
    NSError *error;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *matchArray = [regularExpression matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    NSMutableArray *array = [NSMutableArray array];
    if (matchArray.count != 0) {
        for (NSTextCheckingResult *match in matchArray) {
            NSString *string = [self substringWithRange:match.range];
            [array addObject:[RegExMacthResult resultWithString:string range:match.range]];
        }
    }
    
    return array;
}

//替换匹配到的字符串
- (NSString *)stringByReplacingMatchesToRegEx:(NSString *)regEx replacingString:(NSString *)replacingString{
    NSError *error;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:NSRegularExpressionCaseInsensitive error:&error];

    return [regularExpression stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:replacingString];
}

@end
```
