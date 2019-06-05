//
//  NSObject+TFKVOSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/22.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSObject+TFKVOSafe.h"
#import <objc/runtime.h>
#import "TFCrashSafeKit.h"
#import "TFCrashSafeKitConst.h"
#import "NSObject+MethodExchange.h"
#import "TFCrashSafeKit+CrashAction.h"

@implementation NSObject (TFKVOSafe)
@dynamic observedPool;

//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
//-(void)dealloc{
//
//}
//#pragma clang diagnostic pop

+(void)useSafe_NSObject_TFKVOSafe{
    
    Class cls = [NSObject class];
    
    SEL deallocOriginSel = NSSelectorFromString(@"dealloc");
    [cls tf_instanceMethodExchange:deallocOriginSel
                           toClass:[self class]
                             toSel:@selector(tfsafe_deallocKvo)];
    
    [cls tf_instanceMethodExchange:@selector(addObserver:forKeyPath:options:context:)
                           toClass:[self class]
                             toSel:@selector(tfsafe_addObserver:forKeyPath:options:context:)];
    
    [cls tf_instanceMethodExchange:@selector(removeObserver:forKeyPath:)
                           toClass:[self class]
                             toSel:@selector(tfsafe_removeObserver:forKeyPath:)];
    
    [cls tf_instanceMethodExchange:@selector(removeObserver:forKeyPath:context:)
                           toClass:[self class]
                             toSel:@selector(tfsafe_removeObserver:forKeyPath:context:)];
}

-(void)tfsafe_deallocKvo{
    if (self.observedPool) {
        NSArray *observedPoolKeys = self.observedPool.allKeys;
        if (observedPoolKeys && observedPoolKeys.count > 0) {
            for (NSString *key in observedPoolKeys) {
                TFKVOSafeContainer *container = [self.observedPool objectForKey:key];
                [self removeObserver:container.target forKeyPath:container.path];
            }
        }
    }
    [self tfsafe_deallocKvo];
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
    if (self.observedPool == nil) return NO;
    NSString *key = tf_getKvoKey(observed, target, path);
    if ([self.observedPool objectForKey:key]) {
        return YES;
    }
    return NO;
}

-(BOOL)tf_removeKvoRecorded:(id)observed target:(id)target path:(NSString *)path{
    if (self.observedPool == nil) return NO;
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
        }else{
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionKVO:addObserver:forKeyPath:options:context:type:)]) {
                [del tfCrashActionKVO:self addObserver:observer forKeyPath:keyPath options:options context:context type:TFCrashTypeKVOAddRepeat];
            }
        }
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionKVO:addObserver:forKeyPath:options:context:type:)]) {
                [del tfCrashActionKVO:self addObserver:observer forKeyPath:keyPath options:options context:context type:TFCrashTypeKVOAddFail];
            }
        }else{
            @try {
                [self tfsafe_addObserver:observer forKeyPath:keyPath options:options context:context];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
}


-(void)tfsafe_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath{
    if (observer && keyPath) {
        BOOL added = [self tf_kvoRecorded:self target:observer path:keyPath];
        if (added) {
            [self tfsafe_removeObserver:observer forKeyPath:keyPath];
            [self tf_removeKvoRecorded:self target:observer path:keyPath];
        }else{
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionKVO:removeObserver:forKeyPath:type:)]) {
                [del tfCrashActionKVO:self removeObserver:observer forKeyPath:keyPath type:TFCrashTypeKVORemoveMore];
            }
        }
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionKVO:removeObserver:forKeyPath:type:)]) {
                [del tfCrashActionKVO:self removeObserver:observer forKeyPath:keyPath type:TFCrashTypeKVORemoveFail];
            }
        }else{
            @try {
                [self tfsafe_removeObserver:observer forKeyPath:keyPath];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
}

-(void)tfsafe_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context{
    if (observer && keyPath) {
        BOOL added = [self tf_kvoRecorded:self target:observer path:keyPath];
        if (added) {
            [self tfsafe_removeObserver:observer forKeyPath:keyPath];
            [self tf_removeKvoRecorded:self target:observer path:keyPath];
        }else{
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionKVO:removeObserver:forKeyPath:context:type:)]) {
                [del tfCrashActionKVO:self removeObserver:observer forKeyPath:keyPath context:context type:TFCrashTypeKVORemoveMore];
            }
        }
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionKVO:removeObserver:forKeyPath:context:type:)]) {
                [del tfCrashActionKVO:self removeObserver:observer forKeyPath:keyPath context:context type:TFCrashTypeKVORemoveFail];
            }
        }else{
            @try {
                [self tfsafe_removeObserver:observer forKeyPath:keyPath];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
}


@end


@implementation TFKVOSafeContainer

@end
