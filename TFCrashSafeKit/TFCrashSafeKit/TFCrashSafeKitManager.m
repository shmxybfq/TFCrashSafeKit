//
//  TFCrashSafeKitManager.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/23.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFCrashSafeKitManager.h"

@implementation TFCrashSafeKitManager

static TFCrashSafeKitManager *_tfCrashSafeKitManager;
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tfCrashSafeKitManager = [[TFCrashSafeKitManager alloc]init];
    });
    return _tfCrashSafeKitManager;
}



@end
