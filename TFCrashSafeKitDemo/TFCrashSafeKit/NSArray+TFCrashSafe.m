//
//  NSArray+TFCrashSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSArray+TFCrashSafe.h"
#import "TFMethodExchange.h"
#import <objc/runtime.h>
#import "TFCrashSafeKitManager.h"
#import "NSObject+MethodExchange.h"
@implementation NSArray (TFCrashSafe)

+(void)useSafe_NSArray_TFCrashSafe{
    //不可变的只有一个元素的数组
    //只替换【objectAtIndex:】的效果包含了【objectAtIndex:】和【objectAtIndexedSubscript:】
    //只替换【objectAtIndexedSubscript:】的效果包含了【objectAtIndexedSubscript:】
    Class arrays0 = NSClassFromString(@"__NSArray0");
    [arrays0 tf_instanceMethodExchange:@selector(objectAtIndex:)
                               toClass:[self class]
                                 toSel:@selector(tfsafe_objectAtIndex1:)];
    
    
    //不可变的只有一个元素的数组
    //只替换【objectAtIndex:】的效果包含了【objectAtIndex:】和【objectAtIndexedSubscript:】
    //只替换【objectAtIndexedSubscript:】的效果包含了【objectAtIndexedSubscript:】
    Class arrays1 = NSClassFromString(@"__NSSingleObjectArrayI");
    [arrays1 tf_instanceMethodExchange:@selector(objectAtIndex:)
                               toClass:[self class]
                                 toSel:@selector(tfsafe_objectAtIndex0:)];

    
    //不可变的只有一个元素的数组
    //只替换【objectAtIndex:】的效果包含了【objectAtIndex:】
    //只替换【objectAtIndexedSubscript:】的效果包含了【objectAtIndexedSubscript:】
    Class arraysIM = NSClassFromString(@"__NSArrayI");
    [arraysIM tf_instanceMethodExchange:@selector(objectAtIndex:)
                               toClass:[self class]
                                 toSel:@selector(tfsafe_objectAtIndexIM:)];
    [arraysIM tf_instanceMethodExchange:@selector(objectAtIndexedSubscript:)
                                toClass:[self class]
                                  toSel:@selector(tfsafe_objectAtIndexedSubscriptIM:)];
    
    
//    Class arrays0 = NSClassFromString(@"__NSArray0");
//
//    return;
//    
//    [TFMethodExchange tf_instanceMethodExchange:__NSArray0
//                                      originSel:NSSelectorFromString(@"objectAtIndex:")
//                                          toSel:NSSelectorFromString(@"tfsafe_objectAtIndex:")];
//    [TFMethodExchange tf_instanceMethodExchange:__NSArray0
//                                      originSel:NSSelectorFromString(@"objectAtIndexedSubscript:")
//                                          toSel:NSSelectorFromString(@"tfsafe_objectAtIndexedSubscript:")];
//    
//    [TFMethodExchange tf_instanceMethodExchange:__NSArrayI
//                                      originSel:NSSelectorFromString(@"objectAtIndex:")
//                                          toSel:NSSelectorFromString(@"tfsafe_objectAtIndex:")];
//    [TFMethodExchange tf_instanceMethodExchange:__NSArrayI
//                                      originSel:NSSelectorFromString(@"objectAtIndexedSubscript:")
//                                          toSel:NSSelectorFromString(@"tfsafe_objectAtIndexedSubscript:")];
//    
//    [TFMethodExchange tf_instanceMethodExchange:__NSArrayM
//                                      originSel:NSSelectorFromString(@"objectAtIndex:")
//                                          toSel:NSSelectorFromString(@"tfsafe_objectAtIndex:")];
//    [TFMethodExchange tf_instanceMethodExchange:__NSArrayM
//                                      originSel:NSSelectorFromString(@"objectAtIndexedSubscript:")
//                                          toSel:NSSelectorFromString(@"tfsafe_objectAtIndexedSubscript:")];
//    
//    [TFMethodExchange tf_instanceMethodExchange:__NSSingleObjectArrayI
//                                      originSel:NSSelectorFromString(@"objectAtIndex:")
//                                          toSel:NSSelectorFromString(@"tfsafe_objectAtIndex:")];
//    [TFMethodExchange tf_instanceMethodExchange:__NSSingleObjectArrayI
//                                      originSel:NSSelectorFromString(@"objectAtIndexedSubscript:")
//                                          toSel:NSSelectorFromString(@"tfsafe_objectAtIndexedSubscript:")];
}


- (id)tfsafe_objectAtIndex0:(NSUInteger)index {
    NSLog(@"AAA:%@",@(index));
    if (index >= 0 && index < self.count) {
        NSLog(@"BBB");
        return [self tfsafe_objectAtIndex0:index];
    }else{
        NSLog(@"CCC");
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_objectAtIndex0:index];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {
                return nil;
            }
        }
    }
    return nil;
}


- (id)tfsafe_objectAtIndex1:(NSUInteger)index {
    NSLog(@"AAA:%@",@(index));
    if (index >= 0 && index < self.count) {
        NSLog(@"BBB");
        return [self tfsafe_objectAtIndex1:index];
    }else{
        NSLog(@"CCC");
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_objectAtIndex1:index];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {
                return nil;
            }
        }
    }
    return nil;
}


- (id)tfsafe_objectAtIndexIM:(NSUInteger)index {
    NSLog(@"AAA:%@",@(index));
    if (index >= 0 && index < self.count) {
        NSLog(@"BBB");
        return [self tfsafe_objectAtIndexIM:index];
    }else{
        NSLog(@"CCC");
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_objectAtIndexIM:index];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {
                return nil;
            }
        }
    }
    return nil;
}


- (id)tfsafe_objectAtIndexedSubscriptIM:(NSUInteger)index {
    NSLog(@"DDD:%@",@(index));
    if (index >= 0 && index < self.count) {
        NSLog(@"EEE");
        return [self tfsafe_objectAtIndexedSubscriptIM:index];
    }else{
        NSLog(@"FFF");
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_objectAtIndexedSubscriptIM:index];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {
                return nil;
            }
        }
    }
    return nil;
}


@end
