//
//  KYDataService.m
//  KYResearchCode
//
//  Created by KYPoseidonL on 16/8/6.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "KYDataService.h"

@implementation KYDataService

+ (id)requestDataOfJsonName:(NSString *)name {

    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    
    return result;
}

+ (id)requestDataOfPlistName:(NSString *)name {

    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    NSArray *reslut = [NSArray arrayWithContentsOfFile:path];
    
    return reslut;
}

@end
