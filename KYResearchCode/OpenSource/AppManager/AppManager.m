//
//  AppManager.m
//  caimimao
//
//  Created by iOS Developer 3 on 16/1/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "AppManager.h"

#import "UIDevice+ProcessesAdditions.h"
#include <objc/runtime.h>
#import <dlfcn.h>

#define SBSERVPATH  "/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices"

@interface AppManager ()
{
    NSObject *_workspace;
    void * sbserv;
}

@end

@implementation AppManager

singletonImplemention(AppManager)

/**
 *  判断app是否正在运行
 *
 *  @param bundleExecutable app的可执行文件名
 *
 *  @return 返回运行状态
 */
- (BOOL)judgeAppRunningWithBundleId:(NSString *)bundleId {
    
    if (kSystemVersion >= 9.0) {
        return NO;
    }
    
    BOOL isInstalled = [self applicationIsInstalledWithBundleId:bundleId];
    if (isInstalled) {
        
        NSString *bundleExecutable = [self getAppBundleExecutableWithBundleId:bundleId];
        
        NSArray *runningArr = [[UIDevice currentDevice] runningProcessesNames];
        for (NSString *processName in runningArr) {

            if ([processName isEqualToString:bundleExecutable]) {
                return YES;
            }
        }
        
    } else {
        return NO;
    }

    return NO;
}

//初始化_workspace对象
- (void)setup {
    
    if (_workspace) {
        return;
    }
    
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    if (LSApplicationWorkspace_class) {
        _workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    }
}

// iOS 7, 8
- (NSMutableArray *)getAllappInfosWkspc {
    
    [self setup];
    
    NSArray *allBundleIds = nil;
    NSMutableArray *allAppInfo = [[NSMutableArray alloc] init];
    if (_workspace) {
        if ([_workspace respondsToSelector:@selector(allApplications)]) {
            allBundleIds = [_workspace performSelector:@selector(allApplications)];
            
            for (id obj in allBundleIds) {
                id applicationType = nil;
                SEL sel = NSSelectorFromString(@"applicationType");
                if ([obj respondsToSelector:sel]) {
                    applicationType = [obj performSelector:sel];
                }
                
                if (![(NSString *)applicationType isEqualToString:@"System"]) {
                    
                    NSString *bundleId = [self getAppBundleIdWithAppProxy:obj];
                    NSString *appName = [self getAppLocalizedNameWithAppProxy:obj];
                    NSString *version = [self getAppVersionWithAppProxy:obj];
                    if (![bundleId isEqualToString:@"cn.caimimao.cmm"]) {
                        
                        NSDictionary *dic = @{@"bundleId" : bundleId, @"appName" : appName, @"version" : version};
                        [allAppInfo addObject:dic];
                    }
                }
            }
        }
    }
    return allAppInfo;
}

/**
 *  通过AppProxy对象获取app的名字
 *
 *  @param obj AppProxy对象
 *
 *  @return 返回app的名字
 */
- (NSString *)getAppLocalizedNameWithAppProxy:(id)obj {
    
    id localizedName = nil;
    SEL sel = NSSelectorFromString(@"localizedName");
    if ([obj respondsToSelector:sel]) {
        localizedName = [obj performSelector:sel];
    }
    
    if (!localizedName) {
        localizedName = @"";
    }
    
    return [NSString stringWithFormat:@"%@", localizedName];
}

/**
 *  通过AppProxy对象获取app的BundleId
 *
 *  @param obj AppProxy对象
 *
 *  @return 返回app的BundleId
 */
- (NSString *)getAppBundleIdWithAppProxy:(id)obj {
    
    id bundleId = nil;
    SEL sel = NSSelectorFromString(@"applicationIdentifier");
    if ([obj respondsToSelector:sel]) {
        bundleId = [obj performSelector:sel];
    }
    
    if (!bundleId) {
        bundleId = @"";
    }
    return [NSString stringWithFormat:@"%@", bundleId];
}

/**
 *  通过AppProxy对象获取app的版本号
 *
 *  @param obj AppProxy对象
 *
 *  @return 返回app的版本号
 */
- (NSString *)getAppVersionWithAppProxy:(id)obj {
    
    id bundleVersion = nil;
    SEL sel = NSSelectorFromString(@"shortVersionString");
    if ([obj respondsToSelector:sel]) {
        bundleVersion = [obj performSelector:sel];
    }
    
    if (!bundleVersion) {
        bundleVersion = @"";
    }
    return [NSString stringWithFormat:@"%@", bundleVersion];
}

