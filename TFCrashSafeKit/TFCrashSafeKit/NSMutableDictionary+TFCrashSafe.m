//
//  NSMutableDictionary+TFCrashSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSMutableDictionary+TFCrashSafe.h"
#import "TFMethodExchange.h"
#import <objc/runtime.h>
#import "TFCrashSafeKitManager.h"

@implementation NSMutableDictionary (TFCrashSafe)

+(void)useSafe_NSMutableDictionary_TFCrashSafe{
    
    Class __NSDictionaryM = NSClassFromString(@"__NSDictionaryM");//可变字典
    [TFMethodExchange tf_instanceMethodExchange:__NSDictionaryM
                                      originSel:NSSelectorFromString(@"setObject:forKey:")
                                          toSel:NSSelectorFromString(@"tfsafe_setObject:forKey:")];
    
    [TFMethodExchange tf_instanceMethodExchange:__NSDictionaryM
                                      originSel:NSSelectorFromString(@"setObject:forKeyedSubscript:")
                                          toSel:NSSelectorFromString(@"tfsafe_setObject:forKeyedSubscript:")];
  
    [TFMethodExchange tf_instanceMethodExchange:__NSDictionaryM
                                      originSel:NSSelectorFromString(@"setDictionary:")
                                          toSel:NSSelectorFromString(@"tfsafe_setDictionary:")];
    
    [TFMethodExchange tf_instanceMethodExchange:__NSDictionaryM
                                      originSel:NSSelectorFromString(@"addEntriesFromDictionary:")
                                          toSel:NSSelectorFromString(@"tfsafe_addEntriesFromDictionary:")];

    [TFMethodExchange tf_instanceMethodExchange:__NSDictionaryM
                                      originSel:NSSelectorFromString(@"removeObjectForKey:")
                                          toSel:NSSelectorFromString(@"tfsafe_removeObjectForKey:")];
    
    [TFMethodExchange tf_instanceMethodExchange:__NSDictionaryM
                                      originSel:NSSelectorFromString(@"removeObjectsForKeys:")
                                          toSel:NSSelectorFromString(@"tfsafe_removeObjectsForKeys:")];
}

-(void)tfsafe_setObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if (anObject && aKey) {
        [self tfsafe_setObject:anObject forKey:aKey];
    }else{
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_setObject:anObject forKey:aKey];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {}
        }
    }
}

- (void)tfsafe_setObject:(id)anObject forKeyedSubscript:(id < NSCopying >)aKey{
    if (anObject && aKey) {
        [self tfsafe_setObject:anObject forKeyedSubscript:aKey];
    }else{
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_setObject:anObject forKeyedSubscript:aKey];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {}
        }
    }
}

- (void)tfsafe_setDictionary:(NSDictionary *)otherDictionary{
    if (otherDictionary && [otherDictionary isKindOfClass:[NSDictionary class]]) {
        [self tfsafe_setDictionary:otherDictionary];
    }else{
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_setDictionary:otherDictionary];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {}
        }
    }
}

-(void)tfsafe_addEntriesFromDictionary:(NSDictionary *)otherDictionary{
    if (otherDictionary && [otherDictionary isKindOfClass:[NSDictionary class]]) {
        [self tfsafe_addEntriesFromDictionary:otherDictionary];
    }else{
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_addEntriesFromDictionary:otherDictionary];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {}
        }
    }
}


-(void)tfsafe_removeObjectForKey:(id)aKey{
    if (aKey) {
        [self tfsafe_removeObjectForKey:aKey];
    }else{
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_removeObjectForKey:aKey];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {}
        }
    }
}

-(void)tfsafe_removeObjectsForKeys:(NSArray *)keyArray{
    if (keyArray && [keyArray isKindOfClass:[NSArray class]]) {
        [self tfsafe_removeObjectsForKeys:keyArray];
    }else{
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_removeObjectsForKeys:keyArray];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {}
        }
    }
}

@end
