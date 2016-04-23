//
//  AppListCell.m
//  KYStudyDemo
//
//  Created by iOS Developer 3 on 16/3/4.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "AppListCell.h"

#import "AppModel.h"

@implementation AppListCell

- (void)setModel:(AppModel *)model {

    if (_model != model) {
        _model = model;
    }
    
    self.appNameLabel.text = _model.appName;
    self.budleIdLabel.text = _model.bundleId;
    self.versionLabel.text = _model.version;
  
    NSURL *url =[NSURL URLWithString:@"http://assets.sbnation.com/assets/2512203/dogflops.gif"];
    [self.appIconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"appIcon"]];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        NSURL *url =[NSURL URLWithString:@"http://assets.sbnation.com/assets/2512203/dogflops.gif"];
//        NSData *data2 = [NSData dataWithContentsOfURL:url];
//        UIImage *image = [UIImage sd_animatedGIFWithData:data2];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.appIconImageView.image = image;
//        });
//        
//    });
}

@end
