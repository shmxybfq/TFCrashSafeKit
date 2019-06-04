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

@property(nonatomic,  weak)id<TFCrashSafeKitDelegate>crashDelegate;

@end

