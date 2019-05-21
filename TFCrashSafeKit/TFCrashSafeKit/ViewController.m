//
//  ViewController.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+TFCrashSafe.h"
#import "NSMutableArray+TFCrashSafe.h"
#import "NSDictionary+TFCrashSafe.h"
#import "NSMutableDictionary+TFCrashSafe.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [NSMutableDictionary useSafe];
    
    NSLog(@"====001-:%@",[@{}class]);
    NSLog(@"====000:%@",[@{@"":@""}class]);
    NSLog(@"====001:%@",[@{@"":@"",@"":@""} class]);
    NSLog(@"====002:%@",[[NSDictionary alloc]class]);
    NSLog(@"====003:%@",[[[NSDictionary alloc]init]class]);
    NSLog(@"====004:%@",[[[NSDictionary alloc]initWithObjectsAndKeys:@"",@"", nil]class]);
    NSLog(@"====005:%@",[[NSMutableDictionary alloc]class]);
    NSLog(@"====006:%@",[[[NSMutableDictionary alloc]init]class]);
    NSLog(@"====007:%@",[[[NSMutableDictionary alloc]initWithDictionary:@{}] class]);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic addEntriesFromDictionary:@[]];
    
    
    
    if (class_getInstanceMethod([ViewController class], @selector(xxx))) {
        NSLog(@"mingzhong");
    };
    
    
//    return;
//    NSArray *array = @[@"0"];
//    NSLog(@"array[0]:%@",array[0]);
//    NSLog(@"array[1]:%@",array[1]);
//    NSLog(@"array[2]:%@",array[2]);
    
    
    
}

//-(void)xxx{}


@end
