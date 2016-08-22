//
//  WIFIScanViewController.m
//  KYResearchCode
//
//  Created by iOS Developer 3 on 16/8/22.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "WIFIScanViewController.h"
#import "NtFinder.h"
#import "SimplePingHelper.h"

static NSString *WIFIScanCellIdentify = @"WIFIScanCellIdentify";

@interface WIFIScanViewController ()
{
    NSInteger _ipIndex;
}

@property (weak, nonatomic) IBOutlet UITableView *wifiScanTableView;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation WIFIScanViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:@"努力加载中..."];
    self.wifiScanTableView.hidden = YES;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self pingAndMacAddress];
        [[NSRunLoop currentRunLoop] run];
    });
}

#pragma mark - LazyLoad
- (NSMutableArray *)dataList {

    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

#pragma mark - Private Methods
- (void)pingAndMacAddress {
    NSString *macAddress = [NtFinder macAddress];
    NSLog(@"local mac address = %@", macAddress);
    
    NSMutableDictionary *routerInfo = [NtFinder getRouterInfo];
    NSDictionary *wifiDict = [routerInfo valueForKey:@"wifi"];
    NSDictionary *cellularDict = [routerInfo valueForKey:@"cellular"];
    NSLog(@"wifiDict %@", wifiDict);
    NSLog(@"cellularDict %@", cellularDict);
    
    if (wifiDict) {
        NSString *gatewayIp = [wifiDict valueForKey:@"gateway"];
        NSLog(@"gatewayIp %@", gatewayIp);
        [self pingAddress:gatewayIp];
        NSString *localIp = [wifiDict valueForKey:@"local"];
        NSLog(@"localIp %@", localIp);
        [self pingAddress:localIp];
    }
    
    if (cellularDict) {
        NSString *gatewayIp = [cellularDict valueForKey:@"gateway"];
        NSLog(@"gatewayIp %@", gatewayIp);
        [self pingAddress:gatewayIp];
        NSString *localIp = [cellularDict valueForKey:@"local"];
        NSLog(@"localIp %@", localIp);
        [self pingAddress:localIp];
    }
    
    
    for (int i = 1; i < 255; i++) {
        NSString *ip = [NSString stringWithFormat:@"192.168.2.%d", i];
        //        NSLog(@"Pinging %@", ip);
        [self pingAddress:ip];
    }
    
    
}

- (void)pingAddress:(NSString *)address {
    [SimplePingHelper ping:address target:self sel:@selector(pingResult:hostName:)];
}

- (void)pingResult:(NSNumber*)success hostName:(NSString *)address {
    _ipIndex ++;
    if (success.boolValue) {
        NSLog(@"Ping SUCCESS");
    } else {
        NSLog(@"Ping FAILURE");
    }
    
    NSString *macAddr = [NtFinder ip2mac:address];
    
    NSString *ipString = [NSString stringWithFormat:@"%@,%@", address, macAddr];
    if (macAddr) {
        [self.dataList addObject:ipString];
    }
    
    NSLog(@"%d: %@", _ipIndex, ipString);
    
    if (_ipIndex == 256) {
        NSString *str = [self.dataList componentsJoinedByString:@"|"];
        NSLog(@"%@", str);
        [SVProgressHUD dismiss];
        self.wifiScanTableView.hidden = NO;
        [self.wifiScanTableView reloadData];
    }
    //    NSLog(@"ARP IP = %@, mac address = %@", address, macAddr);
    
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WIFIScanCellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WIFIScanCellIdentify];
    }
    
    cell.textLabel.text = self.dataList[indexPath.row];
    
    return cell;
}

@end
