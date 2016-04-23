//
//  ShareTool.h
//  FeimaoBijia_4.0
//
//  Created by iOS Developer 3 on 15/7/4.
//  Copyright (c) 2015年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareUIView.h"
@interface ShareTool : NSObject

@property (nonatomic, strong) UIImage *shareImage;  //分享图片
@property (nonatomic, copy) NSString *descpContent; //描述内容
@property (nonatomic, strong) UIViewController *contrl;
@property (nonatomic, copy) NSString *fromeWhere; //从哪个界面

//比价页
@property (nonatomic, copy) NSString *goodId; //goodId
//肥猫圈
@property (nonatomic, copy) NSString *postId; //postId
//精促
@property (nonatomic, copy) NSString *pdetailid; //精促id
//海报
@property (nonatomic, copy) NSString *pdmid;    //海报id
//网页
@property (nonatomic, copy) NSString *webURL;   //分享链接

- (id)initWithViewController:(UIViewController *)contrl shareImage:(UIImage *)shareImage descpContent:(NSString *)descpContent;

- (ShareUIView *)getShareViewWithShareTool;
- (void)shareBtnMethod;


@end
