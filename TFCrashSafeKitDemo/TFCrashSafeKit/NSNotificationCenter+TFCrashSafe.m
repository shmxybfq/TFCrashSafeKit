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
#import "TFCrashSafeKit.h"
#import "NSObject+MethodExchange.h"
#import "TFCrashSafeKit+CrashAction.h"

@implementation NSNotificationCenter (TFCrashSafe)


+(void)useSafe_NSNotificationCenter_TFCrashSafe{
    Class cls = [NSNotificationCenter class];
    
    SEL deallocOriginSel = NSSelectorFromString(@"dealloc");
    SEL deallocToSel = NSSelectorFromString(@"tfsafe_deallocNotificationCenter");
    Class clsObj = [NSObject class];
    [clsObj tf_instanceMethodExchange:deallocOriginSel
                           toClass:[self class]
                             toSel:deallocToSel];
    
    [cls tf_instanceMethodExchange:@selector(addObserver:selector:name:object:)
                           toClass:[self class]
                             toSel:@selector(tfsafe_addObserver:selector:name:object:)];
}

-(void)tfsafe_deallocNotificationCenter{
    if ([[UIDevice currentDevice].systemVersion floatValue] <= 9.0) {
        NSString *address = [NSString stringWithFormat:@"%p",self];
        if ([self.instanceAddressPool containsObject:address]) {
            [self.instanceAddressPool removeObject:address];
            [[NSNotificationCenter defaultCenter]removeObserver:self];
        }
    }
    [self tfsafe_deallocNotificationCenter];
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
    if (observer && aSelector && aName) {
        NSString *key = tf_getNotificationKey(observer, aSelector, aName);
        if (![self.notificationPool containsObject:key]) {
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
            [TFCrashSafeKit tfCrashActionNSNotificationCenter:self
                                                  addObserver:observer
                                                     selector:aSelector
                                                         name:aName
                                                       object:anObject
                                                         type:TFCrashTypeNSNotificationCenterAddRepeat];
        }
    }else{
        [TFCrashSafeKit tfCrashActionNSNotificationCenter:self
                                              addObserver:observer
                                                 selector:aSelector
                                                     name:aName
                                                   object:anObject
                                                     type:TFCrashTypeNSNotificationCenterAddFail];
        
    }
}
@end
