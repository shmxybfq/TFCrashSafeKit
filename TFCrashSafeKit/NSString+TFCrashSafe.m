//
//  NSString+TFCrashSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSString+TFCrashSafe.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "TFCrashSafeKit.h"
#import "NSObject+MethodExchange.h"
#import "TFCrashSafeKit+CrashAction.h"

@implementation NSString (TFCrashSafe)

+(void)useSafe_NSString_TFCrashSafe{
    //普通字符串__NSCFConstantString-__NSCFString-NSMutableString-NSString
    
    //NSString *s006 = [NSString stringWithCString:"abc" encoding:NSUTF8StringEncoding];
    //NSTaggedPointerString-NSString-NSObject【9.0+】
    //__NSCFString-NSMutableString-NSString-NSObject【9.0-】
    
    //可变__NSCFString-NSMutableString-NSString-NSObject
    Class cls = NSClassFromString(@"__NSCFConstantString");
    [cls tf_instanceMethodExchange:@selector(substringFromIndex:)
                           toClass:[self class]
                             toSel:@selector(tfsafe_substringFromIndex:)];
    
    [cls tf_instanceMethodExchange:@selector(substringToIndex:)
                           toClass:[self class]
                             toSel:@selector(tfsafe_substringToIndex:)];

    [cls tf_instanceMethodExchange:@selector(substringWithRange:)
                           toClass:[self class]
                             toSel:@selector(tfsafe_substringWithRange:)];

    [cls tf_instanceMethodExchange:@selector(characterAtIndex:)
                           toClass:[self class]
                             toSel:@selector(tfsafe_characterAtIndex:)];
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0) {
        Class cls = NSClassFromString(@"NSTaggedPointerString");
        [cls tf_instanceMethodExchange:@selector(substringWithRange:)
                               toClass:[self class]
                                 toSel:@selector(tfsafe_substringWithRange9More:)];
        
        [cls tf_instanceMethodExchange:@selector(characterAtIndex:)
                               toClass:[self class]
                                 toSel:@selector(tfsafe_characterAtIndex9More:)];
    }
}

-(NSString *)tfsafe_substringFromIndex:(NSUInteger)from{
    if (from >= 0 && from < self.length) {
        return [self tfsafe_substringFromIndex:from];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSString:substringFromIndex:type:)]) {
                return [del tfCrashActionNSString:self substringFromIndex:from type:TFCrashTypeNSStringFromIndex];
            }
        }
    }
    return nil;
}

- (NSString *)tfsafe_substringToIndex:(NSUInteger)to{
    if (to >= 0 && to < self.length) {
        return [self tfsafe_substringToIndex:to];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSString:substringToIndex:type:)]) {
                return [del tfCrashActionNSString:self substringToIndex:to type:TFCrashTypeNSStringToIndex];
            }
        }
    }
    return nil;
}

- (NSString *)tfsafe_substringWithRange:(NSRange)range{
    if (range.location >= 0 &&
        range.length >= 0 &&
        (range.location + range.length) < self.length) {
        return [self tfsafe_substringWithRange:range];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSString:substringWithRange:type:)]) {
                return [del tfCrashActionNSString:self substringWithRange:range type:TFCrashTypeNSStringToIndex];
            }
        }
    }
    return nil;
}

-(unichar)tfsafe_characterAtIndex:(NSUInteger)index{
    if (index >= 0 && index < self.length) {
        return [self tfsafe_characterAtIndex:index];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSString:characterAtIndex:type:)]) {
                return [del tfCrashActionNSString:self characterAtIndex:index type:TFCrashTypeNSStringAtIndex];
            }
        }
    }
    return 0;
}



- (NSString *)tfsafe_substringWithRange9More:(NSRange)range{
    if (range.location >= 0 &&
        range.length >= 0 &&
        (range.location + range.length) < self.length) {
        return [self tfsafe_substringWithRange9More:range];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSString:substringWithRange:type:)]) {
                return [del tfCrashActionNSString:self substringWithRange:range type:TFCrashTypeNSStringRange9More];
            }
        }
    }
    return nil;
}

-(unichar)tfsafe_characterAtIndex9More:(NSUInteger)index{
    if (index >= 0 && index < self.length) {
        return [self tfsafe_characterAtIndex9More:index];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSString:characterAtIndex:type:)]) {
                return [del tfCrashActionNSString:self characterAtIndex:index type:TFCrashTypeNSStringAtIndex9More];
            }
        }
    }
    return 0;
}



@end
