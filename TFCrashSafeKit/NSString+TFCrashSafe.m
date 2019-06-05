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
    id rValue = nil;
    if (from >= 0 && from < self.length) {
        rValue = [self tfsafe_substringFromIndex:from];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSString:substringFromIndex:type:)]) {
                rValue = [del tfCrashActionNSString:self substringFromIndex:from type:TFCrashTypeNSStringFromIndex];
            }
        }else{
            @try {
                rValue = [self tfsafe_substringFromIndex:from];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
    return rValue;
}

- (NSString *)tfsafe_substringToIndex:(NSUInteger)to{
    id rValue = nil;
    if (to >= 0 && to < self.length) {
        rValue = [self tfsafe_substringToIndex:to];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSString:substringToIndex:type:)]) {
                rValue = [del tfCrashActionNSString:self substringToIndex:to type:TFCrashTypeNSStringToIndex];
            }
        }else{
            @try {
                rValue = [self tfsafe_substringToIndex:to];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
    return rValue;
}

- (NSString *)tfsafe_substringWithRange:(NSRange)range{
    id rValue = nil;
    if (range.location >= 0 &&
        range.length >= 0 &&
        (range.location + range.length) < self.length) {
        rValue = [self tfsafe_substringWithRange:range];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSString:substringWithRange:type:)]) {
                rValue = [del tfCrashActionNSString:self substringWithRange:range type:TFCrashTypeNSStringToIndex];
            }
        }else{
            @try {
                rValue = [self tfsafe_substringWithRange:range];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
    return rValue;
}

-(unichar)tfsafe_characterAtIndex:(NSUInteger)index{
    unichar rValue = 0;
    if (index >= 0 && index < self.length) {
        rValue = [self tfsafe_characterAtIndex:index];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSString:characterAtIndex:type:)]) {
                rValue = [del tfCrashActionNSString:self characterAtIndex:index type:TFCrashTypeNSStringAtIndex];
            }
        }else{
            @try {
                rValue = [self tfsafe_characterAtIndex:index];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
    return rValue;
}



- (NSString *)tfsafe_substringWithRange9More:(NSRange)range{
    id rValue = 0;
    if (range.location >= 0 &&
        range.length >= 0 &&
        (range.location + range.length) < self.length) {
        rValue = [self tfsafe_substringWithRange9More:range];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSString:substringWithRange:type:)]) {
                rValue = [del tfCrashActionNSString:self substringWithRange:range type:TFCrashTypeNSStringRange9More];
            }
        }else{
            @try {
                rValue = [self tfsafe_substringWithRange9More:range];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
    return rValue;
}

-(unichar)tfsafe_characterAtIndex9More:(NSUInteger)index{
    unichar rValue = 0;
    if (index >= 0 && index < self.length) {
        rValue = [self tfsafe_characterAtIndex9More:index];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSString:characterAtIndex:type:)]) {
                rValue = [del tfCrashActionNSString:self characterAtIndex:index type:TFCrashTypeNSStringAtIndex9More];
            }
        }else{
            @try {
                rValue = [self tfsafe_characterAtIndex9More:index];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
    return rValue;
}



@end
