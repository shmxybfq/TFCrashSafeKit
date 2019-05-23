//
//  TFCrashSafeKitManager.h
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/23.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+TFCrashSafe.h"
#import "NSDictionary+TFCrashSafe.h"
#import "NSMutableArray+TFCrashSafe.h"
#import "NSMutableDictionary+TFCrashSafe.h"
#import "NSNotificationCenter+TFCrashSafe.h"
#import "NSObject+TFDeallocSafe.h"
#import "NSObject+TFKVOSafe.h"
#import "NSObject+UnrecognizedSelector.h"
#import "NSString+TFCrashSafe.h"
#import "NSTimer+TFCrashSafe.h"


@interface TFCrashSafeKitManager : NSObject

@property(nonatomic,assign)BOOL collectException;

+(instancetype)shareInstance;

@end


