//
//  NSDictionary+TFCrashSafe.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NSDictionary+TFCrashSafe.h"
#import "TFMethodExchange.h"
#import <objc/runtime.h>
#import "TFCrashSafeKitManager.h"

@implementation NSDictionary (TFCrashSafe)

+(void)useSafe_NSDictionary_TFCrashSafe{
   
    Class __NSDictionary0 = NSClassFromString(@"__NSDictionary0");//不可变的空字典
    Class __NSDictionaryI = NSClassFromString(@"__NSDictionaryI");//不可变的元素数量>1字典
    Class __NSDictionaryM = NSClassFromString(@"__NSDictionaryM");//可变字典
    Class __NSSingleEntryDictionaryI = NSClassFromString(@"__NSSingleEntryDictionaryI");//不可变的只有一个元素的字典
    [TFMethodExchange tf_instanceMethodExchange:__NSDictionary0
                                      originSel:NSSelectorFromString(@"objectForKeyedSubscript:")
                                          toSel:NSSelectorFromString(@"tfsafe_objectForKeyedSubscript:")];
    
    [TFMethodExchange tf_instanceMethodExchange:__NSDictionaryI
                                      originSel:NSSelectorFromString(@"objectForKeyedSubscript:")
                                          toSel:NSSelectorFromString(@"tfsafe_objectForKeyedSubscript:")];
    
    [TFMethodExchange tf_instanceMethodExchange:__NSDictionaryM
                                      originSel:NSSelectorFromString(@"objectForKeyedSubscript:")
                                          toSel:NSSelectorFromString(@"tfsafe_objectForKeyedSubscript:")];
    
    [TFMethodExchange tf_instanceMethodExchange:__NSSingleEntryDictionaryI
                                      originSel:NSSelectorFromString(@"objectForKeyedSubscript:")
                                          toSel:NSSelectorFromString(@"tfsafe_objectForKeyedSubscript:")];
}

- (id)tfsafe_objectForKeyedSubscript:(id)key{
    if (key) {
        return [self tfsafe_objectForKeyedSubscript:key];
    }else{
        if ([TFCrashSafeKitManager shareInstance].collectException) {
            @try {
                [self tfsafe_objectForKeyedSubscript:key];
            } @catch (NSException *exception) {
                NSLog(@">>>>:%@",exception);
            } @finally {
                return nil;
            }
        }
    }
    return nil;
}



@end
