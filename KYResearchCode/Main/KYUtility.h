//
//  KYUtility.h
//  KYStudyDemo
//
//  Created by KYPoseidonL on 16/4/9.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface KYUtility : NSObject

/**
 *  在父视图中找指定类名的子视图对象
 *
 *  @param aClass 指定的类名
 *  @param view   父视图
 *
 *  @return 子视图对象
 */
+ (id)findSubViewOfClass:(Class)aClass inView:(UIView *)view;

/**
 *  邮箱验证
 *
 *  @param email 邮箱
 *
 *  @return YES:是邮箱 NO:不是邮箱
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 *  手机号码验证
 *
 *  @param mobile 手机号
 *
 *  @return YES或NO
 */
+ (BOOL)validateMobile:(NSString *)mobile;

/**
 *  用户名验证
 *
 *  @param name 用户名
 *
 *  @return YES或NO
 */
+ (BOOL)validateUserName:(NSString *)name;

/**
 *  密码验证
 *
 *  @param passWord 密码
 *
 *  @return YES或NO
 */
+ (BOOL)validatePassword:(NSString *)passWord;

/**
 *  身份证号验证
 *
 *  @param identityCard 身份证号
 *
 *  @return YES或NO
 */
+ (BOOL)validateIdentityCard:(NSString *)identityCard;

/**
 *  数字验证
 *
 *  @param count 数字
 *
 *  @return YES或NO
 */
+ (BOOL)validateCount:(NSString *)count;

/**
 *  URL地址验证
 *
 *  @param URL URL地址
 *
 *  @return YES或NO
 */
+ (BOOL)validateURL:(NSString *)URL;

@end
