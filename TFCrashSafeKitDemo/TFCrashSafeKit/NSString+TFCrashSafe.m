//
//  NSString+TFCrashSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSString+TFCrashSafe.h"
#import "TFMethodExchange.h"
#import <objc/runtime.h>
#import "TFCrashSafeKitManager.h"

@implementation NSString (TFCrashSafe)

+(void)useSafe_NSString_TFCrashSafe{
    
    Class __NSCFConstantString = NSClassFromString(@"__NSCFConstantString");
    
    [TFMethodExchange tf_instanceMethodExchange:__NSCFConstantString
                                      originSel:NSSelectorFromString(@"substringFromIndex:")
                                          toSel:NSSelectorFromString(@"tfsafe_substringFromIndex:")];
    [TFMethodExchange tf_instanceMethodExchange:__NSCFConstantString
                                      originSel:NSSelectorFromString(@"substringToIndex:")
                                          toSel:NSSelectorFromString(@"tfsafe_substringToIndex:")];
    [TFMethodExchange tf_instanceMethodExchange:__NSCFConstantString
                                      originSel:NSSelectorFromString(@"substringWithRange:")
                                          toSel:NSSelectorFromString(@"tfsafe_substringWithRange:")];
    [TFMethodExchange tf_instanceMethodExchange:__NSCFConstantString
                                      originSel:NSSelectorFromString(@"characterAtIndex:")
                                          toSel:NSSelectorFromString(@"tfsafe_characterAtIndex:")];
}

-(NSString *)tfsafe_substringFromIndex:(NSUInteger)from{
    if (from >= 0 && from < self.length) {
        return [self tfsafe_substringFromIndex:from];
    }else{
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_substringFromIndex:from];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {
                return nil;
            }
        }
    }
    return nil;
}

- (NSString *)tfsafe_substringToIndex:(NSUInteger)to{
    if (to >= 0 && to < self.length) {
        return [self tfsafe_substringToIndex:to];
    }else{
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_substringToIndex:to];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {
                return nil;
            }
        }
    }
    return nil;
}

- (NSString *)tfsafe_substringWithRange:(NSRange)range{
    if (range.location >= 0 && range.length >= 0 && (range.location + range.length) < self.length) {
        return [self tfsafe_substringWithRange:range];
    }else{
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_substringWithRange:range];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {
                return nil;
            }
        }
    }
    return nil;
}

-(unichar)tfsafe_characterAtIndex:(NSUInteger)index{
    if (index >= 0 && index < self.length) {
        return [self tfsafe_characterAtIndex:index];
    }else{
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_characterAtIndex:index];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {
                return 0;
            }
        }
    }
    return 0;
}



@end
