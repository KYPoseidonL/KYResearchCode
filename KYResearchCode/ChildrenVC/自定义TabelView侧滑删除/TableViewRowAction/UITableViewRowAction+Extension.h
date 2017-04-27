//
//  UITableViewRowAction+Extension.h
//  UITableViewRowAction+Extension
//


#import <UIKit/UIKit.h>

@interface UITableViewRowAction (Extension)

@property (nonatomic, strong, nullable) UIImage *image;

@property (nonatomic, assign) BOOL enabled;

+ (nonnull instancetype)rowActionWithStyle:(UITableViewRowActionStyle)style image:(nullable UIImage *)image handler:(nullable void (^)(UITableViewRowAction * _Nullable action, NSIndexPath * _Nullable indexPath))handler;

@end
