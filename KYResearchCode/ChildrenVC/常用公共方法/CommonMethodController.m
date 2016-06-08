//
//  CommonMethodController.m
//  KYResearchCode
//
//  Created by iOS Developer 3 on 16/6/7.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "CommonMethodController.h"

@interface CommonMethodController ()

@end

@implementation CommonMethodController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    TICK
    NSArray *arr = @[@"guangzhou", @"shanghai", @"北京", @"henan", @"hainan"];
    NSDictionary *dic = [KYUtility dictionaryOrderByCharacterWithOriginalArray:arr];
    DDLogDebug(@"\n\ndic: %@", dic);
    TOCK
    
    DDLogDebug(@"\n\nresult: %@", [KYUtility timeIntervalFromLastTime:@"2015年12月8日 15:50"
                                                  lastTimeFormat:@"yyyy年MM月dd日 HH:mm"
                                                   ToCurrentTime:@"2015/12/08 16:12"
                                               currentTimeFormat:@"yyyy/MM/dd HH:mm"]);
    
    [self createNavigationItem];
}

- (void)createNavigationItem {

    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40.f, 44.f);
    rightButton.uky_acceptEventInterval = 3.f;
    [rightButton setTitle:@"click" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)rightButtonAction:(UIButton *)sender {
    DDLogDebug(@"测试重复点击");
}


@end
