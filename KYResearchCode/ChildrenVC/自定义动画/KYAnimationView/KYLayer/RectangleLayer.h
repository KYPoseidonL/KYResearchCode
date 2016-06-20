//
//  RectangleLayer.h
//  KYLoadingAnimation
//
//  Created by iOS Developer 3 on 16/6/20.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface RectangleLayer : CAShapeLayer

/**
 *  Change line stroke color with custon color
 *
 *  @param color custom color
 */
- (void)strokeChangeWithColor:(UIColor *)color;

@end
