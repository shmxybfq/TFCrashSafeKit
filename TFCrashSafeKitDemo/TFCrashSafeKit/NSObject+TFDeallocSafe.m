//
//  NSObject+TFDeallocSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/22.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSObject+TFDeallocSafe.h"
#import <objc/runtime.h>
#import "TFMethodExchange.h"
#import "TFCrashSafeKitConst.h"
#import "NSNotificationCenter+TFCrashSafe.h"
#import "NSObject+TFKVOSafe.h"
#import "TFCrashSafeKitManager.h"

@implementation NSObject (TFDeallocSafe)

+(void)useSafe_NSObject_TFDeallocSafe{
    
    SEL deallocOriginSel = NSSelectorFromString(@"dealloc");
    SEL deallocToSel = NSSelectorFromString(@"tfsafe_dealloc");
    [TFMethodExchange tf_instanceMethodExchange:[self class]
                                      originSel:deallocOriginSel
                                          toSel:deallocToSel];
}

-(void)tfsafe_dealloc{
    [self tfsafe_dealloc];
    [self do_dealloc_TFKVOSafe];
    [[NSNotificationCenter defaultCenter]do_dealloc];
    
}

@end
