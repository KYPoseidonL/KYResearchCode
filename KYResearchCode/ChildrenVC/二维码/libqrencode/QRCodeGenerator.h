//
//  QRCodeGenerator.h
//  FeimaoBijia_4.0
//
//  Created by iOS Developer 2 on 15/6/16.
//  Copyright (c) 2015年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 自定义枚举
typedef enum {
    QRPointRect = 0,
    QRPointRound
}QRPointType;

typedef enum {
    QRPositionNormal = 0,
    QRPositionRound
}QRPositionType;

@interface QRCodeGenerator : NSObject

/**之前的方法 */
+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size Topimg:(UIImage *)topimg;
+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size withPointType:(QRPointType)pointType withPositionType:(QRPositionType)positionType withColor:(UIColor *)color;

/**自己添加 */
+ (UIImage*)qrImageForString:(NSString *)string imageSize:(CGFloat)size Topimg:(UIImage *)topimg withColor:(UIColor*)color;

@end
