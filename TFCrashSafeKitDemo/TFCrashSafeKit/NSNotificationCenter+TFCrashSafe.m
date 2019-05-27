//
//  NSNotificationCenter+TFCrashSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/22.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSNotificationCenter+TFCrashSafe.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "TFCrashSafeKitConst.h"
#import "TFCrashSafeKitManager.h"
#import "NSObject+MethodExchange.h"

@implementation NSNotificationCenter (TFCrashSafe)


+(void)useSafe_NSNotificationCenter_TFCrashSafe{
    Class cls = [NSNotificationCenter class];
    [cls tf_instanceMethodExchange:@selector(addObserver:selector:name:object:)
                           toClass:[self class]
                             toSel:@selector(tfsafe_addObserver:selector:name:object:)];
}

tf_synthesize_category_property_retain(notificationPool, setNotificationPool);
static inline NSString *tf_getNotificationKey(id observed,SEL sel,NSString *name){
    NSString *p_observed = [NSString stringWithFormat:@"%p",observed];
    NSString *selString = NSStringFromSelector(sel);
    NSString *key = [NSString stringWithFormat:@"%@_%@_%@",p_observed,selString,name];
    return key;
}

-(void)tfsafe_addObserver:(id)observer selector:(SEL)aSelector name:(NSNotificationName)aName object:(id)anObject{
    if (observer && aSelector && aName) {
        NSString *key = tf_getNotificationKey(observer, aSelector, aName);
        if (![self.notificationPool containsObject:key]) {
            [self tfsafe_addObserver:observer selector:aSelector name:aName object:anObject];
            if (self.notificationPool == nil)self.notificationPool = [[NSMutableArray alloc]init];
            [self.notificationPool addObject:key];
        }
    }
}

-(void)do_dealloc{
    if ([[UIDevice currentDevice].systemVersion floatValue] <= 9.0) {
        NSArray *notificationPool = [NSNotificationCenter defaultCenter].notificationPool;
        if (notificationPool) {
            for (NSString *key in notificationPool) {
                NSString *p = [NSString stringWithFormat:@"%p",self];
                if ([key hasPrefix:p]) {
                    [[NSNotificationCenter defaultCenter]removeObserver:self];
                    break;
                }
            }
        }
    }
}

@end
