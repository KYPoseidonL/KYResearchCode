//
//  KYHTTPSessionManager.m
//  ChargeHub
//
//  Created by iOS Developer 3 on 15/12/31.
//  Copyright © 2015年 KYPoseidonL. All rights reserved.
//

#import "HTTPSessionManager.h"

#define kBaseURL    @"http://192.168.2.155:12345/"
static HTTPSessionManager *_manager = nil;

@interface HTTPSessionManager ()

@property (nonatomic, strong) HTTPSessionManager *requestManager;

@end

@implementation HTTPSessionManager

+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *baseURL =  [kBaseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _manager = [[HTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
//        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain" ,@"application/json", @"text/json", @"text/javascript",@"text/html",@"image/png",@"image/jpeg", nil];
        _manager.requestSerializer.timeoutInterval = 30.f;
        NSString *TWITTERFON_FORM_BOUNDARY = @"----WIKIfadsfsfdfa";
        NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
        [_manager.requestSerializer setValue:content forHTTPHeaderField:@"Content-Type"];
    });
    
    return _manager;
}

- (HTTPSessionManager *)requestManager {
    
    if (!_requestManager) {
        _requestManager = [HTTPSessionManager sharedManager];
    }
    return _requestManager;
}

// MARK:GET请求部分
- (void)getJosonWithURLString:(NSString *)URLString parameters:(id )parameters success:(void(^)(id))success fail:(void(^)(NSError*))fail {
    
    // request GET
    [self.requestManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(fail){
            fail(error);
        }
    }];
    
}

- (void)postJsonWithURLString:(NSString *)URLString parameters:(id)parameters success:(void(^)(id))success fail:(void(^)(NSError*))fail {
    
    [self.requestManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(fail){
            fail(error);
        }
    }];
}

@end
