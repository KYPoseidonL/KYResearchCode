//
//  ShowCustomAnimationController.m
//  KYStudyDemo
//
//  Created by KYPoseidonL on 16/4/9.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "ShowCustomAnimationController.h"
#import "HaloImg.h"
#import "KYAnimationView.h"
#import "UIColor+Hex.h"

#define kCoinOriginalRadius 10.f        //小球原来的半径
#define kSpreadRadius  20.f             //小球扩散的半径

@interface ShowCustomAnimationController ()<KYAnimatiomViewDelegate>
{
    BOOL _isChange;
}


@property (nonatomic,strong) HaloImg *coinView1;    //圆球从上到下
@property (nonatomic,strong) HaloImg *coinView2;    //圆球从左到右

@property (nonatomic, strong) KYAnimationView *animationView;

@end

@implementation ShowCustomAnimationController

- (void)viewDidLoad {

    [super viewDidLoad];


//    [self setup];
    
    [self createAnimationView];
}

- (HaloImg *)coinView1 {

    if (!_coinView1) {
        _coinView1 = [[HaloImg alloc] initWithStarFrame:CGRectMake(kScreen_Width/2.f-kCoinOriginalRadius, 250.f, 2*kCoinOriginalRadius, 2*kCoinOriginalRadius) ToDestination:CGPointMake(kScreen_Width/2.f, 400.f) WithImage:@"ball"];
        _coinView1.radius = kSpreadRadius;
        _coinView1.haloColor = [UIColor orangeColor];
        [_coinView1 InsertedByView:self.view withInterval:0];
        [self.view addSubview:_coinView1];
    }
    return _coinView1;
}

- (HaloImg *)coinView2 {
    
    if (!_coinView2) {
        _coinView2 = [[HaloImg alloc] initWithStarFrame:CGRectMake(20.f, 150.f, 2*kCoinOriginalRadius, 2*kCoinOriginalRadius) ToDestination:CGPointMake(kScreen_Width-40.f, 150.f) WithImage:@"ball"];
        _coinView2.radius = kSpreadRadius;
        _coinView2.haloColor = [UIColor orangeColor];
        [_coinView2 InsertedByView:self.view withInterval:0];
        [self.view addSubview:_coinView2];
    }
    return _coinView2;
}

- (void)setup {

    //动画展示
//    @weakify(self);
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        @strongify(self);
//    });
    
    [self coinView1];
    
    [self coinView2];
}

- (void)createAnimationView {
    
    CGFloat size = 100.0;
    self.animationView = [[KYAnimationView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - size/2, CGRectGetHeight(self.view.frame)/2 - size/2, size, size)];
    _animationView.delegate = self;
    _animationView.parentFrame = self.view.frame;
    [self.view addSubview:_animationView];
}

- (void)completeAnimation {
    
    [_animationView removeFromSuperview];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#40e0b0"];
    
    // 2
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:50.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Welcome";
    label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25);
    [self.view addSubview:label];
    
    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        label.transform = CGAffineTransformScale(label.transform, 4.0, 4.0);
        
    } completion:^(BOOL finished) {
        [self addTouchButton];
    }];
}

- (void)addTouchButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick {
    self.view.backgroundColor = [UIColor whiteColor];
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    self.animationView = nil;
    [self createAnimationView];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    _isChange = !_isChange;
//    
//    if (_isChange) {
//
//        [self.coinView1 dismiss];
//        _coinView1 = nil;
//        [self coinView2];
//        
//    } else {
//    
//        [self.coinView2 dismiss];
//        _coinView2 = nil;
//        [self coinView1];
//    }
//}

@end
