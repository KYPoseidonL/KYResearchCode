//
//  UDIDViewController.m
//  KYStudyDemo
//
//  Created by KYPoseidonL on 16/4/9.
//  Copyright © 2016年 KYPoseidonL. All rights reserved.
//

#import "UDIDViewController.h"

#import <mach/mach_port.h>
#import <mach/mach_host.h>
#import "IOKit/IOKitLib.h"
#import "IOKit/storage/IOMedia.h"
#import <AdSupport/AdSupport.h>
#include <objc/runtime.h>
//#import <sys/utsname.h>
//#include <sys/socket.h> // Per msqr
//#include <sys/sysctl.h>
#import <dlfcn.h>
#import "OpenUDID.h"
#import "KYKeychain.h"
#import "AppDelegate.h"

@interface UDIDViewController ()

@property (weak, nonatomic) IBOutlet UILabel *idfaLabel;
@property (weak, nonatomic) IBOutlet UILabel *openUDIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *idfvLabel;
@property (weak, nonatomic) IBOutlet UILabel *keychainLabel;
@property (weak, nonatomic) IBOutlet UILabel *userdefultLabel;

@end

@implementation UDIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self saveDeviceInfoWithKeychain:[self getIdfa]];
    [self saveDeviceInfoWithUserdefult:[self getIdfa]];
    self.idfaLabel.text = [NSString stringWithFormat:@"IDFA:  %@",[self getIdfa]];
    self.idfvLabel.text = [NSString stringWithFormat:@"IDFV:  %@",[self getIDFV]];
    self.openUDIDLabel.text = [NSString stringWithFormat:@"OPENUDID:  %@",[self getOpenUDID]];
    
    self.keychainLabel.text = [NSString stringWithFormat:@"KEYCHAIN:  %@",[self getDeviceInfoFromKeychain]];
    self.userdefultLabel.text = [NSString stringWithFormat:@"USDEF:  %@",[self getDeviceInfoFromUserDefult]];
    
    
}


#if TARGET_IPHONE_SIMULATOR//模拟器

#elif TARGET_OS_IPHONE//真机

//--------------------1.用IOKit取设备电池号--------------------//
#define kIOServicePlane    "IOService"
NSData *searchIOProperty(NSString *searchKey) {
    
    mach_port_t masterPort;
    NSData* prop = nil;
    
    kern_return_t kr = IOMasterPort(MACH_PORT_NULL, &masterPort);
    if (kr != noErr) return nil;
    
    io_registry_entry_t entry = IORegistryGetRootEntry(masterPort);
    if (entry == MACH_PORT_NULL) return nil;
    
    CFTypeRef propAsCFData = IORegistryEntrySearchCFProperty(entry, kIOServicePlane, (__bridge CFStringRef) searchKey, nil, kIORegistryIterateRecursively);
    
    if (propAsCFData) {
        prop = (__bridge NSData *) propAsCFData;
    }
    
    //    propID = CFGetTypeID(prop);
    
    mach_port_deallocate(mach_task_self(), masterPort);
    return prop;
}

NSString *getUdid() {
    
    NSData *udidData = searchIOProperty(@"battery-id");
    NSString* udidStr = [[NSString alloc] initWithData:udidData encoding:NSUTF8StringEncoding];
    return udidStr;
}

#endif


//--------------------2.IDFA广告标示符--------------------//
- (NSString *)getIdfa {
    
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}


//--------------------3.IDFVvendor标示符--------------------//
- (NSString *)getIDFV {
    
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}


//--------------------4.OpenUDID--------------------//
- (NSString *)getOpenUDID {
    
    return [OpenUDID value];
}

//把设备信息存入钥匙串
- (void)saveDeviceInfoWithKeychain:(NSString *)deviceInfo {
    
    NSError *error = nil;
    NSString *oldDeviceInfo = [KYKeychain passwordForService:@"com.keychaintest.data" account:@"KYPoseidonL" error:&error];
    if ( ![oldDeviceInfo length] ) {
        [KYKeychain setPassword:deviceInfo forService:@"com.keychaintest.data" account:@"KYPoseidonL" error:&error];
        NSLog(@"idfa已存入Keychain");
    }
}

//把设备信息存入Userdefult
- (void)saveDeviceInfoWithUserdefult:(NSString *)deviceInfo {
    
    NSString *oldDeviceInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"idfaChecker"];
    if ( ![oldDeviceInfo length] ) {
        [[NSUserDefaults standardUserDefaults] setObject:deviceInfo forKey:@"idfaChecker"];
        NSLog(@"idfa已存入Userdefult");
    }
}

- (NSString *)getDeviceInfoFromUserDefult {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"idfaChecker"];
}

- (NSString *)getDeviceInfoFromKeychain {
    
    NSError *error = nil;
    NSString *deviceInfo = [KYKeychain passwordForService:@"com.keychaintest.data" account:@"KYPoseidonL" error:&error];
    if ([error code] == SSKeychainErrorNotFound) {
        NSLog(@"Passwordnot found");
    }
    return deviceInfo;
}


@end
