//
//  NSObject+MethodExchange.m
//  TFCrashSafeKitDemo
//
//  Created by zhutaofeng on 2019/5/24.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSObject+MethodExchange.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

@implementation NSObject (MethodExchange)

+(BOOL)tf_instanceMethodExchange:(SEL)originSel toClass:(Class)toClass  toSel:(SEL)toSel{
//    tf_exchangeLock();
    //    if (tf_methodHasExchanged(cls, originSel) == NO) {
    Method originMethod = class_getInstanceMethod([self class], originSel);
    Method toMethod = class_getInstanceMethod(toClass, toSel);
    if (originMethod && toMethod) {
        method_exchangeImplementations(originMethod, toMethod);
        NSLog(@"交换成功:\n%@:\n%@:\n%@:\n%@",
              NSStringFromClass([self class]),
              NSStringFromSelector(originSel),
              NSStringFromClass(toClass),
              NSStringFromSelector(toSel));
    }else{
        NSLog(@"交换失败:%@:%@:%@:%@",
              NSStringFromClass([self class]),
              NSStringFromSelector(originSel),
              NSStringFromClass(toClass),
              NSStringFromSelector(toSel));
    }
    
    return YES;
    
    IMP toImp = method_getImplementation(toMethod);
    const char *toTypeEncoding = method_getTypeEncoding(toMethod);
    BOOL addMethod = class_addMethod([self class],originSel,toImp,toTypeEncoding);
    
    if (addMethod) {
        //            IMP originImp = method_getImplementation(originMethod);
        //            const char *originTypeEncoding = method_getTypeEncoding(originMethod);
        //            class_replaceMethod([self class],toSel,originImp,originTypeEncoding);
        //            tf_methodExchangeRecord(cls, originSel);
    }else{
        if (originMethod && toMethod){
            method_exchangeImplementations(originMethod, toMethod);
            //                tf_methodExchangeRecord(cls, originSel);
        }
    }
    //    }
//    tf_exchangeUnlock();
    return YES;
}

+(BOOL)tf_classMethodExchange:(Class)cls originSel:(SEL)originSel toSel:(SEL)toSel{
    tf_exchangeLock();
    if (tf_methodHasExchanged(cls, originSel) == NO) {
        Method originMethod = class_getClassMethod(cls, originSel);
        Method toMethod = class_getClassMethod(cls, toSel);
        
        Class metaClass = objc_getMetaClass(NSStringFromClass(cls).UTF8String);
        IMP toImp = method_getImplementation(toMethod);
        const char *toTypeEncoding = method_getTypeEncoding(toMethod);
        BOOL addMethod = class_addMethod(metaClass,originSel,toImp,toTypeEncoding);
        if (addMethod) {
            IMP originImp = method_getImplementation(originMethod);
            const char *originTypeEncoding = method_getTypeEncoding(originMethod);
            class_replaceMethod(cls,toSel,originImp,originTypeEncoding);
            tf_methodExchangeRecord(cls, originSel);
        }else{
            if (originMethod && toMethod){
                method_exchangeImplementations(originMethod, toMethod);
                tf_methodExchangeRecord(cls, originSel);
            }
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
        if ([_methodExchangeRecordPool objectForKey:cls]) {
            return YES;
        }
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
