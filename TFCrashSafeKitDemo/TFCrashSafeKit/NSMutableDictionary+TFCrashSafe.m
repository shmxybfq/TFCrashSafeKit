//
//  NSMutableDictionary+TFCrashSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSMutableDictionary+TFCrashSafe.h"
#import <objc/runtime.h>
#import "TFCrashSafeKitManager.h"
#import "NSObject+MethodExchange.h"

@implementation NSMutableDictionary (TFCrashSafe)

+(void)useSafe_NSMutableDictionary_TFCrashSafe{
    
    Class dicM = NSClassFromString(@"__NSDictionaryM");//可变字典
    [dicM tf_instanceMethodExchange:@selector(setObject:forKey:)
                            toClass:[self class]
                              toSel:@selector(tfsafe_setObject:forKey:)];
    
    [dicM tf_instanceMethodExchange:@selector(setObject:forKeyedSubscript:)
                            toClass:[self class]
                              toSel:@selector(tfsafe_setObject:forKeyedSubscript:)];

    //【setDictionary】底层循环调用【setObject:forKey:】
    [dicM tf_instanceMethodExchange:@selector(setDictionary:)
                            toClass:[self class]
                              toSel:@selector(tfsafe_setDictionary:)];
    
    //【setDictionary】底层循环调用【setObject:forKey:】
    [dicM tf_instanceMethodExchange:@selector(addEntriesFromDictionary:)
                            toClass:[self class]
                              toSel:@selector(tfsafe_addEntriesFromDictionary:)];

    [dicM tf_instanceMethodExchange:@selector(removeObjectForKey:)
                            toClass:[self class]
                              toSel:@selector(tfsafe_removeObjectForKey:)];

    [dicM tf_instanceMethodExchange:@selector(removeObjectsForKeys:)
                            toClass:[self class]
                              toSel:@selector(tfsafe_removeObjectsForKeys:)];
    
}

-(void)tfsafe_setObject:(id)anObject forKey:(id<NSCopying>)aKey{
    NSLog(@"设置fuc:%s:%@:%@",__func__,anObject,aKey);
    if (anObject && aKey) {
        NSLog(@"设置成功");
        [self tfsafe_setObject:anObject forKey:aKey];
    }else{
        NSLog(@"设置失败");
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
    NSLog(@"下标设置fuc:%s:%@:%@",__func__,anObject,aKey);
    if (anObject && aKey) {
        NSLog(@"下标设置成功");
        [self tfsafe_setObject:anObject forKeyedSubscript:aKey];
    }else{
        NSLog(@"下标设置失败");
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
    NSLog(@"字典设置fuc:%s:%@",__func__,otherDictionary);
    if (otherDictionary && [otherDictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"字典设置成功");
        [self tfsafe_setDictionary:otherDictionary];
    }else{
        NSLog(@"字典设置失败");
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
    NSLog(@"字典添加fuc:%s:%@",__func__,otherDictionary);
    if (otherDictionary && [otherDictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"字典添加成功");
        [self tfsafe_addEntriesFromDictionary:otherDictionary];
    }else{
        NSLog(@"字典添加失败");
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
    NSLog(@"字典移除fuc:%s:%@",__func__,aKey);
    if (aKey) {
        NSLog(@"字典移除成功");
        [self tfsafe_removeObjectForKey:aKey];
    }else{
        NSLog(@"字典移除失败");
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
