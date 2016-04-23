//
//  KYDataBase.m
//  KYStudyDemo
//
//  Created by iOS Developer 3 on 15/11/3.
//  Copyright © 2015年 KYPoseidonL. All rights reserved.
//

#import "KYDataBase.h"

#define KYDBPath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"AppInfo.sqlite"]

@implementation KYDataBase

singletonImplemention(KYDataBase)

- (void)createAppInfoTable {
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:KYDBPath] == NO) {
        // create it
        FMDatabase * db = [FMDatabase databaseWithPath:KYDBPath];
        if ([db open]) {
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS AppInfo (ID INTEGER PRIMARY KEY AUTOINCREMENT, bundleId TEXT, appName TEXT);"];
            BOOL res = [db executeUpdate:sql];
            if (!res) {
                DDLogDebug(@"error when creating db table");
            } else {
                DDLogDebug(@"succ to creating db table");
            }
            [db close];
        } else {
            DDLogDebug(@"error when open db");
        }
    }
}

- (void)insertBundleId:(NSString *)bundleId {
    
    FMDatabase * db = [FMDatabase databaseWithPath:KYDBPath];
    if ([db open]) {
        NSString * sql = @"insert into AppInfo (bundleId) values (?)";
        BOOL res = [db executeUpdate:sql, bundleId];
        if (!res) {
            DDLogDebug(@"error to insert data");
        } else {
            DDLogDebug(@"succ to insert data");
        }
        [db close];
    }
}

- (NSMutableArray *)queryData {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMDatabase * db = [FMDatabase databaseWithPath:KYDBPath];
    if ([db open]) {
        NSString * sql = @"select * from AppInfo";
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {

            NSString * bundleId = [rs stringForColumn:@"bundleId"];
            [result addObject:bundleId];
        }
        [db close];
    }
    return result;
}

- (void)clearAll {
    FMDatabase * db = [FMDatabase databaseWithPath:KYDBPath];
    if ([db open]) {
        NSString * sql = @"delete from AppInfo";
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            DDLogDebug(@"error to delete db data");
        } else {
            DDLogDebug(@"succ to deleta db data");
        }
        [db close];
    }
}

- (void)multithread {
    //    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
    //    dispatch_queue_t q1 = dispatch_queue_create("queue1", NULL);
    //    dispatch_queue_t q2 = dispatch_queue_create("queue2", NULL);
    //
    //    dispatch_async(q1, ^{
    //        for (int i = 0; i < 100; ++i) {
    //            [queue inDatabase:^(FMDatabase *db) {
    //                NSString * sql = @"insert into AppInfo (name, password) values(?, ?) ";
    //                NSString * name = [NSString stringWithFormat:@"queue111 %d", i];
    //                BOOL res = [db executeUpdate:sql, name, @"boy"];
    //                if (!res) {
    //                    DDLogDebug(@"error to add db data: %@", name);
    //                } else {
    //                    DDLogDebug(@"succ to add db data: %@", name);
    //                }
    //            }];
    //        }
    //    });
    //
    //    dispatch_async(q2, ^{
    //        for (int i = 0; i < 100; ++i) {
    //            [queue inDatabase:^(FMDatabase *db) {
    //                NSString * sql = @"insert into AppInfo (name, password) values(?, ?) ";
    //                NSString * name = [NSString stringWithFormat:@"queue222 %d", i];
    //                BOOL res = [db executeUpdate:sql, name, @"boy"];
    //                if (!res) {
    //                    DDLogDebug(@"error to add db data: %@", name);
    //                } else {
    //                    DDLogDebug(@"succ to add db data: %@", name);
    //                }
    //            }];
    //        }
    //    });
}


@end
