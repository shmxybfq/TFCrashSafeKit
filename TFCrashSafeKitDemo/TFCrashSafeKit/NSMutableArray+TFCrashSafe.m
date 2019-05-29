//
//  NSMutableArray+TFCrashSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSMutableArray+TFCrashSafe.h"
#import <objc/runtime.h>
#import "TFCrashSafeKit.h"
#import "NSObject+MethodExchange.h"
#import "TFCrashSafeKit+CrashAction.h"

@implementation NSMutableArray (TFCrashSafe)

+(void)useSafe_NSMutableArray_TFCrashSafe{
  
    //不可变的只有一个元素的数组
    //只替换【objectAtIndex:】的效果包含了【objectAtIndex:】和【objectAtIndexedSubscript:】
    //只替换【objectAtIndexedSubscript:】的效果包含了【objectAtIndexedSubscript:】
    Class arraysM = NSClassFromString(@"__NSArrayM");
    [arraysM tf_instanceMethodExchange:@selector(objectAtIndex:)
                               toClass:[self class]
                                 toSel:@selector(tfsafe_objectAtIndexM:)];
    [arraysM tf_instanceMethodExchange:@selector(objectAtIndexedSubscript:)
                               toClass:[self class]
                                 toSel:@selector(tfsafe_objectAtIndexedSubscriptM:)];

    //【addObject:】 底层调用【insertObject:atIndex:】
    [arraysM tf_instanceMethodExchange:@selector(addObject:)
                               toClass:[self class]
                                 toSel:@selector(tfsafe_addObject:)];
    
    [arraysM tf_instanceMethodExchange:@selector(insertObject:atIndex:)
                               toClass:[self class]
                                 toSel:@selector(tfsafe_insertObject:atIndex:)];

    [arraysM tf_instanceMethodExchange:@selector(setObject:atIndexedSubscript:)
                               toClass:[self class]
                                 toSel:@selector(tfsafe_setObject:atIndexedSubscript:)];

    [arraysM tf_instanceMethodExchange:@selector(removeObjectAtIndex:)
                               toClass:[self class]
                                 toSel:@selector(tfsafe_removeObjectAtIndex:)];
}


- (id)tfsafe_objectAtIndexM:(NSUInteger)index {
    if (index >= 0 && index < self.count) {
        return [self tfsafe_objectAtIndexM:index];
    }else{
        return [TFCrashSafeKit tfCrashActionNSMutableArray:self
                                                     index:index
                                                      type:TFCrashTypeNSMutableArrayGet];
    }
}

- (id)tfsafe_objectAtIndexedSubscriptM:(NSUInteger)index {
    if (index >= 0 && index < self.count) {
        return [self tfsafe_objectAtIndexedSubscriptM:index];
    }else{
        return [TFCrashSafeKit tfCrashActionNSMutableArray:self
                                                     index:index
                                                      type:TFCrashTypeNSMutableArrayGetSubscript];
    }
}


-(void)tfsafe_addObject:(id)anObject{
    NSLog(@"添加：%@",anObject);
    if (anObject) {
        NSLog(@"添加成功");
        [self tfsafe_addObject:anObject];
    }else{
        NSLog(@"添加失败");
        if ([TFCrashSafeKit shareInstance].collectException) {
            @try {
                [self tfsafe_addObject:anObject];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {}
        }
    }
}

- (void)tfsafe_insertObject:(id)anObject atIndex:(NSUInteger)index{
    NSLog(@"插入：%@",anObject);
    if (anObject && index >= 0 && index <= self.count) {
        NSLog(@"插入成功");
        [self tfsafe_insertObject:anObject atIndex:index];
    }else{
        NSLog(@"插入失败");
        if ([TFCrashSafeKit shareInstance].collectException) {
            @try {
                [self tfsafe_insertObject:anObject atIndex:index];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {}
        }
    }
}

- (void)tfsafe_setObject:(id)anObject atIndexedSubscript:(NSUInteger)index{
    NSLog(@"下标添加：%@",anObject);
    if (anObject && index >= 0 && index <= self.count) {
        NSLog(@"下标添加成功");
        [self tfsafe_setObject:anObject atIndexedSubscript:index];
    }else{
        NSLog(@"下标添加失败");
        if ([TFCrashSafeKit shareInstance].collectException) {
            @try {
                [self tfsafe_setObject:anObject atIndexedSubscript:index];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {}
        }
    }
}

- (void)tfsafe_removeObjectAtIndex:(NSUInteger)index {
    NSLog(@"移除下标：%@",@(index));
    if (index >= 0 && index < self.count) {
        NSLog(@"移除下标成功");
        [self tfsafe_removeObjectAtIndex:index];
    }else{
        NSLog(@"移除下标失败");
        if ([TFCrashSafeKit shareInstance].collectException) {
            @try {
                [self tfsafe_removeObjectAtIndex:index];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {}
        }
    }
}


@end
