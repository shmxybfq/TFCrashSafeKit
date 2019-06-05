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
#import "TFCrashSafeKit+CrashAction.h"
#import "UIView+TFUICrashSafe.h"
@interface TFCrashSafeKit ()

@property(nonatomic,assign)TFProtectType protectType;

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

+(void)setReportType:(TFReportType)type{
    [TFCrashSafeKit shareInstance].reportType = type;
}

+(void)beginProtect:(TFProtectType)type{
    [TFCrashSafeKit shareInstance].protectType = type;
    
    if (type == TFCrashSafeTypeNone) {return;}
    if (type == TFCrashSafeTypeAll) {
        type = type | TFCrashSafeTypeKvo;
        type = type | TFCrashSafeTypeTimer;
        type = type | TFCrashSafeTypeUIThread;
        type = type | TFCrashSafeTypeContainer;
        type = type | TFCrashSafeTypeNotification;
        type = type | TFCrashSafeTypeUnrecognizedSelector;
    }
    
    if ((type & TFCrashSafeTypeKvo) == TFCrashSafeTypeKvo)
        [NSObject useSafe_NSObject_TFKVOSafe];
    if ((type & TFCrashSafeTypeTimer) == TFCrashSafeTypeTimer)
        [NSTimer useSafe_NSTimer_TFCrashSafe];
    if ((type & TFCrashSafeTypeUIThread) == TFCrashSafeTypeUIThread)
        [UIView useSafe_UIView_TFUICrashSafe];
    if ((type & TFCrashSafeTypeContainer) == TFCrashSafeTypeContainer){
        [NSArray useSafe_NSArray_TFCrashSafe];
        [NSMutableArray useSafe_NSMutableArray_TFCrashSafe];
        [NSDictionary useSafe_NSDictionary_TFCrashSafe];
        [NSMutableDictionary useSafe_NSMutableDictionary_TFCrashSafe];
    }
    if ((type & TFCrashSafeTypeNotification) == TFCrashSafeTypeNotification)
        [NSNotificationCenter useSafe_NSNotificationCenter_TFCrashSafe];
    if ((type & TFCrashSafeTypeUnrecognizedSelector) == TFCrashSafeTypeUnrecognizedSelector)
        [NSObject useSafe_NSObject_UnrecognizedSelector];

}


@end
