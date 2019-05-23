//
//  NSArray+TFCrashSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSArray+TFCrashSafe.h"
#import "TFMethodExchange.h"
#import <objc/runtime.h>


@implementation NSArray (TFCrashSafe)

+(void)useSafe_NSArray_TFCrashSafe{
    
    Class __NSArray0 = NSClassFromString(@"__NSArray0");//不可变的空数组
    Class __NSArrayI = NSClassFromString(@"__NSArrayI");//不可变的元素数量>1数组
    Class __NSArrayM = NSClassFromString(@"__NSArrayM");//可变数组
    Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");//不可变的只有一个元素的数组
    
    [TFMethodExchange tf_instanceMethodExchange:__NSArray0
                                      originSel:NSSelectorFromString(@"objectAtIndex:")
                                          toSel:NSSelectorFromString(@"tfsafe_objectAtIndex:")];
    [TFMethodExchange tf_instanceMethodExchange:__NSArray0
                                      originSel:NSSelectorFromString(@"objectAtIndexedSubscript:")
                                          toSel:NSSelectorFromString(@"tfsafe_objectAtIndexedSubscript:")];
    
    [TFMethodExchange tf_instanceMethodExchange:__NSArrayI
                                      originSel:NSSelectorFromString(@"objectAtIndex:")
                                          toSel:NSSelectorFromString(@"tfsafe_objectAtIndex:")];
    [TFMethodExchange tf_instanceMethodExchange:__NSArrayI
                                      originSel:NSSelectorFromString(@"objectAtIndexedSubscript:")
                                          toSel:NSSelectorFromString(@"tfsafe_objectAtIndexedSubscript:")];
  
    [TFMethodExchange tf_instanceMethodExchange:__NSArrayM
                                      originSel:NSSelectorFromString(@"objectAtIndex:")
                                          toSel:NSSelectorFromString(@"tfsafe_objectAtIndex:")];
    [TFMethodExchange tf_instanceMethodExchange:__NSArrayM
                                      originSel:NSSelectorFromString(@"objectAtIndexedSubscript:")
                                          toSel:NSSelectorFromString(@"tfsafe_objectAtIndexedSubscript:")];
    
    [TFMethodExchange tf_instanceMethodExchange:__NSSingleObjectArrayI
                                      originSel:NSSelectorFromString(@"objectAtIndex:")
                                          toSel:NSSelectorFromString(@"tfsafe_objectAtIndex:")];
    [TFMethodExchange tf_instanceMethodExchange:__NSSingleObjectArrayI
                                      originSel:NSSelectorFromString(@"objectAtIndexedSubscript:")
                                          toSel:NSSelectorFromString(@"tfsafe_objectAtIndexedSubscript:")];
}

- (id)tfsafe_objectAtIndex:(NSUInteger)index {
    if (index >= 0 && index < self.count) {
        return [self tfsafe_objectAtIndex:index];
    }
    NSAssert(NO, ([NSString stringWithFormat:@"exception:%@ fuc:%@ index:%@",[self class],NSStringFromSelector(_cmd),@(index)]));
    return nil;
}

- (id)tfsafe_objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= 0 && index < self.count) {
        return [self tfsafe_objectAtIndexedSubscript:index];
    }
    NSAssert(NO, ([NSString stringWithFormat:@"exception:%@ fuc:%@ index:%@",[self class],NSStringFromSelector(_cmd),@(index)]));
    return nil;
}


@end