/**
 *  通过bundleId获取app的可执行文件的名字
 *
 *  @param bundleId bundleId
 *
 *  @return 返回app的可执行文件的名字
 */
- (NSString *)getAppBundleExecutableWithBundleId:(NSString *)bundleId {
    
    NSString *bundleExecutable = nil;
    
    if (kSystemVersion < 8.0) {
        bundleExecutable = [self getIOS7BundleExecutableWithBundleId:bundleId];
    } else {
        
        NSObject *obj = [self getAppInfoWithBundleId:bundleId];
        SEL sel = NSSelectorFromString(@"bundleExecutable");
        if ([obj respondsToSelector:sel]) {
            bundleExecutable = [obj performSelector:sel];
        }
    }
    
    return bundleExecutable;
}

/**
 *  根据bundleId获取AppProxy对象
 *
 *  @param bundleId bundleId
 *
 *  @return 返回AppProxy对象
 */
- (NSObject *)getAppInfoWithBundleId:(NSString *)bundleId {
    
    NSObject *obj = nil;
    Class LSApplicationProxy_class = objc_getClass("LSApplicationProxy");
    if (LSApplicationProxy_class) {
        obj = [LSApplicationProxy_class performSelector:@selector(applicationProxyForIdentifier:) withObject:bundleId];
    }
    
    return obj;
}

/**
 *  通过bundleId打开对应的app
 *
 *  @param bundleId bundleId
 *
 *  @return 返回app是否打开成功
 */
- (BOOL)openAppWithBundleId:(NSString *)bundleId {
    
    [self setup];
    bool isOpen = nil;
    if ([_workspace respondsToSelector:@selector(openApplicationWithBundleID:)]) {
        isOpen = [_workspace performSelector:@selector(openApplicationWithBundleID:) withObject:bundleId];
    }
    
    return (BOOL)isOpen;
}

/**
 *  通过url打开对应的app
 *
 *  @param url url
 *
 *  @return 返回app是否打开成功
 */
- (BOOL)openAppWithURL:(NSURL *)url {
    [self setup];
    bool isOpen = nil;
    if ([_workspace respondsToSelector:@selector(openURL:)]) {
        isOpen = [_workspace performSelector:@selector(openURL:) withObject:url];
    }
    
    return (BOOL)isOpen;
}

/**
 *  通过bundleId判断app是否安装
 *
 *  @param bundleId bundleId
 *
 *  @return 返回是否app安装
 */
- (BOOL)applicationIsInstalledWithBundleId:(NSString *)bundleId {
    
    [self setup];
    bool isInstalled = NO;
    if ([_workspace respondsToSelector:@selector(applicationIsInstalled:)]) {
        isInstalled = [_workspace performSelector:@selector(applicationIsInstalled:) withObject:bundleId];
    }
    
    return (BOOL)isInstalled;
}

#pragma mark - 适用于iOS7
//初始化sbserv
- (void)createSBService {
    
    if (sbserv == NULL) {
        
        sbserv = dlopen(SBSERVPATH, RTLD_LAZY);
    }
}

//获取app的可执行文件名
- (NSString *)getIOS7BundleExecutableWithBundleId:(NSString *)bundleId {
    
    [self createSBService];
    
    NSString *bundleExecutable = nil;
    
    NSString * (*SBSCopyBundlePathForDisplayIdentifier)(NSString* ) =   dlsym(sbserv, "SBSCopyBundlePathForDisplayIdentifier");
    NSString *bundleExecutablePath = SBSCopyBundlePathForDisplayIdentifier(bundleId);
    
    NSRange range1 = [bundleExecutablePath rangeOfString:@"/" options:NSBackwardsSearch];
    if (range1.location != NSNotFound) {
        bundleExecutable = [bundleExecutablePath substringFromIndex:range1.location+1];
        
        NSRange range2 = [bundleExecutable rangeOfString:@"." options:NSBackwardsSearch];
        if (range2.location != NSNotFound) {
            bundleExecutable = [bundleExecutable substringToIndex:range2.location];
        }
    }
    
    return bundleExecutable;
}

/**
 *  跳转到appStore的指定页面
 */
- (void)goToASSearch {
    
    NSString *str =  [self.appStoreSearchURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    [self openAppWithURL:url];
}

@end


