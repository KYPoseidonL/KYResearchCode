//
//  ShowCustomAnimationController.m
//  KYStudyDemo
//
//  Created by KYPoseidonL on 16/4/9.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "ShowCustomAnimationController.h"
#import "HaloImg.h"

#define kCoinOriginalRadius 10.f        //小球原来的半径
#define kSpreadRadius  20.f             //小球扩散的半径

@interface ShowCustomAnimationController ()
{
    BOOL _isChange;
}


@property (nonatomic,strong) HaloImg *coinView1;    //圆球从上到下
@property (nonatomic,strong) HaloImg *coinView2;    //圆球从左到右

@end

@implementation ShowCustomAnimationController

- (void)viewDidLoad {

    [super viewDidLoad];


    [self setup];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    _isChange = !_isChange;
    
    if (_isChange) {

        [self.coinView1 dismiss];
        _coinView1 = nil;
        [self coinView2];
        
    } else {
    
        [self.coinView2 dismiss];
        _coinView2 = nil;
        [self coinView1];
    }
}

@end
