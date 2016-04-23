//
//  AppManager.h
//  caimimao
//
//  Created by iOS Developer 3 on 16/1/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "singleton.h"

@interface AppManager : NSObject

singletonInterface(AppManager)

@property (nonatomic, copy) NSString *appStoreSearchURL;    //指定跳转到appStore的URL

- (NSMutableArray *)getAllappInfosWkspc;

- (BOOL)judgeAppRunningWithBundleId:(NSString *)bundleId;

- (BOOL)openAppWithBundleId:(NSString *)bundleId;

- (BOOL)applicationIsInstalledWithBundleId:(NSString *)bundleId;

- (void)goToASSearch;

- (NSObject *)getAppInfoWithBundleId:(NSString *)bundleId;

@end
