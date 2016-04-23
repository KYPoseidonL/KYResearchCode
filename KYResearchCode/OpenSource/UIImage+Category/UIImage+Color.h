//
//  UIImage+Color.h
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY;

@end
