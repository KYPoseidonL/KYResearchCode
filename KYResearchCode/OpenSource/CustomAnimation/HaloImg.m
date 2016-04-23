//
//  HaloImg.m
//

#import "HaloImg.h"
#import "PulsingHaloLayer.h"

@interface HaloImg()
@property (nonatomic,assign) CGPoint destination;
@property (nonatomic, strong) PulsingHaloLayer *halo;
@property (nonatomic,assign) CGRect startRect;
@property (nonatomic,assign) NSTimeInterval interval;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation HaloImg

- (PulsingHaloLayer *)halo
{
    if (!_halo) {
        _halo = [PulsingHaloLayer layer];
        _halo.radius = 25;
        _halo.animationDuration = 0.7;
        _halo.pulseInterval = 0;
        _halo.backgroundColor = [UIColor orangeColor].CGColor;
    }
    return _halo;
}


- (instancetype)initWithStarFrame:(CGRect)frame ToDestination:(CGPoint)destination WithImage:(NSString*)imageName
{
    if (self = [super init]) {
        self.destination = destination;
        self.startRect = frame;
        self.frame = frame;
        self.image = [UIImage imageNamed:imageName];
    }
    return self;
}


- (void)InsertedByView:(UIView*)view withInterval:(NSTimeInterval)interVal
{
    
    self.halo.position = self.center;
    if (self.radius) {
        self.halo.radius = self.radius;
    }
    if (self.haloColor) {
        self.halo.backgroundColor = self.haloColor.CGColor;
    }
    [view.layer insertSublayer:self.halo below:self.layer];

    if (interVal <0) {
        interVal = 0;
    }
    self.interval = interVal +2;
    
    self.timer = [NSTimer timerWithTimeInterval:self.interval target:self selector:@selector(fllow) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
    
}


- (void)fllow
{
    self.hidden = NO;
    self.halo.hidden = NO;
    self.halo.position = self.center;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.halo fire];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:(self.interval - 1.5) animations:^{
            
            CGRect rect = self.frame;
            rect.origin.x = self.destination.x;
            rect.origin.y = self.destination.y;
            self.frame = rect;
            self.halo.position = self.center;
        } completion:^(BOOL finished) {
            self.hidden = YES;
            self.halo.position = self.center;
            [self.halo fire];
            self.frame = self.startRect;
        }];
    });
}

- (void)dismiss
{
    [self removeFromSuperview];
    self.halo = nil;
    [self.timer invalidate];
}
@end
