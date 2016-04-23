//
//  ShareUIView.h
//  FeimaoBijia_4.0
//
//  Created by iOS Developer 2 on 15/6/17.
//  Copyright (c) 2015年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ShareUIView : UIView
@property (weak, nonatomic) IBOutlet UIView             *shareHiddenView;
@property (weak, nonatomic) IBOutlet UIView             *shareBGView;

@property (weak, nonatomic) IBOutlet UIView             *sinaWeibo;
@property (weak, nonatomic) IBOutlet UIButton           *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *weixinFriend;
@property (weak, nonatomic) IBOutlet UIView *weixinCicle;
@property (weak, nonatomic) IBOutlet UIView *QQZone;
@property (weak, nonatomic) IBOutlet UIView *QQFriend;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BgBottomViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weiboLeft;


@end
