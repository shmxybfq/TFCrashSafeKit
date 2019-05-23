//
//  UIView+TFUICrashSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/23.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "UIView+TFUICrashSafe.h"
#import <objc/runtime.h>
#import "TFMethodExchange.h"
#import "TFCrashSafeKitConst.h"

@implementation UIView (TFUICrashSafe)


+(void)useSafe_TFDeallocSafe{
    
    SEL layoutOriginSel = NSSelectorFromString(@"setNeedsLayout");
    SEL layoutToSel = NSSelectorFromString(@"tfsafe_setNeedsLayout");
    [TFMethodExchange tf_instanceMethodExchange:[self class]
                                      originSel:layoutOriginSel
                                          toSel:layoutToSel];
    
    SEL displayOriginSel = NSSelectorFromString(@"setNeedsDisplay");
    SEL displayToSel = NSSelectorFromString(@"tfsafe_setNeedsDisplay");
    [TFMethodExchange tf_instanceMethodExchange:[self class]
                                      originSel:displayOriginSel
                                          toSel:displayToSel];
    
    SEL displayRectOriginSel = NSSelectorFromString(@"setNeedsDisplayInRect:");
    SEL displayRectToSel = NSSelectorFromString(@"tfsafe_setNeedsDisplayInRect:");
    [TFMethodExchange tf_instanceMethodExchange:[self class]
                                      originSel:displayRectOriginSel
                                          toSel:displayRectToSel];
}


-(void)tfsafe_setNeedsLayout{
    if ([NSThread currentThread] == [NSThread mainThread]) {
        [self tfsafe_setNeedsLayout];
    }else{
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself tfsafe_setNeedsLayout];
        });
    }
}
-(void)tfsafe_setNeedsDisplay{
    if ([NSThread currentThread] == [NSThread mainThread]) {
        [self tfsafe_setNeedsDisplay];
    }else{
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself tfsafe_setNeedsDisplay];
        });
    }
}
-(void)tfsafe_setNeedsDisplayInRect:(CGRect)rect{
    if ([NSThread currentThread] == [NSThread mainThread]) {
        [self tfsafe_setNeedsDisplayInRect:rect];
    }else{
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself tfsafe_setNeedsDisplayInRect:rect];
        });
    }
}

@end
