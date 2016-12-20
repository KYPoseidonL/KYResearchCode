//
//  HomeUpsideFistView.m
//  HimamaUPLY
//
//  Created by majiancheng on 16/6/24.
//  Copyright © 2016年 HimamaChridren. All rights reserved.
//

#import "HomeUpsideFistView.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define  PROGREESS_WIDTH 240 * AUTOSIZE_SCALE_X  //圆直径
#define  OUTPROGREESS_WIDTH 260 * AUTOSIZE_SCALE_X  //圆直径
#define PROGRESS_LINE_WIDTH 10 * AUTOSIZE_SCALE_X //弧线的宽度

@implementation HomeUpsideFistView{

    CAShapeLayer *_trackLayer;   //圆Layer
    CAShapeLayer *_progressLayer; //进度Layer
    double add;
    
    NSTimer *_timer;

}

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
     
        //加载子视图
        self.backgroundColor = [UIColor clearColor];
        self.imagebackView = [[UIImageView alloc] init];
        self.imagebackView.frame = self.frame;
        self.imagebackView.image = [UIImage imageNamed:@"home_topbackimage"];
        [self addSubview:self.imagebackView];
        [self creatViews];
        
        [self setUpCircle];
        
        [self setUpSubViews];
        
    }
    return self;
}

- (void)setUpSubViews{
    
//    [self setQuertView];
    
}

//圆内的视图
- (void)setQuertView{
    
    
    UIView *quartView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, PROGREESS_WIDTH/2, PROGREESS_WIDTH/2)];
    [self addSubview:quartView];
    quartView.center = CGPointMake(85, 85);
    
    
    _percent = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, quartView.width, quartView.height*1/3)];
    _percent.textAlignment = NSTextAlignmentCenter;
    _percent.textColor = [UIColor colorWithHexString:@"929292"];
//    _percent.text = @"56%";
    _percent.font = [UIFont boldSystemFontOfSize:26.0];
    [quartView addSubview:_percent];
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(0, quartView.height/2, quartView.width, 2)];
    _line.backgroundColor = [UIColor colorWithHexString:@"A2A2A2" alpha:0.27];
    [quartView addSubview:_line];
    
    _finaceProgress = [[UILabel alloc] initWithFrame:CGRectMake(0, quartView.height*2/3 -5, quartView.width, quartView.height/3)];
    _finaceProgress.textColor = [UIColor colorWithHexString:@"929292"];
    _finaceProgress.textAlignment = NSTextAlignmentCenter;
//    _finaceProgress.text = @"投资进度";
    _finaceProgress.font = [UIFont systemFontOfSize:12.0];
    [quartView addSubview:_finaceProgress];
    
}

