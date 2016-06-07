//
//  KYBaseViewController.m
//  KYStudyDemo
//
//  Created by iOS Developer 3 on 15/11/10.
//  Copyright © 2015年 KYPoseidonL. All rights reserved.
//

#import "KYBaseViewController.h"

@interface KYBaseViewController ()

@end

@implementation KYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kColor(@"f0efed");
    
    
    if (self.navigationController.viewControllers.count > 1) {
        [self createBackButton];
    }
}

- (void)createBackButton {

    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 60.f, 44.f);
    backButton.titleLabel.font  = [UIFont systemFontOfSize:16.f];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)backAction {

    [self.navigationController popViewControllerAnimated:YES];
}

@end
