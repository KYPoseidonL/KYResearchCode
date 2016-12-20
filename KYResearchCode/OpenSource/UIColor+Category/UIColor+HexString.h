//
//  UIColor+HexString.h
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
