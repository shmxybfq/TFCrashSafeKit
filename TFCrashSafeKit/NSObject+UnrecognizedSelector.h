//
//  NSObject+UnrecognizedSelector.h
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (UnrecognizedSelector)

+(void)useSafe_NSObject_UnrecognizedSelector;

@end

@interface TFUnrecognizedSelectorForwarding : NSObject

-(instancetype)initWithSelector:(SEL)aSelector;

@end
