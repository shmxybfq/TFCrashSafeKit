//
//  TFCrashSafeKit+CrashAction.h
//  TFCrashSafeKitDemo
//
//  Created by zhutaofeng on 2019/5/29.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFCrashSafeKit.h"
#import "TFCrashSafeKitConst.h"
@interface TFCrashSafeKit (CrashAction)

/* 不可变数组
 */
+(id)tfCrashActionNSArray:(NSArray *)array index:(NSInteger)index type:(TFCrashType)type;



/* 可变数组
 */
+(id)tfCrashActionNSMutableArray:(NSMutableArray *)array index:(NSInteger)index type:(TFCrashType)type;

+(void)tfCrashActionNSMutableArray:(NSMutableArray *)array
                         addObject:(id)anObject
                              type:(TFCrashType)type;
+(void)tfCrashActionNSMutableArray:(NSMutableArray *)array
                      insertObject:(id)anObject
                           atIndex:(NSUInteger)index
                              type:(TFCrashType)type;
+(void)tfCrashActionNSMutableArray:(NSMutableArray *)array
                         setObject:(id)anObject
                atIndexedSubscript:(NSUInteger)index
                              type:(TFCrashType)type;
+(void)tfCrashActionNSMutableArray:(NSMutableArray *)array
               removeObjectAtIndex:(NSUInteger)index
                              type:(TFCrashType)type;

/* 可变字典
 */
+(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic
                              setObject:(id)anObject
                                 forKey:(id<NSCopying>)aKey
                                   type:(TFCrashType)type;
+(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic
                              setObject:(id)anObject
                      forKeyedSubscript:(id < NSCopying >)aKey
                                   type:(TFCrashType)type;
+(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic
                          setDictionary:(NSDictionary *)otherDictionary
                                   type:(TFCrashType)type;

+(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic
               addEntriesFromDictionary:(NSDictionary *)otherDictionary
                                   type:(TFCrashType)type;
+(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic
                     removeObjectForKey:(id)aKey
                                   type:(TFCrashType)type;
+(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic
                   removeObjectsForKeys:(NSArray *)keyArray
                                   type:(TFCrashType)type;


/* 通知
 */
+(void)tfCrashActionNSNotificationCenter:(NSNotificationCenter *)notificationCenter
                             addObserver:(id)observer
                                selector:(SEL)aSelector
                                    name:(NSNotificationName)aName
                                  object:(id)anObject
                                    type:(TFCrashType)type;

/* KVO
 */
+(void)tfCrashActionKVO:(NSObject *)obj
            addObserver:(NSObject *)observer
             forKeyPath:(NSString *)keyPath
                options:(NSKeyValueObservingOptions)options
                context:(void *)context
                   type:(TFCrashType)type;

+(void)tfCrashActionKVO:(NSObject *)obj
         removeObserver:(NSObject *)observer
             forKeyPath:(NSString *)keyPath
                context:(void *)context
                   type:(TFCrashType)type;

+(void)tfCrashActionKVO:(NSObject *)obj
         removeObserver:(NSObject *)observer
             forKeyPath:(NSString *)keyPath
                   type:(TFCrashType)type;

/* 调用空方法
 */
+(void)tfCrashActionUnrecognizedSelector:(id)obj selector:(SEL)aSelector type:(TFCrashType)type;


@end

