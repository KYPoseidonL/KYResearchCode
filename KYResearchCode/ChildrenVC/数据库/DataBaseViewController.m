//
//  DataBaseViewController.m
//  KYStudyDemo
//
//  Created by iOS Developer 3 on 15/10/23.
//  Copyright (c) 2015年 KYPoseidonL. All rights reserved.
//

#import "DataBaseViewController.h"
#import "KYDataBase.h"
#import "AppManager.h"

@interface DataBaseViewController ()

@property (nonatomic, strong) NSArray *appList;

@end

@implementation DataBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (NSArray *)appList {
    
    if (!_appList) {
        _appList = [[NSArray alloc] init];
    }
    return _appList;
}

#pragma mark - SQL Operations
- (IBAction)createTable:(id)sender {

    [[KYDataBase sharedKYDataBase] createAppInfoTable];
    self.appList = [[AppManager sharedAppManager] getAllappInfosWkspc];
}

- (IBAction)insertData:(id)sender {
    
    for (NSDictionary *appInfo in self.appList) {
        [[KYDataBase sharedKYDataBase] insertBundleId:appInfo[@"bundleId"]];
    }
}

- (IBAction)queryData:(id)sender {

    NSArray *result = [[KYDataBase sharedKYDataBase] queryData];
    for (id obj in result) {
        
        DDLogDebug(@"%@", obj);
    }
}

- (IBAction)clearAll:(id)sender {
    [[KYDataBase sharedKYDataBase] clearAll];
}

- (IBAction)multithread:(id)sender {

}

@end
