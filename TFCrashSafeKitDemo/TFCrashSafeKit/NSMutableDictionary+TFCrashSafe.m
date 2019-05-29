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
        [TFCrashSafeKit tfCrashActionNSMutableDictionary:self
                                               setObject:anObject
                                                  forKey:aKey
                                                    type:TFCrashTypeNSMutableDictionarySet];
    }
}

- (void)tfsafe_setObject:(id)anObject forKeyedSubscript:(id < NSCopying >)aKey{
    if (anObject && aKey) {
        [self tfsafe_setObject:anObject forKeyedSubscript:aKey];
    }else{
        [TFCrashSafeKit tfCrashActionNSMutableDictionary:self
                                               setObject:anObject
                                       forKeyedSubscript:aKey
                                                    type:TFCrashTypeNSMutableDictionarySetSubscript];
    }
}

- (void)tfsafe_setDictionary:(NSDictionary *)otherDictionary{
    if (otherDictionary && [otherDictionary isKindOfClass:[NSDictionary class]]) {
        [self tfsafe_setDictionary:otherDictionary];
    }else{
        [TFCrashSafeKit tfCrashActionNSMutableDictionary:self
                                           setDictionary:otherDictionary
                                                    type:TFCrashTypeNSMutableDictionarySetDictionary];
    }
}

-(void)tfsafe_addEntriesFromDictionary:(NSDictionary *)otherDictionary{
    if (otherDictionary && [otherDictionary isKindOfClass:[NSDictionary class]]) {
        [self tfsafe_addEntriesFromDictionary:otherDictionary];
    }else{
        [TFCrashSafeKit tfCrashActionNSMutableDictionary:self
                                addEntriesFromDictionary:otherDictionary
                                                    type:TFCrashTypeNSMutableDictionaryAddDictionary];
    }
}


-(void)tfsafe_removeObjectForKey:(id)aKey{
    if (aKey) {
        [self tfsafe_removeObjectForKey:aKey];
    }else{
        [TFCrashSafeKit tfCrashActionNSMutableDictionary:self
                                      removeObjectForKey:aKey
                                                    type:TFCrashTypeNSMutableDictionaryRemove];
    }
}

-(void)tfsafe_removeObjectsForKeys:(NSArray *)keyArray{
    if (keyArray && [keyArray isKindOfClass:[NSArray class]]) {
        [self tfsafe_removeObjectsForKeys:keyArray];
    }else{
        [TFCrashSafeKit tfCrashActionNSMutableDictionary:self
                                    removeObjectsForKeys:keyArray
                                                    type:TFCrashTypeNSMutableDictionaryRemoveForKeys];
    }
}


@end
