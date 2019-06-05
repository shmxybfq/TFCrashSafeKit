//
//  NSMutableDictionary+TFCrashSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSMutableDictionary+TFCrashSafe.h"
#import <objc/runtime.h>
#import "TFCrashSafeKit.h"
#import "NSObject+MethodExchange.h"
#import "TFCrashSafeKit+CrashAction.h"

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
    if (anObject && aKey) {
        [self tfsafe_setObject:anObject forKey:aKey];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSMutableDictionary:setObject:forKey:type:)]) {
                [del tfCrashActionNSMutableDictionary:self setObject:anObject forKey:aKey type:TFCrashTypeNSMutableDictionarySet];
            }
        }else{
            @try {
                [self tfsafe_setObject:anObject forKey:aKey];
            } @catch (NSException *exception) {
    
            } @finally {}
        }
    }
}

- (void)tfsafe_setObject:(id)anObject forKeyedSubscript:(id < NSCopying >)aKey{
    if (anObject && aKey) {
        [self tfsafe_setObject:anObject forKeyedSubscript:aKey];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSMutableDictionary:setObject:forKeyedSubscript:type:)]) {
                [del tfCrashActionNSMutableDictionary:self setObject:anObject forKeyedSubscript:aKey type:TFCrashTypeNSMutableDictionarySetSubscript];
            }
        }else{
            @try {
                [self tfsafe_setObject:anObject forKeyedSubscript:aKey];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
}

- (void)tfsafe_setDictionary:(NSDictionary *)otherDictionary{
    if (otherDictionary && [otherDictionary isKindOfClass:[NSDictionary class]]) {
        [self tfsafe_setDictionary:otherDictionary];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSMutableDictionary:setDictionary:type:)]) {
                [del tfCrashActionNSMutableDictionary:self setDictionary:otherDictionary type:TFCrashTypeNSMutableDictionarySetDictionary];
            }
        }else{
            @try {
                [self tfsafe_setDictionary:otherDictionary];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
}

-(void)tfsafe_addEntriesFromDictionary:(NSDictionary *)otherDictionary{
    if (otherDictionary && [otherDictionary isKindOfClass:[NSDictionary class]]) {
        [self tfsafe_addEntriesFromDictionary:otherDictionary];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSMutableDictionary:addEntriesFromDictionary:type:)]) {
                [del tfCrashActionNSMutableDictionary:self addEntriesFromDictionary:otherDictionary type:TFCrashTypeNSMutableDictionaryAddDictionary];
            }
        }else{
            @try {
                [self tfsafe_setDictionary:otherDictionary];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
}


-(void)tfsafe_removeObjectForKey:(id)aKey{
    if (aKey) {
        [self tfsafe_removeObjectForKey:aKey];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSMutableDictionary:removeObjectForKey:type:)]) {
                [del tfCrashActionNSMutableDictionary:self removeObjectForKey:aKey type:TFCrashTypeNSMutableDictionaryRemove];
            }
        }else{
            @try {
                [self tfsafe_removeObjectForKey:aKey];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
}

-(void)tfsafe_removeObjectsForKeys:(NSArray *)keyArray{
    if (keyArray && [keyArray isKindOfClass:[NSArray class]]) {
        [self tfsafe_removeObjectsForKeys:keyArray];
    }else{
        if ([TFCrashSafeKit shareInstance].reportType == TFReportTypeCustem) {
            id del = [TFCrashSafeKit shareInstance];
            if ([del respondsToSelector:@selector(tfCrashActionNSMutableDictionary:removeObjectsForKeys:type:)]) {
                [del tfCrashActionNSMutableDictionary:self removeObjectsForKeys:keyArray type:TFCrashTypeNSMutableDictionaryRemoveForKeys];
            }
        }else{
            @try {
                [self tfsafe_removeObjectsForKeys:keyArray];
            } @catch (NSException *exception) {
                
            } @finally {}
        }
    }
}


@end
