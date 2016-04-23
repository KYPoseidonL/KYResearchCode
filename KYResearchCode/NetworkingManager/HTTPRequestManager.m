//
//  CHHTTPRequestManager.m
//  ChargeHub
//
//  Created by iOS Developer 3 on 15/12/31.
//  Copyright © 2015年 KYPoseidonL. All rights reserved.
//

#import "HTTPRequestManager.h"
#import "HTTPSessionManager.h"

@interface HTTPRequestManager ()

@property (nonatomic, strong) HTTPSessionManager *requestManager;

@end

@implementation HTTPRequestManager

singletonImplemention(HTTPRequestManager)

- (HTTPSessionManager *)requestManager {
    
    if (!_requestManager) {
        _requestManager = [HTTPSessionManager sharedManager];
    }
    return _requestManager;
}

// MARK:GET请求部分
- (void)getJosonWithURLString:(NSString *)URLString parameters:(id )parameters success:(void(^)(id))success fail:(void(^)(NSError*))fail {
    
    // request GET
    [self.requestManager getJosonWithURLString:URLString parameters:parameters success:^(id dic) {
        if (success) {
            success(dic);
        }
    } fail:^(NSError *error) {
        if(fail){
            fail(error);
        }
    }];
}

- (void)postJsonWithURLString:(NSString *)URLString parameters:(id)parameters success:(void(^)(id))success fail:(void(^)(NSError*))fail {

    [self.requestManager postJsonWithURLString:URLString parameters:parameters success:^(id dic) {
        if (success) {
            success(dic);
        }
    } fail:^(NSError *error) {
        if(fail){
            fail(error);
        }
    }];
}

@end
