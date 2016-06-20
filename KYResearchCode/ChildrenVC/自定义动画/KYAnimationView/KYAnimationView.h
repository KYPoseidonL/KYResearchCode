//
//  KYAnimationView.h
//  KYLoadingAnimation
//
//  Created by iOS Developer 3 on 16/6/20.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KYAnimatiomViewDelegate <NSObject>

- (void)completeAnimation;

@end

@interface KYAnimationView : UIView

@property (assign, nonatomic) CGRect parentFrame;
@property (weak, nonatomic) id<KYAnimatiomViewDelegate>delegate;

@end
