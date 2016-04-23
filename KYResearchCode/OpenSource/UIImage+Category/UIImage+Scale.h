//
//  UIImage+Scale.h
//

#import <Foundation/Foundation.h>

@interface UIImage (Scale)

+ (UIImage*)imageScaledWithImage:(UIImage*)image;
+ (UIImage*)emojiImageScaledWithImage:(UIImage*)image;
+ (UIImage *)snapshotView:(UIView *)view;//截屏
@end
