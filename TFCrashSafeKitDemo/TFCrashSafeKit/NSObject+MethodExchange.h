//
//  NSObject+MethodExchange.h
//  TFCrashSafeKitDemo
//
//  Created by zhutaofeng on 2019/5/24.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (MethodExchange)

+(BOOL)tf_instanceMethodExchange:(SEL)originSel toClass:(Class)toClass  toSel:(SEL)toSel;

@end


