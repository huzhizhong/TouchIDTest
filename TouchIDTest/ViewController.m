//
//  ViewController.m
//  TouchIDTest
//
//  Created by FK on 15/8/26.
//  Copyright (c) 2015年 HZZ. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configAuthButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) configAuthButton
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"test touch ID" forState:UIControlStateNormal];
    [button setFrame:CGRectMake((self.view.frame.size.width - 150)/2,
                                (self.view.frame.size.height-30)/2, 150, 30)];
    [button setTitleColor:[UIColor blackColor] forState:
                                UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor]];
    [button addTarget:self action:@selector(authButton:)
                                forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void) authButton:(UIButton* )sender
{
    LAContext* context = [[LAContext alloc]init];
    NSError* error = nil;
    NSString* reason = @"测试：验证touchID";
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason
                                                                reply:^(BOOL success, NSError* error) {
            NSString* text = nil;
            if (success) {
                text = @"验证成功";
            } else {
                text = @"请设置TouchID";
            }
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:text delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }];
    } else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请设置TouchID" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
@end
