//
//  CircleLayer.h
//  KYLoadingAnimation
//
//  Created by iOS Developer 3 on 16/6/20.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CircleLayer : CAShapeLayer

/**
 *  Expend animation for circle layer
 */
- (void)expand;

/**
 *  Wobble group animation
 */
- (void)wobbleAnimation;

/**
 *  Contract animation for circle layer
 */
- (void)contract;

@end
