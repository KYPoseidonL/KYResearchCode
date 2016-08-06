//
//  KYDataService.h
//  KYResearchCode
//
//  Created by KYPoseidonL on 16/8/6.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KYDataService : NSObject

+ (id)requestDataOfJsonName:(NSString *)name;

+ (id)requestDataOfPlistName:(NSString *)name;

@end
