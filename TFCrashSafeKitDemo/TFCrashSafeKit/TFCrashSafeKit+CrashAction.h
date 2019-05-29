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

+(id)tfCrashActionNSArray:(NSArray *)array index:(NSInteger)index type:(TFCrashType)type;


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


@end

