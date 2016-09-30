//
//  NetworkingViewController.m
//  KYStudyDemo
//
//  Created by iOS Developer 3 on 16/3/18.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "NetworkingViewController.h"
#import "HTTPRequestManager.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "AFHTTPSessionManager.h"

@interface NetworkingViewController ()

@property (nonatomic, strong) UILabel *showMessageLabel;

@end

@implementation NetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:@"努力加载中..."];
    [self performSelector:@selector(requestData) withObject:nil afterDelay:1.f];
}

- (void)setup {
    
    self.showMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 50.f, kScreen_Width-20.f, 200.f)];
    self.showMessageLabel.numberOfLines = 0;
    [self.view addSubview:self.showMessageLabel];
    
}

- (void)requestData {
    
    NSString *urlString = @"http://api.map.baidu.com/telematics/v3/weather?location=%E5%8C%97%E4%BA%AC&output=json&ak=5slgyqGDENN7Sy7pw29IUvrZ";

    @weakify(self);
    [[HTTPRequestManager sharedHTTPRequestManager] getJosonWithURLString:urlString parameters:nil success:^(id dic) {
        @strongify(self);
        [SVProgressHUD dismiss];
        self.showMessageLabel.text = [NSString stringWithFormat:@"%@", [dic mj_JSONString]];
        
    } fail:^(NSError *error) {
        
    }];
}



@end
