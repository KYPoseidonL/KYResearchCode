//
//  ViewController.m
//  DemoTest
//
//  Created by iOS Developer 3 on 15/9/23.
//  Copyright (c) 2015年 iOS Developer 3. All rights reserved.
//

#import "ViewController.h"

#import "ShareUIView.h"
#import "ShareTool.h"
#import "DataBaseViewController.h"
#import "KYWebViewViewController.h"
#import "UserLoginViewController.h"
#import "UINavigationBar+Awesome.h"
#import "AppListViewController.h"
#import "NetworkingViewController.h"
#import "TestViewController.h"
#import "UDIDViewController.h"
#import "ShowCustomAnimationController.h"
#import "RecordVideoController.h"
#import "MJRefresh.h"
#import "CommonMethodController.h"
#import "KYInputViewController.h"
#import "QRCodeViewController.h"
#import "WIFIScanViewController.h"
#import "AutoLayoutViewController.h"
#import "WKWebViewUserController.h"
#import "CustomButtonViewController.h"
#import "KYAlertViewController.h"

@interface ViewController ()<UMSocialUIDelegate, UITableViewDataSource, UITableViewDelegate>
{
    ShareTool           *_shareTool;
}

@property (nonatomic, strong) ShareUIView *shareUIView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"StudyDemo";
    
    [self createTabelView];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSInteger postion = 2;
    
    NSInteger oneCount = [self getOneWithCount:postion];
    
    //11
    for (int i = 0; i < oneCount; i ++) {
        
        NSInteger num = [self getRealIndexWithComposition:postion withIndex:i];
        
        switch (num) {
            case 1: DDLogDebug(@"高位为1"); break;
            case 2: DDLogDebug(@"低位为1"); break;
        }
    }

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        NSLog(@"下拉加载...");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
        });
    }];
}

- (NSInteger)getOneWithCount:(NSInteger)v {
    
    NSInteger number = 0;
    while(v){
        v &= (v-1);
        number++;
    }
    return number;
}

- (NSInteger)getRealIndexWithComposition:(NSInteger)composition withIndex:(NSInteger)index {
    
    int realIndex = 0;
    int num = -1;
    for(int i = 1;i < 3;++i ){
        BOOL is = (composition>>(3-1-i))&0x01;
        if( is )
            num += 1;
        
        if( index == num ){
            realIndex = i;
            break;
        }
    }
    return realIndex;
}

- (ShareUIView *)shareUIView {
    
    if (!_shareUIView) {
        UIImage *postImg = nil;
        postImg = [UIImage imageNamed:@"test1.jpg"];

        _shareTool = [[ShareTool alloc] initWithViewController:self shareImage:postImg descpContent:@"这是一条测试信息"];
        _shareUIView = [_shareTool getShareViewWithShareTool];
        
        _shareTool.fromeWhere = @"WebViewViewController";
        [self.view.window addSubview:_shareUIView];
        [_shareUIView setNeedsLayout];
        
    }
    return _shareUIView;

}
#pragma mark -LazyLoad
- (NSArray *)dataList {
    
    if (!_dataList) {
        _dataList = @[@"录制视频", @"分享测试", @"数据库", @"WebView", @"登陆账号联想", @"已安装app信息", @"网络请求", @"测试类", @"设备唯一标识符", @"自定义动画展示", @"常用公共方法", @"微信输入框", @"二维码相关", @"WIFI局域网IP扫描", @"AutoLayoutCell高度自适应", @"WKWebView使用", @"自定义按钮，文字图片位置随意定制", @"自定义警告提示框"];
    }
    return _dataList;
}

- (void)createTabelView {

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
//    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return  self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentify = @"CellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentify];
    }
    
    cell.textLabel.text = self.dataList[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            RecordVideoController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"RecordVideoID"];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 1: {
            [_shareUIView removeFromSuperview];
            _shareUIView = nil;
            
            [self shareUIView];
            [_shareTool shareBtnMethod];
        } break;
        case 2: {
            
            DataBaseViewController *vc = [[DataBaseViewController alloc] init];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 3: {
            KYWebViewViewController *vc = [[KYWebViewViewController alloc] init];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 4: {
            UserLoginViewController *vc =[[UserLoginViewController alloc] init];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 5: {
            AppListViewController *vc =[[AppListViewController alloc] init];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 6: {
            NetworkingViewController *vc =[[NetworkingViewController alloc] init];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 7: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TestViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"TestID"];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 8: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TestViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"SUDID"];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 9: {
            ShowCustomAnimationController *vc =[[ShowCustomAnimationController alloc] init];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 10: {
            CommonMethodController *vc =[[CommonMethodController alloc] init];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 11: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TestViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"KYInputID"];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 12: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            QRCodeViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"QRCodeID"];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 13: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            WIFIScanViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"WIFIScanID"];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 14: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            AutoLayoutViewController  *vc = [storyBoard instantiateViewControllerWithIdentifier:@"AutoLayoutCellID"];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 15: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            WKWebViewUserController  *vc = [storyBoard instantiateViewControllerWithIdentifier:@"WKWebViewUserID"];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 16: {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            CustomButtonViewController  *vc = [storyBoard instantiateViewControllerWithIdentifier:@"CustomButtonVCID"];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 17: {
            KYAlertViewController *vc =[[KYAlertViewController alloc] init];
            vc.title = self.dataList[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 200.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200.f)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:headView.bounds];
    imageView.image = [UIImage imageNamed:@"head.jpg"];
    [headView addSubview:imageView];
    
    return headView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        CGFloat alpha = MIN(1, 1 - ((64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    
//    DDLogDebug(@"%f", offsetY);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.translucent = YES;
    self.tableView.delegate = self;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

@end
