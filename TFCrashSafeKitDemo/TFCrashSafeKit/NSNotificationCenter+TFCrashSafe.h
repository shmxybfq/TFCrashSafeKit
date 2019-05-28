//
//  NSNotificationCenter+TFCrashSafe.h
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/22.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (TFCrashSafe)

@property(nonatomic,strong)NSMutableArray <NSString *>*notificationPool;
@property(nonatomic,strong)NSMutableArray <NSString *>*instanceAddressPool;

+(void)useSafe_NSNotificationCenter_TFCrashSafe;

@end

