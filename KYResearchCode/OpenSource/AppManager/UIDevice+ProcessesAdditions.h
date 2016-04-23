//
//  UIDevice+ProcessesAdditions.h
//  DetectApp
//
//  Created by wangzhongfeng on 14-6-4.
//  Copyright (c) 2014年 wangzhongfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (ProcessesAdditions)
/**
 *  返回当前运行的进程数组
 */
- (NSArray *)runningProcesses;
/**
 *  运行进程名数组
 */
- (NSArray *)runningProcessesNames;

@end
