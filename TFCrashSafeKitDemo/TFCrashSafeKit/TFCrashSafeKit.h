//
//  TFCrashSafeKit.h
//  TFCrashSafeKitDemo
//
//  Created by zhutaofeng on 2019/5/29.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TFCrashSafeKitDelegate <NSObject>

-(NSString *)custemReportArray:(NSArray *)array index:(NSInteger)index;

@end

@interface TFCrashSafeKit : NSObject

@property(nonatomic,assign)BOOL collectException;
@property(nonatomic,  weak)id<TFCrashSafeKitDelegate>delegate;

+(instancetype)shareInstance;

@end