- (void)setUpCircle{
    
    _trackLayer = [CAShapeLayer layer];//创建一个track shape layer
//    _trackLayer.backgroundColor = [UIColor yellowColor].CGColor;
    _trackLayer.frame = self.bounds;
    [self.layer addSublayer:_trackLayer];
    //填充园的颜色
    _trackLayer.fillColor = [[UIColor clearColor] CGColor];
    //底部线条的颜色
    _trackLayer.strokeColor = [UIColor whiteColor].CGColor;
    _trackLayer.opacity = 1.f; //背景同学你就甘心做背景吧，不要太明显了，透明度小一点
    _trackLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _trackLayer.lineWidth = 23.f * AUTOSIZE_SCALE_X;//PROGRESS_LINE_WIDTH;//线的宽度
    
    /**
     *  center 是设置中心点位置
     *  radius 是半径距离
     *  startAngle  开始的角度
     *  endAngle    结束的角度
     *  clockwise   倒时针还是逆时针  NO ,顺时针  YES,逆时针
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.f, 230.f * AUTOSIZE_SCALE_X) radius:(PROGREESS_WIDTH - PROGRESS_LINE_WIDTH)/2 startAngle:degreesToRadians(130) endAngle:degreesToRadians(360 + 50) clockwise:YES];//上面说明过了用来构建圆形
    _trackLayer.path =[path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。

    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor  = [UIColor colorWithHexString:@"FFb675"].CGColor;
    
    
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = PROGRESS_LINE_WIDTH;
    _progressLayer.path = [path CGPath];
    [self.layer addSublayer:_progressLayer];
    
    add = 0.1;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(circleAnimationTypeOne)
                                            userInfo:nil
                                             repeats:YES];
    
    //画第一个线
    CAShapeLayer *myLayerOne = [CAShapeLayer layer];//创建一个track shape layer
    myLayerOne.frame = self.bounds;
    UIBezierPath *pathLine = [[UIBezierPath alloc] init];
    [pathLine addArcWithCenter:CGPointMake(self.width / 2.f, 230.f * AUTOSIZE_SCALE_X)
                        radius:((PROGREESS_WIDTH - PROGRESS_LINE_WIDTH)/2 + _trackLayer.lineWidth / 2.f)
                startAngle:degreesToRadians(128)
                  endAngle:degreesToRadians(130+100)
                 clockwise:YES];
    myLayerOne.lineWidth = 2.5f;
    myLayerOne.fillColor = [UIColor clearColor].CGColor;
    myLayerOne.strokeColor  = [[UIColor colorWithHexString:@"b6ff91"]CGColor];
    myLayerOne.path =[pathLine CGPath];

    [self.layer addSublayer:myLayerOne];
    
    
    //画第一个黄色的点
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 6.f, 6.f)];
    view.center = pathLine.currentPoint;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 3.f;
    view.backgroundColor = [UIColor colorWithHexString:@"fffc33"];
    [self addSubview:view];
    
    
    
    //画第二个线
    CAShapeLayer *myLayerTwo = [CAShapeLayer layer];//创建一个track shape layer
    myLayerTwo.frame = self.bounds;
    UIBezierPath *pathLineTwo = [[UIBezierPath alloc] init];
    [pathLineTwo addArcWithCenter:CGPointMake(self.width / 2.f, 230.f * AUTOSIZE_SCALE_X)
                        radius:((PROGREESS_WIDTH - PROGRESS_LINE_WIDTH)/2 + _trackLayer.lineWidth / 2.f)
                    startAngle:degreesToRadians(130+100)
                      endAngle:degreesToRadians(130+100+40)
                     clockwise:YES];
    myLayerTwo.lineWidth = 2.5f;
    myLayerTwo.fillColor = [UIColor clearColor].CGColor;
    myLayerTwo.strokeColor  = [[UIColor colorWithHexString:@"fffc33"]CGColor];
    myLayerTwo.path =[pathLineTwo CGPath];
    [self.layer addSublayer:myLayerTwo];
    
    
    //画第二个红色的点
    UIView *viewTwo = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 6.f, 6.f)];
    viewTwo.center = pathLineTwo.currentPoint;
    viewTwo.layer.masksToBounds = YES;
    viewTwo.layer.cornerRadius = 3.f;
    viewTwo.backgroundColor = [UIColor colorWithHexString:@"ff798b"];
    [self addSubview:viewTwo];
  
    
    
    //第三个线
    CAShapeLayer *myLayerThree = [CAShapeLayer layer];//创建一个track shape layer
    myLayerThree.frame = self.bounds;
    UIBezierPath *pathLineThree = [[UIBezierPath alloc] init];
    [pathLineThree addArcWithCenter:CGPointMake(self.width / 2.f, 230.f * AUTOSIZE_SCALE_X)
                           radius:((PROGREESS_WIDTH - PROGRESS_LINE_WIDTH)/2 + _trackLayer.lineWidth / 2.f)
                       startAngle:degreesToRadians(130+100+40)
                         endAngle:degreesToRadians(360 + 50)
                        clockwise:YES];
    myLayerThree.lineWidth = 2.5f;
    myLayerThree.fillColor = [UIColor clearColor].CGColor;
    myLayerThree.strokeColor  = [[UIColor colorWithHexString:@"ff798b"]CGColor];
    myLayerThree.path =[pathLineThree CGPath];
    [self.layer addSublayer:myLayerThree];
    
//    NSLog(@"%@",NSStringFromCGPoint(pathLineThree.currentPoint));
    
    
    //画最外圈文字的线
    CAShapeLayer *outSideLayerOne = [CAShapeLayer layer];//创建一个track shape layer
    outSideLayerOne.frame = self.bounds;
    UIBezierPath *pathOutLine = [[UIBezierPath alloc] init];
    [pathOutLine addArcWithCenter:CGPointMake(self.width / 2.f, 230.f * AUTOSIZE_SCALE_X)
                        radius:((OUTPROGREESS_WIDTH - PROGRESS_LINE_WIDTH)/2 + _trackLayer.lineWidth / 2.f)
                    startAngle:degreesToRadians(130)
                      endAngle:degreesToRadians(360+50)
                     clockwise:YES];
    outSideLayerOne.lineWidth = 0.f;
    outSideLayerOne.fillColor = [UIColor clearColor].CGColor;
    outSideLayerOne.strokeColor  = [[UIColor whiteColor]CGColor];
    outSideLayerOne.path =[pathOutLine CGPath];
    
    [self.layer addSublayer:outSideLayerOne];
    
    
    NSArray *arrayTitle = @[@"35℃",@"36℃",@"37℃",@"38℃",@"39℃",@"40℃",@"41℃",@"42℃"];
    NSArray *arrayColor = @[[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor],[UIColor colorWithHexString:@"fffc33"],[UIColor colorWithHexString:@"fffc33"],[UIColor colorWithHexString:@"ff788b"],[UIColor colorWithHexString:@"ff788b"],[UIColor colorWithHexString:@"ff788b"]];
  
    //35℃
    
    for (int i = 0; i < arrayTitle.count; i++) {
        
        int startAngle;
        
        if (i == 0) {
            startAngle = 135;
        }else if(i == 7){
            startAngle = 125;
        }else{
            startAngle = 130;
        }
        UIBezierPath *pathOutLineOne = [[UIBezierPath alloc] init];
        [pathOutLineOne addArcWithCenter:CGPointMake(self.width / 2.f, 230.f * AUTOSIZE_SCALE_X)
                                  radius:((OUTPROGREESS_WIDTH - PROGRESS_LINE_WIDTH)/2 + _trackLayer.lineWidth / 2.f)
                              startAngle:degreesToRadians(startAngle + i * 40)
                                endAngle:degreesToRadians(startAngle + i * 40)
                               clockwise:YES];
        
        NSLog(@"%@",NSStringFromCGPoint(pathOutLineOne.currentPoint));
        UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 40.f, 40.f)];
        labelOne.center = pathOutLineOne.currentPoint;
        labelOne.text = arrayTitle[i];
        labelOne.textColor = arrayColor[i];
        labelOne.textAlignment = NSTextAlignmentCenter;
        labelOne.font = [UIFont boldSystemFontOfSize:14.f * AUTOSIZE_SCALE_X];
        labelOne.transform = CGAffineTransformMakeRotation(degreesToRadians((-140 + i * 40)));;
        [self addSubview:labelOne];
    }
    

    
}
- (void)circleAnimationTypeOne
{
    add+= add;
    double end = .3;
    
    if (add >=end) {
        add = end;
        _progressLayer.strokeEnd = add;
        [_timer invalidate];
    }
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd = add;
}


- (void)creatViews{
    
    //左边的提示图标
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13.f, 40.f, 0.f, 0.f)];
    UIImage *image = [UIImage imageNamed:@"home_alert"];
    leftImageView.image = image;
    leftImageView.size = CGSizeMake(image.size.width, image.size.height);
    NSLog(@"leftImageView.size = %@",NSStringFromCGSize(leftImageView.size));
    [self addSubview:leftImageView];
    
    //中间的label标签
    UILabel *babyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width / 2.f - 100.f, 40.f, 200.f, 40.f)];
    babyLabel.backgroundColor = [UIColor clearColor];
    babyLabel.text = @"宝宝体温仪";
    babyLabel.textAlignment = NSTextAlignmentCenter;
    babyLabel.textColor = [UIColor whiteColor];
    babyLabel.font = [UIFont boldSystemFontOfSize:18.f];
    [self addSubview:babyLabel];
    
    //右边的响铃设置按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *imageButton = [UIImage imageNamed:@"home_alert_set"];
    rightButton.frame = CGRectMake(kScreen_Width - (imageButton.size.width + 13.f), 40.f, imageButton.size.width, imageButton.size.height);
    [rightButton setImage:imageButton forState:UIControlStateNormal];
    [self addSubview:rightButton];
    
    
}
@end
