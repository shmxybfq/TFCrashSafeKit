//
//  TFCrashSafeKit.m
//  TFCrashSafeKitDemo
//
//  Created by zhutaofeng on 2019/5/29.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFCrashSafeKit.h"

#import "NSObject+TFKVOSafe.h"
#import "TFCrashSafeKitConst.h"
#import "NSArray+TFCrashSafe.h"
#import "NSTimer+TFCrashSafe.h"
#import "NSString+TFCrashSafe.h"
#import "NSDictionary+TFCrashSafe.h"
#import "NSMutableArray+TFCrashSafe.h"
#import "NSObject+UnrecognizedSelector.h"
#import "NSMutableDictionary+TFCrashSafe.h"
#import "NSNotificationCenter+TFCrashSafe.h"

@interface TFCrashSafeKit ()

@end

@implementation TFCrashSafeKit

static TFCrashSafeKit *_tfCrashSafeKit;
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tfCrashSafeKit = [[[self class] alloc]init];
    });
    return _tfCrashSafeKit;
}
//
///* 不可变数组
// */
//-(id)tfCrashActionNSArray:(NSArray *)array index:(NSInteger)index type:(TFCrashType)type;
//
///* 可变数组
// */
//-(id)tfCrashActionNSMutableArray:(NSMutableArray *)array index:(NSInteger)index type:(TFCrashType)type;
//
//-(void)tfCrashActionNSMutableArray:(NSMutableArray *)array addObject:(id)anObject type:(TFCrashType)type;
//-(void)tfCrashActionNSMutableArray:(NSMutableArray *)array insertObject:(id)anObject
//                           atIndex:(NSUInteger)index type:(TFCrashType)type;
//
//-(void)tfCrashActionNSMutableArray:(NSMutableArray *)array setObject:(id)anObject
//                atIndexedSubscript:(NSUInteger)index type:(TFCrashType)type;
//
//-(void)tfCrashActionNSMutableArray:(NSMutableArray *)array removeObjectAtIndex:(NSUInteger)index type:(TFCrashType)type;
///* 可变字典
// */
//-(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic setObject:(id)anObject
//                                 forKey:(id<NSCopying>)aKey type:(TFCrashType)type;
//-(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic setObject:(id)anObject
//                      forKeyedSubscript:(id < NSCopying >)aKey type:(TFCrashType)type;
//-(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic setDictionary:(NSDictionary *)otherDictionary type:(TFCrashType)type;
//
//-(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic addEntriesFromDictionary:(NSDictionary *)otherDictionary
//                                   type:(TFCrashType)type;
//-(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic removeObjectForKey:(id)aKey type:(TFCrashType)type;
//-(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic removeObjectsForKeys:(NSArray *)keyArray type:(TFCrashType)type;
//
///* 可变和不可变字符串
// */
//-(void)tfCrashActionNSString:(NSString *)string substringFromIndex:(NSUInteger)from type:(TFCrashType)type;
//-(void)tfCrashActionNSString:(NSString *)string substringToIndex:(NSUInteger)to type:(TFCrashType)type;
//-(void)tfCrashActionNSString:(NSString *)string substringWithRange:(NSRange)range type:(TFCrashType)type;
//-(void)tfCrashActionNSString:(NSString *)string characterAtIndex:(NSUInteger)index type:(TFCrashType)type;
//-(void)tfCrashActionNSString:(NSString *)string substringWithRange9More:(NSRange)range type:(TFCrashType)type;
//-(void)tfCrashActionNSString:(NSString *)string characterAtIndex9More:(NSUInteger)index type:(TFCrashType)type;
///* 通知
// */
//-(void)tfCrashActionNSNotificationCenter:(NSNotificationCenter *)notificationCenter addObserver:(id)observer selector:(SEL)aSelector name:(NSNotificationName)aName object:(id)anObject type:(TFCrashType)type;
///* KVO
// */
//-(void)tfCrashActionKVO:(NSObject *)obj addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context type:(TFCrashType)type;
//
//-(void)tfCrashActionKVO:(NSObject *)obj removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context type:(TFCrashType)type;
//
//-(void)tfCrashActionKVO:(NSObject *)obj removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath type:(TFCrashType)type;
//
///* 调用空方法
// */
//-(void)tfCrashActionUnrecognizedSelector:(id)obj selector:(SEL)aSelector type:(TFCrashType)type;


@end
