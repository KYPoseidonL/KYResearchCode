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

#pragma mark - Override Methods
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    self.navigationItem.titleView = titleLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kColor(@"f0efed");
    
    
    if (self.navigationController.viewControllers.count > 1) {
        [self createBackButton];
    }
}

- (void)createBackButton {

    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40.f, 44.f);
    backButton.titleLabel.font  = [UIFont systemFontOfSize:16.f];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)backAction {

    [self.navigationController popViewControllerAnimated:YES];
}

@end
