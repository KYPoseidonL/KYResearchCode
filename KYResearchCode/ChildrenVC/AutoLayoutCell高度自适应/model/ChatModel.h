//
//  ChatModel.h
//  KYResearchCode
//
//  Created by iOS Developer 3 on 16/10/11.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  聊天消息类型
 */
typedef NS_ENUM(NSInteger, ChatType) {
    /**
     *  别人发的
     */
    ChatTypeOther,
    /**
     *  自己发的
     */
    ChatTypeSelf
};

@interface ChatModel : NSObject

@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *message;
@property (assign, nonatomic) ChatType type;

+ (instancetype)modelWithIcon:(NSString *)icon
                         time:(NSString *)time
                      message:(NSString *)message
                         type:(ChatType)type;

@end
