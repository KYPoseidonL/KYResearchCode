//
//  AppListViewController.m
//  KYStudyDemo
//
//  Created by iOS Developer 3 on 16/3/4.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "AppListViewController.h"

#import "AppListCell.h"
#import "AppManager.h"
#import "AppModel.h"

static NSString *AppCellIdentify = @"AppCellIdentify";
@interface AppListViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;
@end

@implementation AppListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTabelView];

    [self requestData];
}

- (NSArray *)dataList {

    if (!_dataList) {
        _dataList = [[NSArray alloc] init];
    }
    return _dataList;
}

- (void)requestData {

    
    NSArray *applist = [[AppManager sharedAppManager] getAllappInfosWkspc];
    self.dataList = [AppModel mj_objectArrayWithKeyValuesArray:applist];
    [_tableView reloadData];
}

- (void)createTabelView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.rowHeight = 100.f;
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    AppListCell *cell = [tableView dequeueReusableCellWithIdentifier:AppCellIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AppListCell" owner:nil options:nil] lastObject];
    }
    
    cell.model = self.dataList[indexPath.row];
    [cell clearsContextBeforeDrawing];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AppModel *model = self.dataList[indexPath.row];
    [[AppManager sharedAppManager] openAppWithBundleId:model.bundleId];
}

@end
