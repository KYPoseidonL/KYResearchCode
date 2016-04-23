//
//  AppListCell.h
//  KYStudyDemo
//
//  Created by iOS Developer 3 on 16/3/4.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppModel;
@interface AppListCell : UITableViewCell

@property (nonatomic, strong) AppModel *model;

@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *budleIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *appIconImageView;

@end
