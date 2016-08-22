//
//  NtFinder.m
//  defense
//
//  Created by Eric Wu on 15/11/19.
//  Copyright © 2015年 ios. All rights reserved.
//

#import "NtFinder.h"
// for "AF_INET"
#import <sys/socket.h>
// for ifaddrs
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
// for currentWiFi information
#import <SystemConfiguration/CaptiveNetwork.h>
// for gateway
#import <stdio.h>
#import <ctype.h>
#import <sys/param.h>
#import <sys/sysctl.h>
// for ARP Table
#import <sys/param.h>
#import <sys/file.h>
#import <sys/socket.h>
#import <net/if.h>
#import <net/if_dl.h>
#import "if_types.h"
#import "route.h"  /*the very same from google-code*/
#import "if_ether.h"


#if defined(BSD) || defined(__APPLE__)
#define ROUNDUP(a) \
((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))
#endif

#define Interface_WiFi                 @"en0"
#define Interface_Cellular             @"pdp_ip0"

static int nflag = 0;

@implementation NtFinder

/*
 1. get local router information
 - local ip, gateway, netmask, broadcast address, interface, etc.(IPV4 address)
 - when using cellular network, I'm only sure that the ip address is correct, and I can not confirm other informations
*/
+ (NSMutableDictionary *)getRouterInfo
{
    NSMutableDictionary *routerInfo = [NSMutableDictionary dictionary];
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;

    // get cueernt interface - 0 success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        
        while (temp_addr != NULL) {
            if (temp_addr->ifa_addr->sa_family == AF_INET) {
                /* internetwork: UDP, TCP, etc. */
                // just get cellular||wifi info
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:Interface_WiFi]||
                    [[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:Interface_Cellular]) {
                    
                    NSMutableDictionary *addressInfo = [NSMutableDictionary dictionary];
                    // local address
                    NSString *localAddress = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    NSString *broadcastAddress = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)];
                    NSString *netmask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)];
                    NSString *interface = [NSString stringWithUTF8String:temp_addr->ifa_name];
                    if (localAddress) {
                        [addressInfo setObject:localAddress forKey:@"local"];
                        // gateway
                        in_addr_t i =inet_addr([localAddress cStringUsingEncoding:NSUTF8StringEncoding]);
                        in_addr_t* x =&i;
                        NSString *gatewayAddress = [NtFinder getDefaultGateway:x withLocalAddress:localAddress];
                        if (gatewayAddress) {
                            [addressInfo setObject:gatewayAddress forKey:@"gateway"];
                        }
                    }
                    if (broadcastAddress) {
                        [addressInfo setObject:broadcastAddress forKey:@"broadcast"];
                    }
                    if (netmask) {
                        [addressInfo setObject:netmask forKey:@"netmask"];
                    }
                    if (interface) {
                        [addressInfo setObject:interface forKey:@"interface"];
                    }
                    
                    // save addressinfo into routerinfo
                    if ([addressInfo count] > 0) {
                        if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:Interface_WiFi]) {
                            [addressInfo setObject:kTypeInfoKeyWifi forKey:@"type"];
                            [routerInfo setObject:addressInfo forKey:kTypeInfoKeyWifi];
                        } else if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:Interface_Cellular]) {
                            [addressInfo setObject:kTypeInfoKeyCellular forKey:@"type"];
                            [routerInfo setObject:addressInfo forKey:kTypeInfoKeyCellular];
                        }
                    }
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return routerInfo;
}

