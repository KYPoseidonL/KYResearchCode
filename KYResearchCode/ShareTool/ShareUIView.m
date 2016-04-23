//
//  ShareUIView.m
//  FeimaoBijia_4.0
//
//  Created by iOS Developer 2 on 15/6/17.
//  Copyright (c) 2015年 Joey. All rights reserved.
//

#import "ShareUIView.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#define BaseURL @"http://www.feimaor.com/sharefm.action?name="
@interface ShareUIView ()


@end

@implementation ShareUIView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4f];
        self.cancelButton.layer.borderColor = [UIColor whiteColor].CGColor;
        self.cancelButton.layer.cornerRadius = 20.f;//圆角半径
        self.cancelButton.layer.masksToBounds = YES;
        
        _weixinFriend.userInteractionEnabled = YES;
        _weixinCicle.userInteractionEnabled = YES;
        _sinaWeibo.userInteractionEnabled = YES;
        _QQFriend.userInteractionEnabled = YES;
        _QQZone.userInteractionEnabled = YES;
       
    }
    return self;
}

- (void) layoutSubviews {
   
    if ([QQApiInterface isQQInstalled] == YES && [WXApi isWXAppInstalled] == YES) {
        
        _BgBottomViewHeight.constant = 244.f;
        _weiboLeft.constant = 0;
        _QQFriend.hidden = NO;
        _QQZone.hidden = NO;
        _weixinCicle.hidden = NO;
        _weixinFriend.hidden = NO;
        
    }else if ([QQApiInterface isQQInstalled] == YES && [WXApi isWXAppInstalled] == NO){
        _weiboLeft.constant = 0;
        _BgBottomViewHeight.constant = 160.f;
        _QQFriend.hidden = NO;
        _QQZone.hidden = NO;
        _weixinCicle.hidden = YES;
        _weixinFriend.hidden = YES;
    }else if ([QQApiInterface isQQInstalled] == NO && [WXApi isWXAppInstalled] == YES){
        _weiboLeft.constant = 0;
        _BgBottomViewHeight.constant = 160.f;
        _QQFriend.hidden = YES;
        _QQZone.hidden = YES;
        _weixinCicle.hidden = NO;
        _weixinFriend.hidden = NO;
    }else if ([QQApiInterface isQQInstalled] == NO && [WXApi isWXAppInstalled] == NO){
        _BgBottomViewHeight.constant = 160.f;
        _weiboLeft.constant = (kScreen_Width - _sinaWeibo.width) / 2.f;
        _QQFriend.hidden = YES;
        _QQZone.hidden = YES;
        _weixinCicle.hidden = YES;
        _weixinFriend.hidden = YES;
    }

    
    [super layoutSubviews];
    
}
@end
