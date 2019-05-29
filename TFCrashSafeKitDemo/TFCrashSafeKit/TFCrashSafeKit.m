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
        _tfCrashSafeKit = [[TFCrashSafeKit alloc]init];
    });
    return _tfCrashSafeKit;
}


@end
