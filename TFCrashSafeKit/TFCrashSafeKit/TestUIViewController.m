//
//  TestUIViewController.m
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/22.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TestUIViewController.h"

@interface TestUIViewController ()

@end

@implementation TestUIViewController

-(void)dealloc{
    NSLog(@"TestUIViewController-dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
