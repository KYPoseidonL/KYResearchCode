//
//  HaloImg.h
//

#import <UIKit/UIKit.h>

@interface HaloImg : UIImageView

/**
 * halo扩散的范围,默认为25
 */
@property (nonatomic,assign) CGFloat radius;
/**
 *  halo的背景颜色，默认为橙色
 */
@property (nonatomic,assign) UIColor *haloColor;

/**
 *  初始化一个带有duangduang效果的动画imageView
 *
 *  @param frame       起始位置frame
 *  @param destination 终点位置
 *  @param imageName   需要显示的图片名
 *
 *  @return haloImG
 */
- (instancetype)initWithStarFrame:(CGRect)frame ToDestination:(CGPoint)destination WithImage:(NSString*)imageName;

/**
 *  将halo图层插入到view中,在初始化后调用
 *
 *  @param view     动画所在的view
 *  @param interVal 动画速度，interVal值越小越快，最小为0
 */
- (void)InsertedByView:(UIView*)view withInterval:(NSTimeInterval)interVal;


/**
 *  解除动画
 */
- (void)dismiss;
@end
