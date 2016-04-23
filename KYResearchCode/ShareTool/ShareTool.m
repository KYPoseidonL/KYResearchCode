//
//  ShareTool.m
//  FeimaoBijia_4.0
//
//  Created by iOS Developer 3 on 15/7/4.
//  Copyright (c) 2015年 Joey. All rights reserved.
//

#import "ShareTool.h"
#define BaseURL @"http://www.feimaor.com/nsharefm.action?name="
@interface ShareTool ()<UMSocialUIDelegate>
{
    ShareUIView *_shareUIView;
}

@end

@implementation ShareTool

- (id)initWithViewController:(UIViewController *)contrl shareImage:(UIImage *)shareImage descpContent:(NSString *)descpContent {

    if (self=[super init]) {
        
        _contrl = contrl;
        _shareImage = shareImage;
        _descpContent = descpContent;
    }
    return self;
}

- (ShareUIView *)getShareViewWithShareTool {

    _shareUIView = [[[NSBundle mainBundle] loadNibNamed:@"ShareUIView" owner:self options:nil]lastObject];
    _shareUIView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height);
    _shareUIView.shareBGView.top = kScreen_Height;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    UITapGestureRecognizer *singleTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    [_shareUIView.weixinFriend addGestureRecognizer:singleTap1];
    [_shareUIView.weixinCicle addGestureRecognizer:singleTap2];
    [_shareUIView.sinaWeibo addGestureRecognizer:singleTap3];
    [_shareUIView.QQFriend addGestureRecognizer:singleTap4];
    [_shareUIView.QQZone addGestureRecognizer:singleTap5];

    [_shareUIView.cancelButton addTarget:self action:@selector(hiddenShareView) forControlEvents:UIControlEventTouchUpInside];
    return _shareUIView;
}
- (void) singleTapAction:(UITapGestureRecognizer *)sender {
    
    switch (sender.view.tag) {
            
        case 6100:[self _clickWeixinFriend];break;
        case 6101:[self _clickWeixinCicle] ;break;
        case 6102:[self _clickWeibo]       ;break;
        case 6103:[self _clickQQFriend]    ;break;
        case 6104:[self _clickQQZone]      ;break;
        default:break;
    }
}
- (void) _clickWeixinFriend {
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = [self getURL];
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"";
    [[UMSocialControllerService defaultControllerService] setShareText:[self getContent] shareImage:self.shareImage socialUIDelegate:self];        //设置分享内容和回调对象
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession].snsClickHandler(_contrl,[UMSocialControllerService defaultControllerService],YES);
    [self hiddenShareView];
    
}
- (void) _clickWeixinCicle {
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [self getURL];
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = nil;
    [[UMSocialControllerService defaultControllerService] setShareText:[self getContent] shareImage:self.shareImage socialUIDelegate:self];        //设置分享内容和回调对象
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline].snsClickHandler(_contrl,[UMSocialControllerService defaultControllerService],YES);
    [self hiddenShareView];
}
- (void) _clickWeibo {
    
    [[UMSocialControllerService defaultControllerService] setShareText:[NSString stringWithFormat:@"%@",[self descpContent]] shareImage:self.shareImage socialUIDelegate:self];        //设置分享内容和回调对象
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(_contrl,[UMSocialControllerService defaultControllerService],YES);
    [self hiddenShareView];
}
- (void) _clickQQFriend {
    [UMSocialData defaultData].extConfig.qqData.url = [self getURL];
    [UMSocialData defaultData].extConfig.qqData.title = @" ";
    [[UMSocialControllerService defaultControllerService] setShareText:[self getContent] shareImage:self.shareImage socialUIDelegate:self];        //设置分享内容和回调对象
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ].snsClickHandler(_contrl,[UMSocialControllerService defaultControllerService],YES);
    [self hiddenShareView];
    
}
- (void) _clickQQZone {
    
    [UMSocialData defaultData].extConfig.qzoneData.url = [self getURL];
    [UMSocialData defaultData].extConfig.qzoneData.title = @" ";
    [[UMSocialControllerService defaultControllerService] setShareText:[self getContent] shareImage:self.shareImage socialUIDelegate:self];        //设置分享内容和回调对象
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone].snsClickHandler(_contrl,[UMSocialControllerService defaultControllerService],YES);
    [self hiddenShareView];
}

