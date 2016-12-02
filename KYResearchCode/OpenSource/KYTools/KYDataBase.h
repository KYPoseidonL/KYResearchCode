//
//  KYDataBase.h
//  KYStudyDemo
//
//  Created by iOS Developer 3 on 15/11/3.
//  Copyright © 2015年 KYPoseidonL. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "singleton.h"

@interface KYDataBase : NSObject

singletonInterface(KYDataBase)

- (void)createAppInfoTable;

- (void)insertBundleId:(NSString *)bundleId;

- (NSMutableArray *)queryData;

- (void)clearAll;

@end
