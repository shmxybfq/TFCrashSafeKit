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

+(void)useSafe_NSNotificationCenter_TFCrashSafe;
-(void)do_dealloc;

@end