-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData{
    
    if (platformName == UMShareToWechatSession) {

        NSDictionary *params = @{@"type":@([self getType]),@"sharech":@"3",[self getID]:[self getIDContent]};
//        [[FMHTTPReauestManager sharedFMHTTPReauestManager] securityPostJsonWithURLString:kShare parameter:params isForum:NO success:^(id dic) {
//            
//            if (![[dic[@"resCode"] stringValue] isEqualToString:@"0"]) {
//                [SVProgressHUD showInfoWithStatus:dic[RuquestErrorInformation]];
//            }
//            
//        } fail:^(NSError *error) {
//            
//            
//        }cancel:^{
//            
//        }];

    }else if (platformName == UMShareToWechatTimeline) {
    
        NSDictionary *params = @{@"type":@([self getType]),@"sharech":@"4",[self getID]:[self getIDContent]};
//        [[FMHTTPReauestManager sharedFMHTTPReauestManager] securityPostJsonWithURLString:kShare parameter:params isForum:NO success:^(id dic) {
//            
//            if (![[dic[@"resCode"] stringValue] isEqualToString:@"0"]) {
//                [SVProgressHUD showInfoWithStatus:dic[RuquestErrorInformation]];
//            }
//            
//        } fail:^(NSError *error) {
//            
//            
//        }cancel:^{
//            
//        }];

    }else if (platformName == UMShareToSina) {
        
        NSDictionary *params = @{@"type":@([self getType]),@"sharech":@"6",[self getID]:[self getIDContent]};
//        [[FMHTTPReauestManager sharedFMHTTPReauestManager] securityPostJsonWithURLString:kShare parameter:params isForum:NO success:^(id dic) {
//            
//            if (![[dic[@"resCode"] stringValue] isEqualToString:@"0"]) {
//                [SVProgressHUD showInfoWithStatus:dic[RuquestErrorInformation]];
//            }
//            
//        } fail:^(NSError *error) {
//            
//            
//        }cancel:^{
//            
//        }];
    }else if (platformName == UMShareToQQ) {
        
        NSDictionary *params = @{@"type":@([self getType]),@"sharech":@"1",[self getID]:[self getIDContent]};
//        [[FMHTTPReauestManager sharedFMHTTPReauestManager] securityPostJsonWithURLString:kShare parameter:params isForum:NO success:^(id dic) {
//            
//            if (![[dic[@"resCode"] stringValue] isEqualToString:@"0"]) {
//                [SVProgressHUD showInfoWithStatus:dic[RuquestErrorInformation]];
//            }
//            
//        } fail:^(NSError *error) {
//            
//            
//        }cancel:^{
//            
//        }];

        
    }else if (platformName == UMShareToQzone) {
        
        NSDictionary *params = @{@"type":@([self getType]),@"sharech":@"2",[self getID]:[self getIDContent]};
//        [[FMHTTPReauestManager sharedFMHTTPReauestManager] securityPostJsonWithURLString:kShare parameter:params isForum:NO success:^(id dic) {
//            
//            if (![[dic[@"resCode"] stringValue] isEqualToString:@"0"]) {
//                [SVProgressHUD showInfoWithStatus:dic[RuquestErrorInformation]];
//            }
//            
//        } fail:^(NSError *error) {
//            
//            
//        }cancel:^{
//            
//        }];

    }
}
//分享按钮点击事件
- (void)shareBtnMethod {

    [UIView animateWithDuration:0.25f animations:^{
        
        _shareUIView.shareBGView.bottom = kScreen_Height;
    }completion:^(BOOL finished) {
        
        UITapGestureRecognizer *singleHiddenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleHiddenTap:)];
        [_shareUIView.shareHiddenView addGestureRecognizer:singleHiddenTap];
    }];
}

#pragma mark - TapGestureRecognizer
- (void) singleHiddenTap:(UITapGestureRecognizer *)sender {
    
    [self hiddenShareView];
}

#pragma mark - ShareViewDelegate
- (void)hiddenShareViewMethod {
    
    [self hiddenShareView];
}

//隐藏分享视图
- (void)hiddenShareView {
    
    [UIView animateWithDuration:0.25f animations:^{
        
        _shareUIView.shareBGView.top = kScreen_Height;
    }completion:^(BOOL finished) {
        
        [_shareUIView removeFromSuperview];
        _shareUIView = nil;
    }];
    
}

