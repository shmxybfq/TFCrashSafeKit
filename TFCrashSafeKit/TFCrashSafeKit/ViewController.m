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
#import "TestUIViewController.h"
@interface ViewController ()

@end

@implementation ViewController

-(void)timerRun:(NSTimer *)timer{
    NSLog(@">>>>>>>>>>:timerRun:%@",timer);
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [NSTimer useSafe_TFDeallocSafe];
    
    NSTimer *tt = [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                                 selector:@selector(timerRun:)
                                   userInfo:self
                                    repeats:YES];
    NSLog(@">>>55:%@",tt);
//    [NSObject useSafe_TFKVOSafe];
//
//    [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
//    [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
//    [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
//
//    [self removeObserver:self forKeyPath:@"title"];
//    [self removeObserver:self forKeyPath:@"title"];
//    [self removeObserver:self forKeyPath:@"title"];
//    [self removeObserver:self forKeyPath:@"title"];
//
    
    
//    [NSMutableDictionary useSafe];
//
//    NSLog(@"====001-:%@",[@{}class]);
//    NSLog(@"====000:%@",[@{@"":@""}class]);
//    NSLog(@"====001:%@",[@{@"":@"",@"":@""} class]);
//    NSLog(@"====002:%@",[[NSDictionary alloc]class]);
//    NSLog(@"====003:%@",[[[NSDictionary alloc]init]class]);
//    NSLog(@"====004:%@",[[[NSDictionary alloc]initWithObjectsAndKeys:@"",@"", nil]class]);
//    NSLog(@"====005:%@",[[NSMutableDictionary alloc]class]);
//    NSLog(@"====006:%@",[[[NSMutableDictionary alloc]init]class]);
//    NSLog(@"====007:%@",[[[NSMutableDictionary alloc]initWithDictionary:@{}] class]);
//
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//    [dic addEntriesFromDictionary:@[]];
//
//
//
//    if (class_getInstanceMethod([ViewController class], @selector(xxx))) {
//        NSLog(@"mingzhong");
//    };
//
//
//
//    NSLog(@">>>>>>>>>>111:%d",[[NSObject new] respondsToSelector:@selector(resolveClassMethod:)]);
//    NSLog(@">>>>>>>>>>222:%d",[[NSObject new] respondsToSelector:@selector(resolveInstanceMethod:)]);
//    NSLog(@">>>>>>>>>>333:%d",[[NSObject new] respondsToSelector:@selector(forwardingTargetForSelector:)]);
//    NSLog(@">>>>>>>>>>444:%d",[[NSObject new] respondsToSelector:@selector(forwardInvocation:)]);
//
//
//
//    if (class_getInstanceMethod([[NSObject new] class], @selector(resolveClassMethod:))) {
//        NSLog(@">>>>>>>>>>aaa:");
//    }
//    if (class_getInstanceMethod([[NSObject new] class], @selector(resolveInstanceMethod:))) {
//        NSLog(@">>>>>>>>>>bbb:");
//    }
//    if (class_getInstanceMethod([[NSObject new] class], @selector(forwardingTargetForSelector:))) {
//        NSLog(@">>>>>>>>>>ccc:");
//    }
//    if (class_getInstanceMethod([[NSObject new] class], @selector(forwardInvocation:))) {
//        NSLog(@">>>>>>>>>>ddd:");
//    }
    
//    [NSObject useSafe];
    
//    [self performSelector:@selector(jjj:xxx:ooo:yyy:) withObject:nil];
//    [self performSelector:@selector(jjj:xxx:ooo:yyy:) withObject:nil];
    
    
//    NSLog(@">>>>>>>>>>bbb:%d",[self respondsToSelector:@selector(resolveInstanceMethod:)]);
//    NSLog(@">>>>>>>>>>ccc:%d",[self respondsToSelector:@selector(forwardingTargetForSelector:)]);
//    NSLog(@">>>>>>>>>>ddd:%d",[self respondsToSelector:@selector(forwardInvocation:)]);
    
    
//    return;
//    NSArray *array = @[@"0"];
//    NSLog(@"array[0]:%@",array[0]);
//    NSLog(@"array[1]:%@",array[1]);
//    NSLog(@"array[2]:%@",array[2]);
}

//-(id)forwardingTargetForSelector:(SEL)aSelector{
//    id xx = [super forwardingTargetForSelector:aSelector];
//    NSLog(@",,,%@",xx);
//    return xx;
//}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TestUIViewController *controler =[[TestUIViewController alloc]init];
    [self presentViewController:controler animated:YES completion:^{
        
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [controler dismissViewControllerAnimated:YES completion:nil];
    });
}



@end
