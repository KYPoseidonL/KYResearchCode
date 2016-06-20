//
//  RectangleLayer.m
//  KYLoadingAnimation
//
//  Created by iOS Developer 3 on 16/6/20.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "RectangleLayer.h"

static const CGFloat KLineWidth = 5.0;

@interface RectangleLayer ()

@property (strong, nonatomic) UIBezierPath *rectangleFullPath;

@end

@implementation RectangleLayer

- (instancetype)init {
    if (self == [super init]) {
        self.fillColor = [UIColor clearColor].CGColor;
        self.lineWidth = KLineWidth;
        self.path = self.rectangleFullPath.CGPath;
    }
    return self;
}

- (UIBezierPath *)rectangleFullPath {
    if (!_rectangleFullPath) {
        _rectangleFullPath = [[UIBezierPath alloc] init];
        [_rectangleFullPath moveToPoint:CGPointMake(0.0, 100.0)];
        [_rectangleFullPath addLineToPoint:CGPointMake(0.0, -KLineWidth)];
        [_rectangleFullPath addLineToPoint:CGPointMake(100.0, -KLineWidth)];
        [_rectangleFullPath addLineToPoint:CGPointMake(100.0, 100.0)];
        [_rectangleFullPath addLineToPoint:CGPointMake(-KLineWidth / 2, 100.0)];
        [_rectangleFullPath closePath];
    }
    return _rectangleFullPath;
}

- (void)strokeChangeWithColor:(UIColor *)color {
    self.strokeColor = color.CGColor;
    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnimation.fromValue = @0.0;
    strokeAnimation.toValue = @1.0;
    strokeAnimation.duration = 0.4;
    [self addAnimation:strokeAnimation forKey:nil];
}

@end
