//
//  NSTimer+TFCrashSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/22.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSTimer+TFCrashSafe.h"
#import <objc/runtime.h>
#import "TFMethodExchange.h"
#import "TFCrashSafeKitConst.h"

@implementation NSTimer (TFCrashSafe)

+(void)useSafe_TFDeallocSafe{
    
    SEL timerOriginSel = NSSelectorFromString(@"timerWithTimeInterval:target:selector:userInfo:repeats:");
    SEL timerToSel = NSSelectorFromString(@"tfsafe_timerWithTimeInterval:target:selector:userInfo:repeats:");
    [TFMethodExchange tf_classMethodExchange:[self class]
                                   originSel:timerOriginSel
                                       toSel:timerToSel];
    
    
    SEL scheduledOriginSel = NSSelectorFromString(@"scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:");
    SEL scheduledToSel = NSSelectorFromString(@"tfsafe_scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:");
    [TFMethodExchange tf_classMethodExchange:[self class]
                                   originSel:scheduledOriginSel
                                       toSel:scheduledToSel];
}

+ (NSTimer *)tfsafe_timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo{
    if (aTarget && aSelector) {
        TFTimerSafeBridge *bridge = [TFTimerSafeBridge bridgeWithTarget:aTarget sel:aSelector];
        NSTimer *timer = [self tfsafe_timerWithTimeInterval:ti
                                                     target:bridge
                                                   selector:aSelector
                                                   userInfo:userInfo
                                                    repeats:yesOrNo];
        return timer;
    }
    return nil;
}
+ (NSTimer *)tfsafe_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo{
    if (aTarget && aSelector) {
        TFTimerSafeBridge *bridge = [TFTimerSafeBridge bridgeWithTarget:aTarget sel:aSelector];
        NSTimer *timer = [self tfsafe_scheduledTimerWithTimeInterval:ti
                                                              target:bridge
                                                            selector:aSelector
                                                            userInfo:userInfo
                                                             repeats:yesOrNo];
        return timer;
    }
    return nil;
}


@end


@interface TFTimerSafeBridge ()

@property(nonatomic,  weak)id target;
@property(nonatomic,assign)SEL sel;

@end

@implementation TFTimerSafeBridge

+(instancetype)bridgeWithTarget:(id)target sel:(SEL)sel{
    
    TFTimerSafeBridge *bridge = [[TFTimerSafeBridge alloc]init];
    bridge.target = target;
    bridge.sel = sel;
    
    NSString *selString = NSStringFromSelector(sel);
    Method selMethod = class_getInstanceMethod([self class], sel);
    if (!selMethod) {
        SEL forSel = @selector(tf_forwardingTimerImp);
        if ([selString hasSuffix:@":"]) {
            forSel = @selector(tf_forwardingTimerImpParam:);
        }
        Method forMethod = class_getInstanceMethod([self class], forSel);
        IMP forImp = method_getImplementation(forMethod);
        const char *forImpTypeEncoding = method_getTypeEncoding(forMethod);
        BOOL added = class_addMethod([self class], sel, forImp,forImpTypeEncoding);
        if (!added) {
            return nil;
        }
    }
    return bridge;
}

-(void)tf_forwardingTimerImp{
    TFTimerSafeBridge *bridge = self;
    if ([bridge isKindOfClass:[TFTimerSafeBridge class]]) {
        if (bridge.target &&
            ([NSStringFromSelector(bridge.sel) isEqualToString:NSStringFromSelector(_cmd)])) {
            
            IMP imp = [bridge.target methodForSelector:bridge.sel];
            void (*func)(id, SEL) = (void *)imp;
            func(bridge.target, bridge.sel);
        }
    }

}
-(void)tf_forwardingTimerImpParam:(NSTimer *)timer{
    TFTimerSafeBridge *bridge = self;
    if ([bridge isKindOfClass:[TFTimerSafeBridge class]]) {
        if (bridge.target &&
            ([NSStringFromSelector(bridge.sel) isEqualToString:NSStringFromSelector(_cmd)])) {
            
            IMP imp = [bridge.target methodForSelector:bridge.sel];
            void (*func)(id, SEL ,NSTimer *) = (void *)imp;
            func(bridge.target, bridge.sel ,timer);
        }
    }
}

@end
