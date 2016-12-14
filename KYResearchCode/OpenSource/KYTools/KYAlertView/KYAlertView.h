//
//  KYAlertView.h
//  KYResearchCode
//
//  Created by iOS Developer 3 on 16/12/14.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KYEnum.h"

/**
 *  @Author wang kun
 *
 *  点击效果
 *
 *  @param buttonIndex 样式
 */
typedef void (^callBack)(MyWindowClick buttonIndex);



@protocol KYAlertViewDelegate <NSObject>

- (void)alertViewClick:(KYAlertViewStyle)type;

@end


@interface KYAlertView : UIView

@property (nonatomic, copy) callBack clickBlock ;/// 按钮点击事件的回调
@property (nonatomic, assign) id <KYAlertViewDelegate> KYAlertViewDelegate;
@property (nonatomic, assign) KYAlertViewNoticStyle noticStyle;

+ (instancetype)shared;
- (void)show;
/**
 *
 *  创建AlertView并展示
 *
 *  @param style    绘制的图片样式
 *  @param noticStyle 提示动画样式——现有两种经典、小人
 *  @param title    警示标题
 *  @param detail   警示内容
 *  @param canle    取消按钮标题
 *  @param ok       确定按钮标题
 *  @param callBack 按钮点击时间回调
 *
 *  @return AlertView
 */
+ (instancetype)showAlertViewWithStyle:(KYAlertViewStyle)style
                            noticStyle:(KYAlertViewNoticStyle)noticStyle
                                 title:(NSString *)title
                                detail:(NSString *)detail
                      canleButtonTitle:(NSString *)canle
                         okButtonTitle:(NSString *)ok
                             callBlock:(callBack)callBack;

+ (instancetype)showAlertViewWithStyle:(KYAlertViewStyle)style
                                 title:(NSString *)title
                                detail:(NSString *)detail
                      canleButtonTitle:(NSString *)canle
                         okButtonTitle:(NSString *)ok
                             callBlock:(callBack)callBack;


/// 默认样式创建AlertView
+ (instancetype)showAlertViewWithTitle:(NSString *)title detail:(NSString *)detail canleButtonTitle:(NSString *)canle okButtonTitle:(NSString *)ok callBlock:(callBack)callBack;

+ (instancetype)showAlertViewWithStyle:(KYAlertViewStyle)style title:(NSString *)title detail:(NSString *)detail canleButtonTitle:(NSString *)canle okButtonTitle:(NSString *)ok delegate:(id<KYAlertViewDelegate>)delegate;


@end

