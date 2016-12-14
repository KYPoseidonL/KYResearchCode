//
//  KYAlertViewController.m
//  KYResearchCode
//
//  Created by iOS Developer 3 on 16/12/14.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "KYAlertViewController.h"

#import "KYAlertView.h"

@interface KYAlertViewController () <KYAlertViewDelegate>

@property (nonatomic, strong) UISegmentedControl * segmentedControl;

@end

@implementation KYAlertViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray * noticStyleArray = @[@"经典",@"小人脸"];
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:noticStyleArray];
    _segmentedControl.center = CGPointMake(self.view.center.x , 60);
    _segmentedControl.bounds = CGRectMake(0, 0, 200, 40);
    [self.view addSubview:_segmentedControl];
    _segmentedControl.selectedSegmentIndex = 0;
    
    CGFloat x = self.view.center.x ;
    CGFloat y = self.view.center.y - 160;
    
    NSArray * textArray = @[@"成功",@"失败",@"警告"];
    
    for (NSUInteger i = 0; i < 3 ; i ++) {
        UIButton * successButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [successButton setTitle:textArray[i] forState:UIControlStateNormal];
        successButton.center  = CGPointMake(x, y);
        successButton.bounds = CGRectMake(0, 0, 100, 30);
        [self.view addSubview:successButton];
        [successButton addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        successButton.tag = 60 + i;
        y += 80;
    }
}



- (void)show:(UIButton *)sender
{
    
    NSString * title = nil;
    NSString * detail = nil;
    NSString * cancle = @"取消";
    NSString * ok = @"确定";
    switch (sender.tag - 59) {
        case KYAlertViewStyleSuccess:
        case KYAlertViewStyleDefalut:
            title = @"温馨提示";
            detail = @"登录成功";
            cancle = nil;
            break;
        case KYAlertViewStyleFail:
            title = @"错误提示";
            detail = @"您输入的号码有误。";
            break;
        case KYAlertViewStyleWaring:
            title = @"警告";
            detail = @"非安全操作！！";
        default:
            break;
    }
#pragma mark Block
    KYAlertView * alertView = [KYAlertView showAlertViewWithStyle:sender.tag - 59 noticStyle:_segmentedControl.selectedSegmentIndex title:title detail:detail canleButtonTitle:cancle okButtonTitle:ok callBlock:^(MyWindowClick buttonIndex) {
        //点击效果
        
    }];
    [alertView show];
    
    
#pragma mark Delegate
    //    KYAlertView * alertView = [KYAlertView showAlertViewWithStyle:sender.tag - 59 title:title detail:detail canleButtonTitle:cancle okButtonTitle:ok delegate:self];
    //
    //    [alertView show];
}

- (void)alertViewClick:(KYAlertViewStyle)type
{
    
}

@end
