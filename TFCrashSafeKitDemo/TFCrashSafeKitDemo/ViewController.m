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
@interface ViewController ()

@property(nonatomic,  copy)NSString *kvostring;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSObject useSafe_NSObject_UnrecognizedSelector];
    [self performSelector:@selector(xxx:tt:hh:gg:nn:) withObject:nil];
    
    
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
