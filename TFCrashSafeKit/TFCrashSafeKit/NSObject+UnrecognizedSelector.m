//
//  NSObject+UnrecognizedSelector.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSObject+UnrecognizedSelector.h"
#import "TFMethodExchange.h"
#import <objc/runtime.h>

@class TFUnrecognizedSelectorForwarding;
@implementation NSObject (UnrecognizedSelector)

+(void)useSafe_NSObject_UnrecognizedSelector{
    
    SEL forwardingOriginSel = NSSelectorFromString(@"forwardingTargetForSelector:");
    SEL forwardingToSel = NSSelectorFromString(@"tfsafe_forwardingTargetForSelector:");
    [TFMethodExchange tf_instanceMethodExchange:[self class]
                                      originSel:forwardingOriginSel
                                          toSel:forwardingToSel];
    
}


-(id)tfsafe_forwardingTargetForSelector:(SEL)aSelector{
    id target = [self tfsafe_forwardingTargetForSelector:aSelector];
    if (!target) {
        target = (id)[[TFUnrecognizedSelectorForwarding alloc]initWithSelector:aSelector];
    }
    return target;
}

@end


@implementation TFUnrecognizedSelectorForwarding

-(instancetype)initWithSelector:(SEL)aSelector{
    if (self = [super init]) {
        Method method = class_getInstanceMethod([self class], aSelector);
        if (!method) {
            BOOL added = class_addMethod([self class], aSelector, (IMP)forwardingImp,"v@:@");
            if (!added) {
                return nil;
            }
        }
    }
    return self;
}

void forwardingImp(id self, SEL _cmd){
    
}

@end
