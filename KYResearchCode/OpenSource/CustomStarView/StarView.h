//
//  StarView.h
//

#import <UIKit/UIKit.h>

@interface StarView : UIView
{
    UIView *_yellowView;//黄色星星
    UIView *_grayView;//灰色星星
}
@property (nonatomic,assign)CGFloat rating;//评分
@end
