//
//  KYHTTPSessionManager.h
//  ChargeHub
//
//  Created by iOS Developer 3 on 15/12/31.
//  Copyright © 2015年 KYPoseidonL. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface HTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

/**
 *  getJson方法
 *
 *  @param fid       参数
 *  @param parameter 发送的数据体
 *  @param success   成功回调
 *  @param fail      失败回调
 */
- (void)getJosonWithURLString:(NSString *)URLString parameters:(id )parameters success:(void(^)(id dic))success fail:(void(^)(NSError* error))fail;


/**
 *  快速post请求
 *
 *  @param fid       参数
 *  @param parameter 发送的数据体
 *  @param success   成功回调
 *  @param fail      失败回调
 */
- (void)postJsonWithURLString:(NSString *)URLString parameters:(id)parameters success:(void(^)(id dic))success fail:(void(^)(NSError* error))fail;

@end
