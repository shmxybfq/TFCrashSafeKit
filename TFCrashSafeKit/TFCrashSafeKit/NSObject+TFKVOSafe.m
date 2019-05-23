//
//  NSObject+TFKVOSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/22.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSObject+TFKVOSafe.h"
#import <objc/runtime.h>
#import "TFMethodExchange.h"
#import "TFCrashSafeKitConst.h"

@implementation NSObject (TFKVOSafe)
@dynamic observedPool;

//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
//-(void)dealloc{
//
//}
//#pragma clang diagnostic pop

+(void)useSafe_NSObject_TFKVOSafe{
    
    SEL addOriginSel = NSSelectorFromString(@"addObserver:forKeyPath:options:context:");
    SEL addToSel = NSSelectorFromString(@"tfsafe_addObserver:forKeyPath:options:context:");
    [TFMethodExchange tf_instanceMethodExchange:[self class]
                                      originSel:addOriginSel
                                          toSel:addToSel];
    
    SEL removeOriginSel0 = NSSelectorFromString(@"removeObserver:forKeyPath:");
    SEL removeToSel0 = NSSelectorFromString(@"tfsafe_removeObserver:forKeyPath:");
    [TFMethodExchange tf_instanceMethodExchange:[self class]
                                      originSel:removeOriginSel0
                                          toSel:removeToSel0];
    
    SEL removeOriginSel1 = NSSelectorFromString(@"removeObserver:forKeyPath:context:");
    SEL removeToSel1 = NSSelectorFromString(@"tfsafe_removeObserver:forKeyPath:context:");
    [TFMethodExchange tf_instanceMethodExchange:[self class]
                                      originSel:removeOriginSel1
                                          toSel:removeToSel1];
    
}

tf_synthesize_category_property_retain(observedPool, setObservedPool);

-(void)tf_kvoRecord:(id)observed target:(id)target path:(NSString *)path{
    if (self.observedPool == nil)self.observedPool = [[NSMutableDictionary alloc]init];
    NSString *key = tf_getKvoKey(observed, target, path);
    if (![self.observedPool objectForKey:key]) {
        TFKVOSafeContainer *container = [[TFKVOSafeContainer alloc]init];
        container.observed = observed;
        container.target = target;
        container.path = path;
        [self.observedPool setObject:container forKey:key];
    }
}

-(BOOL)tf_kvoRecorded:(id)observed target:(id)target path:(NSString *)path{
    if (self.observedPool == nil)self.observedPool = [[NSMutableDictionary alloc]init];
    NSString *key = tf_getKvoKey(observed, target, path);
    return [self.observedPool objectForKey:key];
}

-(BOOL)tf_removeKvoRecorded:(id)observed target:(id)target path:(NSString *)path{
    if (self.observedPool == nil)self.observedPool = [[NSMutableDictionary alloc]init];
    NSString *key = tf_getKvoKey(observed, target, path);
    if ([self tf_kvoRecorded:observed target:target path:path]) {
        [self.observedPool removeObjectForKey:key];
        return YES;
    }
    return NO;
}

static inline NSString *tf_getKvoKey(id observed,id target,NSString *path){
    NSString *p_observed = [NSString stringWithFormat:@"%p",observed];
    NSString *p_target = [NSString stringWithFormat:@"%p",target];
    NSString *key = [NSString stringWithFormat:@"%@_%@_%@",p_observed,p_target,path];
    return key;
}


-(void)tfsafe_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    if (observer && keyPath) {
        BOOL added = [self tf_kvoRecorded:self target:observer path:keyPath];
        if (!added) {
            [self tfsafe_addObserver:observer forKeyPath:keyPath options:options context:context];
            [self tf_kvoRecord:self target:observer path:keyPath];
        }
    }
}

-(void)tfsafe_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath{
    if (observer && keyPath) {
        BOOL added = [self tf_kvoRecorded:self target:observer path:keyPath];
        if (added) {
            [self tfsafe_removeObserver:observer forKeyPath:keyPath];
            [self tf_removeKvoRecorded:self target:observer path:keyPath];
        }
    }
}

-(void)tfsafe_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context{
    if (observer && keyPath) {
        BOOL added = [self tf_kvoRecorded:self target:observer path:keyPath];
        if (added) {
            [self tfsafe_removeObserver:observer forKeyPath:keyPath];
            [self tf_removeKvoRecorded:self target:observer path:keyPath];
        }
    }
}

-(void)do_dealloc_TFKVOSafe{
    NSArray *observedPoolKeys = self.observedPool.allKeys;
    if (observedPoolKeys && observedPoolKeys.count > 0) {
        for (NSString *key in observedPoolKeys) {
            TFKVOSafeContainer *container = [self.observedPool objectForKey:key];
            [self removeObserver:container.target forKeyPath:container.path];
        }
    }
}

@end


@implementation TFKVOSafeContainer

@end
