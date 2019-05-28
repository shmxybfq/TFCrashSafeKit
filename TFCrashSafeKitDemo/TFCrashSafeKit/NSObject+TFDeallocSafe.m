//
//  NSObject+TFDeallocSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/22.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSObject+TFDeallocSafe.h"
#import <objc/runtime.h>
#import "TFCrashSafeKitConst.h"
#import "NSNotificationCenter+TFCrashSafe.h"
#import "NSObject+TFKVOSafe.h"
#import "NSObject+MethodExchange.h"

@implementation NSObject (TFDeallocSafe)

+(void)useSafe_NSObject_TFDeallocSafe{
    
    SEL deallocOriginSel = NSSelectorFromString(@"dealloc");
    SEL deallocToSel = NSSelectorFromString(@"tfsafe_dealloc");
  
    Class cls = [NSObject class];
    [cls tf_instanceMethodExchange:deallocOriginSel
                           toClass:[self class]
                             toSel:deallocToSel];
    
}

-(void)tfsafe_dealloc{
    [self tfsafe_dealloc];
    [NSObject do_dealloc_TFKVOSafe];
    [[NSNotificationCenter defaultCenter]do_dealloc];
    
}

@end
