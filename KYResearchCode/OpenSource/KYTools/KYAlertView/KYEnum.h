//
//  KYEnum.h
//  KYResearchCode
//
//  Created by iOS Developer 3 on 16/12/14.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#ifndef KYEnum_h
#define KYEnum_h

/**
 *
 *  点击样式
 */
typedef NS_ENUM(NSInteger, MyWindowClick){
    /**
     *
     *  @点击确定按钮
     */
    MyWindowClickForOK = 0,
    /**
     *
     *  @点击取消按钮
     */
    MyWindowClickForCancel
};


typedef NS_ENUM(NSInteger, KYAlertViewNoticStyle)
{
    KYAlertViewNoticStyleClassic ,//经典提示 默认
    KYAlertViewNoticStyleFace//小人脸提示
};



/**
 *
 *  @提示框显示样式
 */
typedef NS_ENUM(NSInteger, KYAlertViewStyle)
{
    /**
     *
     *  默认样式——成功
     */
    KYAlertViewStyleDefalut = 0,
    /**
     *  成功
     */
    KYAlertViewStyleSuccess,//成功
    /**
     *  失败
     */
    KYAlertViewStyleFail,//失败
    /**
     *  警告
     */
    KYAlertViewStyleWaring//警告
};


#endif /* KYEnum_h */
