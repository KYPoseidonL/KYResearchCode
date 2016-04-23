//
//  AppDelegate.m
//  KYResearchCode
//
//  Created by KYPoseidonL on 16/4/23.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()
{
    AVAudioPlayer *_audioPlayer;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];// 初始化DDLog日志输出，在这里，我们仅仅希望在xCode控制台输出
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];// 启用颜色区分
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:[UIColor clearColor] forFlag:DDLogFlagDebug];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor purpleColor] backgroundColor:[UIColor clearColor] forFlag:DDLogFlagWarning];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:[UIColor clearColor] forFlag:DDLogFlagError];
    
    DDLogDebug(@"DDLogDebug");
    DDLogError(@"DDLogError");
    DDLogWarn(@"DDLogWarn");
    DDLogInfo(@"DDLogInfo");
    
    [self setUpShareMethod];
    
    [[UINavigationBar appearance] setBarTintColor:kColor(kBackgroundColor)];
    
    return YES;
}

//播放背景音乐
- (void)playBackground {
    
    NSError *setCategoryErr = nil;
    NSError *activationErr  = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:kAudioSessionProperty_OverrideCategoryMixWithOthers error: &setCategoryErr];
    [[AVAudioSession sharedInstance] setActive:YES error: &activationErr];
    
    //播放背景音乐
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"background" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:musicPath];
    
    //创建播放器
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_audioPlayer prepareToPlay];
    [_audioPlayer setVolume:1];
    _audioPlayer.numberOfLoops = -1; //设置音乐播放次数  -1为一直循环
    [_audioPlayer play]; //播放
}


#pragma mark - 友盟分享
- (void)setUpShareMethod {
    
    [UMSocialData setAppKey:@"561dfd35e0f55a8fb900158c"];
    
    //设置微信AppId、appSecret，分享url
    //    [UMSocialWechatHandler setWXAppId:kUmengWXAPPID appSecret:kUmengWXAPPSecret url:kUmengFMURL];
    
    //设置分享到QQ/Qzone的应用Id，和分享url链接
    [UMSocialQQHandler setQQWithAppId:@"1104833205" appKey:@"vahQql3j37jHvVW3" url:@"http://www.baidu.com"];
    
    //隐藏没有客户端的APP图标
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone]];
    //打开新浪微博的SSO开关
    //    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://www.baidu.com"];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2286807427" secret:@"ce1c4539ae8a418d357650ac17855fa8" RedirectURL:@"http://www.baidu.com"];
}

#pragma mark - 添加友盟系统回调
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如新浪微博SDK等
    }
    return result;
}


@end
