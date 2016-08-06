//
//  TaskModel.m
//  KYResearchCode
//
//  Created by KYPoseidonL on 16/8/6.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "TaskModel.h"

@implementation TaskListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{ @"taskId" : @"taskid" };
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"taskId: %@, buy: %@, taskicon: %@, title: %@, limitnum: %@, points: %@, bundleId: %@", self.taskId, self.buy, self.taskicon, self.title, self.limitnum, self.points, self.bundleId];
}

@end

@implementation TaskResContent

+ (NSDictionary *)mj_objectClassInArray {

    return @{ @"tasklist" : [TaskListModel class] };
}

@end

@implementation TaskModel

@end
