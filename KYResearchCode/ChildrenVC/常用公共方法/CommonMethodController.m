//
//  CommonMethodController.m
//  KYResearchCode
//
//  Created by iOS Developer 3 on 16/6/7.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "CommonMethodController.h"

@interface CommonMethodController ()

@property (nonatomic, strong) UILabel *testLabel;

@end

@implementation CommonMethodController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

 
    
    [self createNavigationItem];
    
    [self setup];
}

- (void)setup {

    TICK
    NSArray *arr = @[@"guangzhou", @"shanghai", @"北京", @"henan", @"hainan"];
    NSDictionary *dic = [KYUtility dictionaryOrderByCharacterWithOriginalArray:arr];
    NSArray *t1 = [dic allKeys].firstObject;
    NSArray *t2 = [dic allValues].firstObject;
    NSString *tt1 = [t1 componentsJoinedByString:@","];
    NSString *tt2 = [t2 componentsJoinedByString:@","];
    NSString *testResult1 = [NSString stringWithFormat:@"key: %@, value: %@", tt1, tt2];
    DDLogDebug(@"\n\ntestResult1: %@", testResult1);
    TOCK
    
    NSString *testResult2 = [KYUtility timeIntervalFromLastTime:@"2015年12月8日 15:50"
                                            lastTimeFormat:@"yyyy年MM月dd日 HH:mm"
                                             ToCurrentTime:@"2015/12/08 16:12"
                                         currentTimeFormat:@"yyyy/MM/dd HH:mm"];
    DDLogDebug(@"\n\ntestResult2: %@", testResult2);
    
    self.testLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 50.f, kScreen_Width-20.f, kScreen_Height-100.f)];
    self.testLabel.text = [NSString stringWithFormat:@"%@\r\n\n%@", testResult1, testResult2];
    self.testLabel.numberOfLines = 0;
    self.testLabel.textColor = [UIColor blackColor];
    [self.view addSubview:self.testLabel];
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
