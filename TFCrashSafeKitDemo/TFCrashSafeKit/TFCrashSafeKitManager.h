//
//  TFCrashSafeKitManager.h
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/23.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <Foundation/Foundation.h>
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

@interface TFCrashSafeKitManager : NSObject

@property(nonatomic,assign)TFCrashSafeType type;
@property(nonatomic,assign)BOOL collectException;

+(instancetype)shareInstance;

@end


