//
//  StarView.m
//

#import "StarView.h"

@implementation StarView

- (instancetype) initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//主背景颜色为透明
        [self _creatView];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];//主背景颜色为透明
    [self _creatView];
}

- (void)_creatView {

    //创建灰黄星星
    UIImage *yellowImg = [UIImage imageNamed:@"StarsForeground"];//灰星星图片
    UIImage *grayImg = [UIImage imageNamed:@"StarsBackground"];//黄星星图片
    
    _grayView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, grayImg.size.width * 5.f, grayImg.size.height)];//灰星星图片frame
    _grayView.backgroundColor = [UIColor colorWithPatternImage:grayImg];//灰星星图片背景颜色
    [self addSubview:_grayView];//加载灰星星图片
    
    _yellowView= [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, yellowImg.size.width * 5.f, yellowImg.size.height)];//黄星星图片frame
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImg];//黄星星图片背景颜色
    [self addSubview:_yellowView];//加载黄星星图片

    //    计算缩放倍数
    CGFloat scale = self.frame.size.height / yellowImg.size.height;
    
    //放大倍数
    CGAffineTransform t = CGAffineTransformMakeScale(scale, scale);//高宽同比例缩放
    
    _grayView.transform = t;
    
    _yellowView.transform = t;

    //星星视图修改transform后，坐标会被改变，重新恢复坐标
    _yellowView.origin = CGPointZero;
    _grayView.origin = CGPointZero;
}

- (void)setRating:(CGFloat)rating {
    
    if (_rating != rating) {
        _rating = rating;
        CGFloat s = [self backFloatWithRatingFloat:_rating];
        CGFloat yellowWidth = s * self.frame.size.width;
        _yellowView.width = yellowWidth;//将比例后宽度设置为黄星星宽度
        
    }
}

//大于等于N.5的按N+1算，小于N.f按大于N按N.5算，等于N按N算（0 < N <5）
- (CGFloat) backFloatWithRatingFloat:(CGFloat)ratingFloat {

    if (ratingFloat == floorf(ratingFloat)) {
        
        return floorf(ratingFloat) / 5.f;
    }else if (ratingFloat > floorf(ratingFloat) && ratingFloat <= (floorf(ratingFloat) + 0.5)) {
        
        return (floorf(ratingFloat) + 0.5f) / 5.f;
    }else {
    
        return (floorf(ratingFloat) + 1.f) / 5.f;
    }
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    //创建灰黄星星
    UIImage *yellowImg = [UIImage imageNamed:@"StarsForeground"];//灰星星图片
    UIImage *grayImg = [UIImage imageNamed:@"StarsBackground"];//黄星星图片
    _grayView.backgroundColor = [UIColor colorWithPatternImage:grayImg];//灰星星图片背景颜色
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImg];//黄星星图片背景颜色
}

@end
