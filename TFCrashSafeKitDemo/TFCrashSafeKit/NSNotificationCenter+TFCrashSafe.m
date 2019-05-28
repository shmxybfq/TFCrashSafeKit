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


tf_synthesize_category_property_retain(instanceAddressPool, setInstanceAddressPool);
-(void)tfsafe_addObserver:(id)observer selector:(SEL)aSelector name:(NSNotificationName)aName object:(id)anObject{
    NSLog(@"通知添加====:%@",aName);
    if (observer && aSelector && aName) {
        NSString *key = tf_getNotificationKey(observer, aSelector, aName);
        if (![self.notificationPool containsObject:key]) {
            NSLog(@"通知添加成功");
            [self tfsafe_addObserver:observer selector:aSelector name:aName object:anObject];
            
            //添加完整记录
            if (self.notificationPool == nil)self.notificationPool = [[NSMutableArray alloc]init];
            [self.notificationPool addObject:key];
            
            //添加有通知的对象的记录,为了提高效率
            if (self.instanceAddressPool == nil) {
                self.instanceAddressPool = [[NSMutableArray alloc]init];
            }
            [self.instanceAddressPool addObject:[NSString stringWithFormat:@"%p",observer]];
        }else{
            NSLog(@"通知添加重复");
        }
    }else{
        NSLog(@"通知添加失败");
    }
}

-(void)do_dealloc{
    if ([[UIDevice currentDevice].systemVersion floatValue] <= 9.0) {
        NSString *address = [NSString stringWithFormat:@"%p",self];
        if ([self.instanceAddressPool containsObject:address]) {
            [self.instanceAddressPool removeObject:address];
            [[NSNotificationCenter defaultCenter]removeObserver:self];
        }
    }
}

@end
