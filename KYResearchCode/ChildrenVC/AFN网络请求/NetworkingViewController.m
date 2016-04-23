//
//  NetworkingViewController.m
//  KYStudyDemo
//
//  Created by iOS Developer 3 on 16/3/18.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "NetworkingViewController.h"
#import "HTTPRequestManager.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "AFHTTPSessionManager.h"

@interface NetworkingViewController ()

@end

@implementation NetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestData];
}

- (void)requestData {
    
    //分界线的标识符
//    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
//    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
//    
//    //分界线 --AaB03x
//    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
//    
//    //结束符 AaB03x--
//    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
//    //声明结束符：--AaB03x--
//    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
//    //body内容
//    NSMutableString *body=[NSMutableString stringWithString:@""];
//    /********************添加字段内容*************************/
//    ////添加分界线，换行
//    [body appendFormat:@"%@\r\n",MPboundary];
//    //声明pic字段，文件名为boris.png
//    [body appendFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n",[[NSBundle mainBundle] pathForResource:@"Default-Portrait" ofType:@"png"]];
//    //声明上传文件的格式
//    [body appendFormat:@"Content-Type:image/png\r\n\r\n"];
//    
//    UIImage *img=[UIImage imageNamed:@"Default-Portrait.png"];
//    /*********************发送请求的数据****************************/
//    NSMutableData *myRequestData=[NSMutableData data];
//    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
//    //添加图片
//    [myRequestData appendData:UIImagePNGRepresentation(img)];
//    //添加结束符
//    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    UIImage *postImg = [UIImage imageNamed:@"appIcon"];
    NSData *data = UIImagePNGRepresentation(postImg);
    NSDictionary *parameters = @{@"cmd" : @"uploadFile", @"destdir" : @"/AFN"};
    
    NSString *zipPath = [[NSBundle mainBundle] pathForResource:@"t" ofType:@"zip"];
    NSData *zipData = [[NSData alloc] initWithContentsOfFile:zipPath];

    NSURL *baseURL = [NSURL URLWithString:@"http://192.168.2.155:12345/"];
    AFHTTPSessionManager *httpManager = [[AFHTTPSessionManager manager] initWithBaseURL:baseURL];
    httpManager.requestSerializer.timeoutInterval = 30.f;
    httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [httpManager POST:@"upload.html" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"appIcon.png" mimeType:@"image/png"];
//        [formData appendPartWithFileData:zipData name:@"file" fileName:@"t.zip" mimeType:@"gzip"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    

}



@end
