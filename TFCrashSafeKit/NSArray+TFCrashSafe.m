//
//  NSArray+TFCrashSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSArray+TFCrashSafe.h"
#import <objc/runtime.h>
#import "TFCrashSafeKit.h"
#import "TFCrashSafeKit+CrashAction.h"
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
}


- (id)tfsafe_objectAtIndex0:(NSUInteger)index {
    id rValue = nil;
    if (index >= 0 && index < self.count) {
        rValue = [self tfsafe_objectAtIndex0:index];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSArray:index:type:)]) {
                rValue = [del tfCrashActionNSArray:self index:index type:TFCrashTypeNSArrayGet];
            }
        }else{
            @try {
                rValue = [self tfsafe_objectAtIndex0:index];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
    return rValue;
}


- (id)tfsafe_objectAtIndex1:(NSUInteger)index {
    id rValue = nil;
    if (index >= 0 && index < self.count) {
        rValue = [self tfsafe_objectAtIndex1:index];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSArray:index:type:)]) {
                rValue = [del tfCrashActionNSArray:self index:index type:TFCrashTypeNSArrayGet];
            }
        }else{
            @try {
                rValue = [self tfsafe_objectAtIndex1:index];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
    return rValue;
}


- (id)tfsafe_objectAtIndexIM:(NSUInteger)index {
    id rValue = nil;
    if (index >= 0 && index < self.count) {
        rValue = [self tfsafe_objectAtIndexIM:index];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSArray:index:type:)]) {
                rValue = [del tfCrashActionNSArray:self index:index type:TFCrashTypeNSArrayGet];
            }
        }else{
            @try {
                rValue = [self tfsafe_objectAtIndexIM:index];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
    return rValue;
}


- (id)tfsafe_objectAtIndexedSubscriptIM:(NSUInteger)index {
    id rValue = nil;
    if (index >= 0 && index < self.count) {
        rValue = [self tfsafe_objectAtIndexedSubscriptIM:index];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSArray:index:type:)]) {
                rValue = [del tfCrashActionNSArray:self index:index type:TFCrashTypeNSArrayGetSubscript];
            }
        }else{
            @try {
                rValue = [self tfsafe_objectAtIndexedSubscriptIM:index];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
    return rValue;
}


@end