- (NSString *)currentDateString {
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *currentDateComponent = [currentCalendar components:unitFlags fromDate:currentDate];
    NSString *currentDateString = [NSString stringWithFormat:@"_%ld%02ld%02ld", [currentDateComponent year], [currentDateComponent month], [currentDateComponent day]];
    
    return currentDateString;
}
- (NSString *)getURL {
    
    NSString *URL = nil;
//    AppDelegate *myDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSString *userJiaid = myDelegate.startInfoEntity.userInfoModel.jiaid;
//    
//    if ([_fromeWhere isEqualToString:@"FMParityViewController"]) {
//        
//        //比价
//        URL = [NSString stringWithFormat:@"%@g_%@%@&jiaid=%@",BaseURL,_goodId,[self currentDateString],userJiaid];
//    }else if ([_fromeWhere isEqualToString:@"PromotionGoodsListViewController"]) {
//        
//        //精促
//        URL = [NSString stringWithFormat:@"%@p_%@&jiaid=%@",BaseURL,_pdetailid,userJiaid];
//    }else if ([_fromeWhere isEqualToString:@"PromotionPostDetailViewController"]) {
//        
//        //海报
//        URL = [NSString stringWithFormat:@"%@d_%@&jiaid=%@",BaseURL,_pdmid,userJiaid];
//    }else if ([_fromeWhere isEqualToString:@"WebViewViewController"]) {
//        
//        //网页
//        URL = [self encodeToPercentEscapeString:_webURL];
//        URL = [NSString stringWithFormat:@"http://www.feimaor.com/nsharefm.action?jiaid=%@&url=%@",userJiaid,_webURL];
//    }else if ([_fromeWhere isEqualToString:@"FMPostController"]) {
//        
//        //帖子
//        URL = [NSString stringWithFormat:@"%@f_%@&jiaid=%@",BaseURL,_postId,userJiaid];
//    }else {
//        
//        URL = @"http://www.feimaor.com";
//    }
    return URL;
}
- (NSString *) getContent {
    
    NSString *content = nil;
    
    if ([_fromeWhere isEqualToString:@"FMParityViewController"]) {
        
        //比价
        content = [NSString stringWithFormat:@"快来围观!%@的最低价",_descpContent];
    }else if ([_fromeWhere isEqualToString:@"PromotionGoodsListViewController"]) {
        
        //精促
        content = [NSString stringWithFormat:@"超赞!%@正在打折促销",_descpContent];
    }else if ([_fromeWhere isEqualToString:@"PromotionPostDetailViewController"]) {
        
        //海报
        content = [NSString stringWithFormat:@"抢先!最新%@促销海报",_descpContent];
    }else if ([_fromeWhere isEqualToString:@"WebViewViewController"]) {
    
        //网页
        content = [NSString stringWithFormat:@"%@",_descpContent];
    }else if ([_fromeWhere isEqualToString:@"FMPostController"]) {
        
        //帖子
        if (_descpContent.length > 20) {
            
            _descpContent = [NSString stringWithFormat:@"%@...",[_descpContent substringToIndex:20]];
        };
        content = [NSString stringWithFormat:@"话题分享:%@",_descpContent];
    }else {
        
        content = _descpContent;
    }
    return content;
    
}
//对url 部分参数进行编码（注：无法对整个url进行编码）
- (NSString *)encodeToPercentEscapeString: (NSString *) input {
    NSString *outputStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                (CFStringRef)input,
                                                                                                NULL,
                                                                                                (CFStringRef)@".-!*'();:@&=+$,/?%#[]",
                                                                                                kCFStringEncodingUTF8));
    return outputStr;
}
- (NSInteger) getType {
    
    
    NSInteger type = 0;
    
    if ([_fromeWhere isEqualToString:@"FMParityViewController"]) {
        
        //比价
        type = 15;
    }else if ([_fromeWhere isEqualToString:@"PromotionGoodsListViewController"]) {
        
        //精促
        type = 16;
    }else if ([_fromeWhere isEqualToString:@"PromotionPostDetailViewController"]) {
        
        //海报
        type = 17;
    }else if ([_fromeWhere isEqualToString:@"WebViewViewController"]) {
        
        //网页
        type = 18;
    }else if ([_fromeWhere isEqualToString:@"FMPostController"]) {
        
        //帖子
        type = 19;
    }else {
        
        type = 0;
    }
    return type;
    
}
- (NSString *) getID {
    
    
    NSString *ID = nil;
    
    if ([_fromeWhere isEqualToString:@"FMParityViewController"]) {
        
        //比价
        ID = @"goodsid";
    }else if ([_fromeWhere isEqualToString:@"PromotionGoodsListViewController"]) {
        
        //精促
        ID = @"pdetailid";
    }else if ([_fromeWhere isEqualToString:@"PromotionPostDetailViewController"]) {
        
        //海报
        ID = @"pdmid";
    }else if ([_fromeWhere isEqualToString:@"WebViewViewController"]) {
        
        //网页
        ID = @"web";
    }else if ([_fromeWhere isEqualToString:@"FMPostController"]) {
        
        //帖子
        ID = @"postid";
    }else {
        
        ID = nil;
    }
    return ID;
    
}
- (NSString *) getIDContent {
    
    
    NSString *IDContent = nil;
    
    if ([_fromeWhere isEqualToString:@"FMParityViewController"]) {
        
        //比价
        IDContent = _goodId;
    }else if ([_fromeWhere isEqualToString:@"PromotionGoodsListViewController"]) {
        
        //精促
        IDContent = _pdetailid;
    }else if ([_fromeWhere isEqualToString:@"PromotionPostDetailViewController"]) {
        
        //海报
        IDContent = _pdmid;
    }else if ([_fromeWhere isEqualToString:@"WebViewViewController"]) {
        
        //网页
        IDContent = _webURL;
    }else if ([_fromeWhere isEqualToString:@"FMPostController"]) {
        
        //帖子
        IDContent = _postId;
    }else {
        
        IDContent = nil;
    }
    return IDContent;
    
}

@end
