//
//  TFCrashSafeKit+CrashAction.m
//  TFCrashSafeKitDemo
//
//  Created by zhutaofeng on 2019/5/29.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFCrashSafeKit+CrashAction.h"

@implementation TFCrashSafeKit (CrashAction)
//tf_synthesize_category_property_assign(crashDelegate, setCrashDelegate);

/* 不可变数组
 */
-(id)tfCrashActionNSArray:(NSArray *)array index:(NSInteger)index type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tfCrashActionNSArray:array index:index type:type];
    }
    return nil;
}

/* 可变数组
 */
-(id)tfCrashActionNSMutableArray:(NSMutableArray *)array index:(NSInteger)index type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tfCrashActionNSMutableArray:array index:index type:type];
    }
    return nil;
}

-(void)tfCrashActionNSMutableArray:(NSMutableArray *)array addObject:(id)anObject type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tfCrashActionNSMutableArray:array addObject:anObject type:type];
    }
}
-(void)tfCrashActionNSMutableArray:(NSMutableArray *)array insertObject:(id)anObject
                           atIndex:(NSUInteger)index type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tfCrashActionNSMutableArray:array insertObject:anObject atIndex:index type:type];
    }
}

-(void)tfCrashActionNSMutableArray:(NSMutableArray *)array setObject:(id)anObject
                atIndexedSubscript:(NSUInteger)index type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tfCrashActionNSMutableArray:array setObject:anObject atIndexedSubscript:index type:type];
    }
}

-(void)tfCrashActionNSMutableArray:(NSMutableArray *)array removeObjectAtIndex:(NSUInteger)index type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tfCrashActionNSMutableArray:array removeObjectAtIndex:index type:type];
    }
}
/* 可变字典
 */
-(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic setObject:(id)anObject
                                 forKey:(id<NSCopying>)aKey type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tfCrashActionNSMutableDictionary:dic setObject:anObject forKey:aKey type:type];
    }
}
-(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic setObject:(id)anObject
                      forKeyedSubscript:(id < NSCopying >)aKey type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tfCrashActionNSMutableDictionary:dic setObject:anObject forKeyedSubscript:aKey type:type];
    }
}
-(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic setDictionary:(NSDictionary *)otherDictionary type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tfCrashActionNSMutableDictionary:dic setDictionary:otherDictionary type:type];
    }
}

-(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic addEntriesFromDictionary:(NSDictionary *)otherDictionary
                                   type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tfCrashActionNSMutableDictionary:dic addEntriesFromDictionary:otherDictionary type:type];
    }
}
-(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic removeObjectForKey:(id)aKey type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        
    }
}
-(void)tfCrashActionNSMutableDictionary:(NSMutableDictionary *)dic removeObjectsForKeys:(NSArray *)keyArray type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tfCrashActionNSMutableDictionary:dic removeObjectsForKeys:keyArray type:type];
    }
}

/* 可变和不可变字符串
 */
-(NSString *)tfCrashActionNSString:(NSString *)string substringFromIndex:(NSUInteger)from type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tfCrashActionNSString:string substringFromIndex:from type:type];
    }
    return nil;
}
-(NSString *)tfCrashActionNSString:(NSString *)string substringToIndex:(NSUInteger)to type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tfCrashActionNSString:string substringToIndex:to type:type];
    }
    return nil;
}
-(NSString *)tfCrashActionNSString:(NSString *)string substringWithRange:(NSRange)range type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tfCrashActionNSString:string substringWithRange:range type:type];
    }
    return nil;
}
-(unichar)tfCrashActionNSString:(NSString *)string characterAtIndex:(NSUInteger)index type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tfCrashActionNSString:string characterAtIndex:index type:type];
    }
    return 0;
}
-(NSString *)tfCrashActionNSString:(NSString *)string substringWithRange9More:(NSRange)range type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tfCrashActionNSString:string substringWithRange9More:range type:type];
    }
    return nil;
}
-(unichar)tfCrashActionNSString:(NSString *)string characterAtIndex9More:(NSUInteger)index type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tfCrashActionNSString:string characterAtIndex9More:index type:type];
    }
    return 0;
}
/* 通知
 */
-(void)tfCrashActionNSNotificationCenter:(NSNotificationCenter *)notificationCenter addObserver:(id)observer selector:(SEL)aSelector name:(NSNotificationName)aName object:(id)anObject type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        
    }
}
/* KVO
 */
-(void)tfCrashActionKVO:(NSObject *)obj addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        
    }
}

-(void)tfCrashActionKVO:(NSObject *)obj removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        
    }
}

-(void)tfCrashActionKVO:(NSObject *)obj removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        
    }
}

/* 调用空方法
 */
-(id)tfCrashActionUnrecognizedSelector:(id)obj selector:(SEL)aSelector type:(TFCrashType)type{
    if ([self.delegate respondsToSelector:_cmd]) {
        
    }
    return nil;
}



@end
