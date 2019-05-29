//
//  TFCrashSafeKit+CrashAction.m
//  TFCrashSafeKitDemo
//
//  Created by zhutaofeng on 2019/5/29.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFCrashSafeKit+CrashAction.h"

@implementation TFCrashSafeKit (CrashAction)

+(id)tfCrashActionNSArray:(NSArray *)array index:(NSInteger)index type:(TFCrashType)type{
    TFCrashSafeKit *kit = [TFCrashSafeKit shareInstance];
    if (kit.delegate && [kit.delegate respondsToSelector:@selector(custemReportGet:index:type:)]) {
        NSString *report = [kit.delegate custemReportGet:array index:index type:type];
        if (report) {
            
            
        }
    }
    return nil;
}

+(id)tfCrashActionNSMutableArray:(NSMutableArray *)array index:(NSInteger)index type:(TFCrashType)type{
    TFCrashSafeKit *kit = [TFCrashSafeKit shareInstance];
    if (kit.delegate && [kit.delegate respondsToSelector:@selector(custemReportGet:index:type:)]) {
        NSString *report = [kit.delegate custemReportGet:array index:index type:type];
        if (report) {
            
            
        }
    }
    return nil;
}

+(void)tfCrashActionNSMutableArray:(NSMutableArray *)array
                         addObject:(id)anObject
                              type:(TFCrashType)type{
  
}
+(void)tfCrashActionNSMutableArray:(NSMutableArray *)array
                      insertObject:(id)anObject
                           atIndex:(NSUInteger)index
                              type:(TFCrashType)type{
    
}
+(void)tfCrashActionNSMutableArray:(NSMutableArray *)array
                         setObject:(id)anObject
                atIndexedSubscript:(NSUInteger)index
                              type:(TFCrashType)type{
    
}
+(void)tfCrashActionNSMutableArray:(NSMutableArray *)array
               removeObjectAtIndex:(NSUInteger)index
                              type:(TFCrashType)type{
    
}


/* 可变字典
 */
+(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic
                              setObject:(id)anObject
                                 forKey:(id<NSCopying>)aKey
                                   type:(TFCrashType)type{
    
}
+(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic
                              setObject:(id)anObject
                      forKeyedSubscript:(id < NSCopying >)aKey
                                   type:(TFCrashType)type{
    
}
+(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic
                          setDictionary:(NSDictionary *)otherDictionary
                                   type:(TFCrashType)type{
    
}

+(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic
               addEntriesFromDictionary:(NSDictionary *)otherDictionary
                                   type:(TFCrashType)type{
    
}
+(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic
                     removeObjectForKey:(id)aKey
                                   type:(TFCrashType)type{
    
}
+(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic
                   removeObjectsForKeys:(NSArray *)keyArray
                                   type:(TFCrashType)type{
    
}

/* 可变和不可变字符串
 */
+(void)tfCrashActionNSString:(NSString *)string substringFromIndex:(NSUInteger)from type:(TFCrashType)type{
    
}
+(void)tfCrashActionNSString:(NSString *)string substringToIndex:(NSUInteger)to type:(TFCrashType)type{
    
}
+(void)tfCrashActionNSString:(NSString *)string substringWithRange:(NSRange)range type:(TFCrashType)type{
    
}
+(void)tfCrashActionNSString:(NSString *)string characterAtIndex:(NSUInteger)index type:(TFCrashType)type{
    
}
+(void)tfCrashActionNSString:(NSString *)string substringWithRange9More:(NSRange)range type:(TFCrashType)type{
    
}
+(void)tfCrashActionNSString:(NSString *)string characterAtIndex9More:(NSUInteger)index type:(TFCrashType)type{
    
}


/* 通知
 */
+(void)tfCrashActionNSNotificationCenter:(NSNotificationCenter *)notificationCenter
                             addObserver:(id)observer
                                selector:(SEL)aSelector
                                    name:(NSNotificationName)aName
                                  object:(id)anObject
                                    type:(TFCrashType)type{
    
}

/* KVO
 */
+(void)tfCrashActionKVO:(NSObject *)obj
            addObserver:(NSObject *)observer
             forKeyPath:(NSString *)keyPath
                options:(NSKeyValueObservingOptions)options
                context:(void *)context
                   type:(TFCrashType)type{
    
}

+(void)tfCrashActionKVO:(NSObject *)obj
         removeObserver:(NSObject *)observer
             forKeyPath:(NSString *)keyPath
                context:(void *)context
                   type:(TFCrashType)type{
    
}

+(void)tfCrashActionKVO:(NSObject *)obj
         removeObserver:(NSObject *)observer
             forKeyPath:(NSString *)keyPath
                   type:(TFCrashType)type{
    
}

/* 调用空方法
 */
+(void)tfCrashActionUnrecognizedSelector:(id)obj selector:(SEL)aSelector type:(TFCrashType)type{
    
}


@end
