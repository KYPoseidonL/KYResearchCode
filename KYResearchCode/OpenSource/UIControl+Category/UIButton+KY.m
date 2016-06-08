//
//  UIControl+KY.m
//  KYResearchCode
//
//  Created by iOS Developer 3 on 16/6/8.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "UIButton+KY.h"

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_acceptedEventTime = "UIControl_acceptedEventTime";
@interface UIButton ()

@property (nonatomic, assign) NSTimeInterval uky_acceptedEventTime;   // 上次点击的时间

@end

@implementation UIButton (KY)


- (void)setUky_acceptedEventTime:(NSTimeInterval)uky_acceptedEventTime {

  objc_setAssociatedObject(self, UIControl_acceptedEventTime, @(uky_acceptedEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)uky_acceptedEventTime {

    return [objc_getAssociatedObject(self, UIControl_acceptedEventTime) doubleValue];
}

- (NSTimeInterval)uky_acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setUky_acceptEventInterval:(NSTimeInterval)uky_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(uky_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(__uky_sendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
}

- (void)__uky_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    
    if (NSDate.date.timeIntervalSince1970 - self.uky_acceptedEventTime < self.uky_acceptEventInterval) return;
    
    if (self.uky_acceptEventInterval > 0)
    {
        self.uky_acceptedEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    [self __uky_sendAction:action to:target forEvent:event];
}

@end
