//
//  NSTimer+TFCrashSafe.h
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/22.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (TFCrashSafe)

+(void)useSafe_TFDeallocSafe;

@end

@interface TFTimerSafeBridge : NSObject

+(instancetype)bridgeWithTarget:(id)target sel:(SEL)sel;

@end



