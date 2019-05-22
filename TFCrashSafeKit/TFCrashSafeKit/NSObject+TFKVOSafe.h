//
//  NSObject+TFKVOSafe.h
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/22.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TFKVOSafeContainer;
@interface NSObject (TFKVOSafe)

@property(nonatomic,strong)NSMutableDictionary <NSString *,TFKVOSafeContainer *>*observedPool;
+(void)useSafe_TFKVOSafe;
-(void)do_dealloc_TFKVOSafe;

@end

@interface TFKVOSafeContainer : NSObject

@property(nonatomic,  weak)id observed;
@property(nonatomic,  weak)id target;
@property(nonatomic,  copy)NSString *path;

@end

