//
//  UIView+TFUICrashSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/23.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "UIView+TFUICrashSafe.h"
#import <objc/runtime.h>
#import "TFCrashSafeKitConst.h"
#import "NSObject+MethodExchange.h"

@implementation UIView (TFUICrashSafe)


+(void)useSafe_UIView_TFUICrashSafe{
    
    Class cls = [UIView class];
    [cls tf_instanceMethodExchange:@selector(setNeedsLayout)
                           toClass:[self class]
                             toSel:@selector(tfsafe_setNeedsLayout)];

    [cls tf_instanceMethodExchange:@selector(setNeedsDisplay)
                           toClass:[self class]
                             toSel:@selector(tfsafe_setNeedsDisplay)];
    
    [cls tf_instanceMethodExchange:@selector(setNeedsDisplayInRect:)
                           toClass:[self class]
                             toSel:@selector(tfsafe_setNeedsDisplayInRect:)];
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
