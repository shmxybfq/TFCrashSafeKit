//
//  NSMutableArray+TFCrashSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSMutableArray+TFCrashSafe.h"
#import "TFMethodExchange.h"
#import <objc/runtime.h>
#import "TFCrashSafeKitManager.h"

@implementation NSMutableArray (TFCrashSafe)

+(void)useSafe_NSMutableArray_TFCrashSafe{
    
    Class __NSArrayM = NSClassFromString(@"__NSArrayM");
  
    [TFMethodExchange tf_instanceMethodExchange:__NSArrayM
                                      originSel:NSSelectorFromString(@"addObject:")
                                          toSel:NSSelectorFromString(@"tfsafe_addObject:")];
    [TFMethodExchange tf_instanceMethodExchange:__NSArrayM
                                      originSel:NSSelectorFromString(@"insertObject:atIndex:")
                                          toSel:NSSelectorFromString(@"tfsafe_insertObject:atIndex:")];
    [TFMethodExchange tf_instanceMethodExchange:__NSArrayM
                                      originSel:NSSelectorFromString(@"removeObjectAtIndex:")
                                          toSel:NSSelectorFromString(@"tfsafe_removeObjectAtIndex:")];
    [TFMethodExchange tf_instanceMethodExchange:__NSArrayM
                                      originSel:NSSelectorFromString(@"setObject:atIndexedSubscript:")
                                          toSel:NSSelectorFromString(@"tfsafe_setObject:atIndexedSubscript:")];
}

-(void)tfsafe_addObject:(id)anObject{
    if (anObject) {
        [self tfsafe_addObject:anObject];
    }else{
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_addObject:anObject];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {}
        }
    }
}

- (void)tfsafe_insertObject:(id)anObject atIndex:(NSUInteger)index{
    if (anObject && index >= 0 && index < self.count) {
        [self tfsafe_insertObject:anObject atIndex:index];
    }else{
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_insertObject:anObject atIndex:index];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {}
        }
    }
}

- (void)tfsafe_removeObjectAtIndex:(NSUInteger)index {
    if (index >= 0 && index < self.count) {
        [self tfsafe_removeObjectAtIndex:index];
    }else{
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_removeObjectAtIndex:index];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {}
        }
    }
}

- (void)tfsafe_setObject:(id)anObject atIndexedSubscript:(NSUInteger)index{
    if (anObject && index >= 0 && index < self.count) {
        [self tfsafe_setObject:anObject atIndexedSubscript:index];
    }else{
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_setObject:anObject atIndexedSubscript:index];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {}
        }
    }
}


@end
