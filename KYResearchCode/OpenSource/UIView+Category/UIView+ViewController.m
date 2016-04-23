//
//  UIView+ViewController.m
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)


- (UIViewController *)ViewController
{
    UIResponder *next = [self nextResponder];
    
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}
@end
