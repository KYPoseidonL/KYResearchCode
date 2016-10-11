//
//  ChatModel.m
//  KYResearchCode
//
//  Created by iOS Developer 3 on 16/10/11.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "ChatModel.h"

@implementation ChatModel

+ (instancetype)modelWithIcon:(NSString *)icon time:(NSString *)time message:(NSString *)message type:(ChatType)type {
    ChatModel *model = [[ChatModel alloc] init];
    model.icon       = icon;
    model.time       = time;
    model.message    = message;
    model.type       = type;
    return model;
}

@end
