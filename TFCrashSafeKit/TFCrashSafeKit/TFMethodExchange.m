//
//  TFMethodExchange.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFMethodExchange.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <Foundation/Foundation.h>
@implementation TFMethodExchange

+(BOOL)tf_instanceMethodExchange:(Class)cls originSel:(SEL)originSel toSel:(SEL)toSel{
    tf_exchangeLock();
    if (tf_methodHasExchanged(cls, originSel) == NO) {
        Method originMethod = class_getInstanceMethod(cls, originSel);
        Method toMethod = class_getInstanceMethod(cls, toSel);
        if (originMethod && toMethod){
            method_exchangeImplementations(originMethod, toMethod);
            tf_methodExchangeRecord(cls, originSel);
        }
    }
    tf_exchangeUnlock();
    return YES;
}

+(BOOL)tf_classMethodExchange:(Class)cls originSel:(SEL)originSel toSel:(SEL)toSel{
    tf_exchangeLock();
    if (tf_methodHasExchanged(cls, originSel) == NO) {
        Method originMethod = class_getClassMethod(cls, originSel);
        Method toMethod = class_getClassMethod(cls, toSel);
        if (originMethod && toMethod){
            method_exchangeImplementations(originMethod, toMethod);
            tf_methodExchangeRecord(cls, originSel);
        }
    }
    tf_exchangeUnlock();
    return YES;
}



static NSMutableDictionary *_methodExchangeRecordPool = nil;
static inline void tf_methodExchangeRecord(Class cls,SEL originSel){
    if (_methodExchangeRecordPool == nil) {
        _methodExchangeRecordPool = [[NSMutableDictionary alloc]init];
    }
    if (tf_methodHasExchanged(cls, originSel)) {
        [_methodExchangeRecordPool setObject:NSStringFromSelector(originSel) forKey:NSStringFromClass(cls)];
    }
}
static inline BOOL tf_methodHasExchanged(Class cls,SEL originSel){
    if (_methodExchangeRecordPool) {
        return [_methodExchangeRecordPool objectForKey:cls];
    }
    return NO;
}

static NSLock *_tf_exchangeLock = nil;
static inline void tf_exchangeLock(){
    if (_tf_exchangeLock == nil) {
        _tf_exchangeLock = [[NSLock alloc]init];
    }
    [_tf_exchangeLock lock];
}
static inline void tf_exchangeUnlock(){
    if (_tf_exchangeLock == nil) {
        _tf_exchangeLock = [[NSLock alloc]init];
    }
    [_tf_exchangeLock unlock];
}
@end