/*
 2. get default gateway address -> 192.168.1.19 - 192.168.1.1
 here we assume the first part of gateway address is the same like local address
*/
+ (NSString *)getDefaultGateway:(in_addr_t *)addr withLocalAddress:(NSString *)localAddress
{
    NSString *result = nil;
    
    /* net.route.0.inet.flags.gateway */
    int mib[] = { CTL_NET, PF_ROUTE, 0, AF_INET, NET_RT_FLAGS, RTF_GATEWAY };
    size_t l;
    char *buf, *p;
    struct rt_msghdr *rt;
    struct sockaddr *sa;
    struct sockaddr *sa_tab[RTAX_MAX];
    int i;
    if (sysctl(mib, sizeof(mib)/sizeof(int), 0, &l, 0, 0) < 0) {
        return result;
    }
    if (l > 0) {
        buf = malloc(l);
        if (sysctl(mib, sizeof(mib)/sizeof(int), buf, &l, 0, 0) < 0) {
            return result;
        }
        for (p=buf; p < buf+l; p+=rt->rtm_msglen) {
            rt = (struct rt_msghdr *)p;
            sa = (struct sockaddr *)(rt + 1);
            for (i = 0; i < RTAX_MAX; i++) {
                if (rt->rtm_addrs & (1 << i)) {
                    sa_tab[i] = sa;
                    sa = (struct sockaddr *)((char *)sa + ROUNDUP(sa->sa_len));
                } else {
                    sa_tab[i] = NULL;
                }
            }
            
            if ( ((rt->rtm_addrs & (RTA_DST|RTA_GATEWAY)) == (RTA_DST|RTA_GATEWAY))
               && sa_tab[RTAX_DST]->sa_family == AF_INET
               && sa_tab[RTAX_GATEWAY]->sa_family == AF_INET ) {
                
                unsigned char octet[4] = { 0, 0, 0, 0 };
                for (int i = 0; i < 4; i++) {
                    octet[i] = ( ((struct sockaddr_in *)(sa_tab[RTAX_GATEWAY]))->sin_addr.s_addr >> (i*8) ) & 0xFF;
                }
                
//                NSLog(@"%d.%d.%d.%d", octet[0], octet[1], octet[2], octet[3]);
                const char *tmp = inet_ntoa((((struct sockaddr_in *)sa_tab[RTAX_DST])->sin_addr));
//                NSLog(@"  %@", [NSString stringWithCString:tmp encoding:NSUTF8StringEncoding]);
                
                if ( ((struct sockaddr_in *)sa_tab[RTAX_DST])->sin_addr.s_addr == 0 ) {
                    NSArray *componts = [localAddress componentsSeparatedByString:@"."];
                    NSString *hrefOfLocalAddress = [componts objectAtIndex:0];
                    // assume the fitst part of gateway address is same like local address
                    if ( octet[0] == [hrefOfLocalAddress integerValue] ) {
                        *addr = ((struct sockaddr_in *)(sa_tab[RTAX_GATEWAY]))->sin_addr.s_addr;
                        result = [NSString stringWithFormat:@"%d.%d.%d.%d", octet[0], octet[1], octet[2], octet[3]];
                    }
                }
            }
        }
        free(buf);
    }
    return result;
}

// iOS7以上取到的都是00:02:00:00:00:00
+ (NSString *)macAddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

// 使用的是ARP原理，取route table的cache
+ (NSString *)ip2mac:(NSString *)ip
{
    int found_entry = 0;
    
    NSString *mAddr = nil;
    u_long addr = inet_addr([ip UTF8String]);
    if (addr == INADDR_NONE) {
        return nil;
    }

    int mib[6];
    size_t needed;
    char *host, *lim, *buf, *next;
    struct rt_msghdr *rtm;
    struct sockaddr_inarp *sin;
    struct sockaddr_dl *sdl;
    extern int h_errno;
    struct hostent *hp;
    
    mib[0] = CTL_NET;           // 4
    mib[1] = PF_ROUTE;          // 17
    mib[2] = 0;
    mib[3] = AF_INET;           // 2
    mib[4] = NET_RT_FLAGS;      // 2
    mib[5] = RTF_LLINFO;        // 1024, 0x400
    
    if (sysctl(mib, sizeof(mib) / sizeof(mib[0]), NULL, &needed, NULL, 0) < 0) {
//        NSLog(@"error route-sysctl-estimate");
        return mAddr;
    }
    if ((buf = (char*)malloc(needed)) == NULL) {
//        NSLog(@"error malloc");
        return mAddr;
    }
    if (sysctl(mib, sizeof(mib) / sizeof(mib[0]), buf, &needed, NULL, 0) < 0) {
//        NSLog(@"error retrieval of routing table");
        free(buf);
        return mAddr;
    }
    
    lim = buf + needed;
    for (next = buf; next < lim; next += rtm->rtm_msglen) {
        rtm = (struct rt_msghdr *)next;
        sin = (struct sockaddr_inarp *)(rtm + 1);
        sdl = (struct sockaddr_dl *)(sin + 1);
        // debug
//        NSLog(@"next = %lx, rtm->rtm_msglen %lx, lim %lx", next, rtm->rtm_msglen, lim);
//        NSLog(@"rtm = %lx, sin %lx, sdl %lx", rtm, sin, sdl);
        
        if (addr) {
            if (addr != sin->sin_addr.s_addr) {
                continue;
                // debug
//                found_entry = 0;
            }
            found_entry = 1;
        }
        
        if (nflag == 0) {
            hp = gethostbyaddr((caddr_t)&(sin->sin_addr), sizeof sin->sin_addr, AF_INET);
        } else {
            hp = 0;
        }
        
        if (hp) {
            host = hp->h_name;
        } else {
            host = "?";
            if (h_errno == TRY_AGAIN) {
                nflag = 1;
            }
        }
        
        if (sdl->sdl_alen) {
            u_char *cp = (u_char *)LLADDR(sdl);
            mAddr = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", cp[0], cp[1], cp[2], cp[3], cp[4], cp[5]];
        } else {
            mAddr = nil;
        }
        // debug
//        char *tmpAddr = inet_ntoa(sin->sin_addr);
//        NSLog(@"%s, %s, %@", tmpAddr, host, mAddr);
        
    }
    free(buf);
    
    if (found_entry == 0) {
        return nil;
    } else {
        return mAddr;
    }
}

@end
