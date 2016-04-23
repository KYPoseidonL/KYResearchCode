//
//  KYUtility.m
//  KYStudyDemo
//
//  Created by KYPoseidonL on 16/4/9.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "KYUtility.h"

@implementation KYUtility

+ (id)findSubViewOfClass:(Class)aClass inView:(UIView *)view {
    
    for (id subView in view.subviews) {
        DDLogDebug(@"%@", [subView class]);
        if ([subView isKindOfClass:aClass]) {
            return  subView;
        } else {
            
            id view = [self findSubViewOfClass:aClass inView:subView];
            if (view) {
                return view;
            }
        }
    }
    return nil;
}

+ (BOOL)validateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)validateMobile:(NSString *)mobile {
    
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)validateUserName:(NSString *)name {
    
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

+ (BOOL)validatePassword:(NSString *)passWord {
    
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,12}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

+ (BOOL)validateIdentityCard:(NSString *)identityCard {
    
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (BOOL)validateCount:(NSString *)count {
    
    NSString *countRegex = @"^[0-9]*$";
    NSPredicate *countTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", countRegex];
    return [countTest evaluateWithObject:count];
    
}

+ (BOOL)validateURL:(NSString *)URL {
    
    NSString *URLRegex1 = @"^\\w+((\\-\\w+)|(\\.\\w+))*@[A-Za-z0-9]+((\\.|\\-)[A-Za-z0-9]+)*.[A-Za-z0-9]+$";
    NSPredicate *URLTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", URLRegex1];
    
    NSString *URLRegex2 = @"http+:[^\\s]*";
    NSPredicate *URLTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", URLRegex2];
    if ([URLTest1 evaluateWithObject:URL] == YES || [URLTest2 evaluateWithObject:URL] == YES) {
        
        return YES;
    }else {
        
        return NO;
    }
}

@end
