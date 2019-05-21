//
//  TFMethodExchange.h
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFMethodExchange : NSObject

+(BOOL)tf_instanceMethodExchange:(Class)cls originSel:(SEL)originSel toSel:(SEL)toSel;

+(BOOL)tf_classMethodExchange:(Class)cls originSel:(SEL)originSel toSel:(SEL)toSel;

@end


