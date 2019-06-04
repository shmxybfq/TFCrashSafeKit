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
        id del = [TFCrashSafeKit shareInstance];
        if ([del respondsToSelector:@selector(tfCrashActionNSMutableArray:index:type:)]) {
           return [del tfCrashActionNSMutableArray:self index:index type:TFCrashTypeNSMutableArrayGet];
        }
    }
    return nil;
}

- (id)tfsafe_objectAtIndexedSubscriptM:(NSUInteger)index {
    if (index >= 0 && index < self.count) {
        return [self tfsafe_objectAtIndexedSubscriptM:index];
    }else{
        id del = [TFCrashSafeKit shareInstance];
        if ([del respondsToSelector:@selector(tfCrashActionNSMutableArray:index:type:)]) {
            return [del tfCrashActionNSMutableArray:self index:index type:TFCrashTypeNSMutableArrayGetSubscript];
        }
    }
    return nil;
}

-(void)tfsafe_addObject:(id)anObject{
    if (anObject) {
        [self tfsafe_addObject:anObject];
    }else{
        id del = [TFCrashSafeKit shareInstance];
        if ([del respondsToSelector:@selector(tfCrashActionNSMutableArray:addObject:type:)]) {
            [del tfCrashActionNSMutableArray:self addObject:anObject type:TFCrashTypeNSMutableArrayAdd];
        }
    }
}

- (void)tfsafe_insertObject:(id)anObject atIndex:(NSUInteger)index{
    if (anObject && index >= 0 && index <= self.count) {
        [self tfsafe_insertObject:anObject atIndex:index];
    }else{
        id del = [TFCrashSafeKit shareInstance];
        if ([del respondsToSelector:@selector(tfCrashActionNSMutableArray:insertObject:atIndex:type:)]) {
            [del tfCrashActionNSMutableArray:self insertObject:anObject atIndex:index type:TFCrashTypeNSMutableArrayInsert];
        }
    }
}

- (void)tfsafe_setObject:(id)anObject atIndexedSubscript:(NSUInteger)index{
    if (anObject && index >= 0 && index <= self.count) {
        [self tfsafe_setObject:anObject atIndexedSubscript:index];
    }else{
        id del = [TFCrashSafeKit shareInstance];
        if ([del respondsToSelector:@selector(tfCrashActionNSMutableArray:setObject:atIndexedSubscript:type:)]) {
            [del tfCrashActionNSMutableArray:self setObject:anObject atIndexedSubscript:index type:TFCrashTypeNSMutableArraySet];
        }
    }
}

- (void)tfsafe_removeObjectAtIndex:(NSUInteger)index {
    if (index >= 0 && index < self.count) {
        [self tfsafe_removeObjectAtIndex:index];
    }else{
        id del = [TFCrashSafeKit shareInstance];
        if ([del respondsToSelector:@selector(tfCrashActionNSMutableArray:removeObjectAtIndex:type:)]) {
            [del tfCrashActionNSMutableArray:self removeObjectAtIndex:index type:TFCrashTypeNSMutableArrayRemove];
        }
    }
}


@end
