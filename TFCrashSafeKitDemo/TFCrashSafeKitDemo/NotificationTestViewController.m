//
//  NotificationTestViewController.m
//  TFCrashSafeKitDemo
//
//  Created by zhutaofeng on 2019/5/28.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "NotificationTestViewController.h"

@interface NotificationTestViewController ()

@end

@implementation NotificationTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor brownColor];
   
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(test)
                                                name:@"testnoti"
                                              object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(test)
                                                name:@"testnoti"
                                              object:nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(test)
                                                name:nil
                                              object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:nil
                                            selector:@selector(test)
                                                name:@"testnoti"
                                              object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:nil
                                                name:@"testnoti"
                                              object:nil];
    
}

-(void)test{
    NSLog(@"test");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
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
