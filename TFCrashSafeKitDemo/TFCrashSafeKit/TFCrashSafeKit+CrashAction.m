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


@end
