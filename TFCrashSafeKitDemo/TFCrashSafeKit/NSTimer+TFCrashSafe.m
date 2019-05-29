//
//  NSTimer+TFCrashSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/22.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSTimer+TFCrashSafe.h"
#import <objc/runtime.h>
#import "TFCrashSafeKitConst.h"
#import "NSObject+MethodExchange.h"

@implementation NSTimer (TFCrashSafe)

+(void)useSafe_NSTimer_TFCrashSafe{
    
    Class cls = [NSTimer class];
    
    SEL originTimer = @selector(timerWithTimeInterval:target:selector:userInfo:repeats:);
    SEL toTimer = @selector(tfsafe_timerWithTimeInterval:target:selector:userInfo:repeats:);
    [cls tf_classMethodExchange:originTimer
                        toClass:[self class]
                          toSel:toTimer];
    
    SEL originScheduled = @selector(scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:);
    SEL toScheduled = @selector(tfsafe_scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:);
    [cls tf_classMethodExchange:originScheduled
                        toClass:[self class]
                          toSel:toScheduled];
    
}

+ (NSTimer *)tfsafe_timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo{
    if (aTarget && aSelector) {
        NSString *sel = sel = @"tf_forwardingTimerImpParam:";
        TFTimerSafeBridge *bridge = [TFTimerSafeBridge bridgeWithTarget:aTarget sel:aSelector];
        NSTimer *timer = [self tfsafe_timerWithTimeInterval:ti
                                                     target:bridge
                                                   selector:NSSelectorFromString(sel)
                                                   userInfo:userInfo
                                                    repeats:yesOrNo];
        return timer;
    }
    return nil;
}
+ (NSTimer *)tfsafe_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo{
    if (aTarget && aSelector) {
        NSString *sel = sel = @"tf_forwardingTimerImpParam:";
        TFTimerSafeBridge *bridge = [TFTimerSafeBridge bridgeWithTarget:aTarget sel:aSelector];
        NSTimer *timer = [self tfsafe_scheduledTimerWithTimeInterval:ti
                                                              target:bridge
                                                            selector:NSSelectorFromString(sel)
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

-(void)dealloc{
    
}

+(instancetype)bridgeWithTarget:(id)target sel:(SEL)sel{
    
    TFTimerSafeBridge *bridge = [[TFTimerSafeBridge alloc]init];
    bridge.target = target;
    bridge.sel = sel;
    return bridge;
}

-(void)tf_forwardingTimerImpParam:(NSTimer *)timer{
    TFTimerSafeBridge *bridge = self;
    if ([bridge isKindOfClass:[TFTimerSafeBridge class]] && bridge.target && bridge.sel) {
        if ([NSStringFromSelector(bridge.sel) hasSuffix:@":"]) {
            IMP imp = [bridge.target methodForSelector:bridge.sel];
            void (*func)(id, SEL ,NSTimer *) = (void *)imp;
            func(bridge.target, bridge.sel ,timer);
        }else{
            IMP imp = [bridge.target methodForSelector:bridge.sel];
            void (*func)(id, SEL) = (void *)imp;
            func(bridge.target, bridge.sel);
        }
    }else{
        if (timer && [timer isValid]) {
            [timer invalidate];
        }
    }
}

@end
