//
//  TaskModel.h
//  KYResearchCode
//
//  Created by KYPoseidonL on 16/8/6.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskListModel : NSObject

@property (nonatomic, strong) NSNumber *taskId;
@property (nonatomic, strong) NSNumber *buy;
@property (nonatomic, copy) NSString *taskicon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *limitnum;
@property (nonatomic, strong) NSNumber *points;
@property (nonatomic, copy) NSString *bundleId;

@end

@interface TaskResContent : NSObject

@property (nonatomic, strong) NSArray *tasklist;

@end

@interface TaskModel : NSObject

@property (nonatomic, strong) NSNumber *resCode;
@property (nonatomic, strong) TaskResContent *resContent;

@end



