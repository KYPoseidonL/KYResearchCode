//
//  NtFinder.h
//  defense
//
//  Created by Eric Wu on 15/11/19.
//  Copyright © 2015年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTypeInfoKeyWifi               @"wifi"
#define kTypeInfoKeyCellular           @"cellular"

@interface NtFinder : NSObject

/*
 1. get local router information
 - local ip, gateway, netmask, broadcast address, interface, etc.(IPV4 address)
 - when using cellular network, I'm only sure that the ip address is correct, and I can not confirm other informations
*/
+ (NSMutableDictionary *)getRouterInfo;
+ (NSString *)macAddress;
+ (NSString *)ip2mac:(NSString *)ip;

@end
