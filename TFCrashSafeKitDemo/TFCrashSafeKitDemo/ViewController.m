//
//  ViewController.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "NSArray+TFCrashSafe.h"
#import "NSMutableArray+TFCrashSafe.h"
#import "NSDictionary+TFCrashSafe.h"
#import "NSMutableDictionary+TFCrashSafe.h"
#import "NSObject+UnrecognizedSelector.h"
#import "NSObject+TFKVOSafe.h"
#import "NSTimer+TFCrashSafe.h"

#import "NotificationTestViewController.h"

#import "NSNotificationCenter+TFCrashSafe.h"

#import "NSString+TFCrashSafe.h"
@interface ViewController ()<UIScrollViewDelegate>

@property(nonatomic,  copy)NSString *kvostring;

@property(nonatomic,strong)NSObject *obj;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [NSTimer useSafe_NSTimer_TFCrashSafe];
//    self.obj = [[NSObject alloc]init];
//    static NSTimer *tm = nil;
//    tm = [NSTimer timerWithTimeInterval:1 target:self.obj selector:@selector(ooo:) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop]addTimer:tm forMode:NSRunLoopCommonModes];
//    [tm fire];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.obj = nil;
//    });
    
    
//    NSLog(@"001");
//    [NSString useSafe_NSString_TFCrashSafe];
//    NSLog(@"002");
//    NSString *str0 = @"abc";
//    NSString *str1 = [NSString stringWithCString:"edf" encoding:NSUTF8StringEncoding];
//    NSMutableString *str2 = [NSMutableString stringWithFormat:@"ghi"];
//
//    NSLog(@"003:%@:%@:%@",[str0 class],[str1 class],[str2 class]);
//
//    [str0 substringFromIndex:-1];
//    [str1 substringFromIndex:-1];
//    [str2 substringFromIndex:-1];
//    [str0 substringToIndex:10];
//    [str1 substringToIndex:10];
//    [str2 substringToIndex:10];
//    [str0 substringWithRange:NSMakeRange(10, 12)];
//    [str1 substringWithRange:NSMakeRange(10, 12)];//NSTaggedPointerString
//    [str2 substringWithRange:NSMakeRange(10, 12)];
//    [str0 characterAtIndex:10];
//    [str1 characterAtIndex:10];//NSTaggedPointerString
//    [str2 characterAtIndex:10];

    
    
    
//    [NSArray useSafe_NSArray_TFCrashSafe];
//    NSArray *array0 = @[];
//    [array0 objectAtIndex:10];
    
//    return;
//    [NSObject useSafe_NSObject_UnrecognizedSelector];
//    [self performSelector:@selector(xxx:tt:hh:gg:nn:) withObject:nil];
    
    
//    [NSObject useSafe_NSObject_TFKVOSafe];
//
//    [self addObserver:self
//           forKeyPath:@"kvostring"
//              options:NSKeyValueObservingOptionNew
//              context:nil];
   
    
//    static NSTimer *tt = nil;
//    tt = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
//    [NSNotificationCenter useSafe_NSNotificationCenter_TFCrashSafe];
    
}

-(void)ooo:(NSTimer *)timer{
    NSLog(@"mmm");
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"kvo=:%@:%@:%@",keyPath,object,change);
}



-(void)timerRun{
    
    NSLog(@"123456789");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"testnoti" object:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.kvostring = @"1";
//    NotificationTestViewController *controller = [[NotificationTestViewController alloc]init];
//    [self presentViewController:controller animated:YES completion:nil];
    
    
}


@end
