//
//  KBDataBase.m
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBDataBase.h"
#import "KBDBConfiguration.h"

@interface KBDataBase ()

@property(nonatomic,assign)sqlite3 *database;

@property(nonatomic,copy)NSString *databaseName;

@property(nonatomic,copy)NSString *databaseFilePath;

@end

@implementation KBDataBase

#pragma mark - life cycle

- (instancetype)initWithDatabaseName:(NSString *)databaseName error:(NSError **)error{
    self = [super init];
    if (self) {
        self.databaseName = databaseName;
        self.databaseFilePath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:databaseName];
        BOOL isFileExists = [[NSFileManager defaultManager] fileExistsAtPath:self.databaseFilePath];
        const char *path = [self.databaseFilePath UTF8String];
        
        int result = sqlite3_open_v2(path, &_database, SQLITE_OPEN_CREATE|SQLITE_OPEN_READWRITE|SQLITE_OPEN_FULLMUTEX|SQLITE_OPEN_SHAREDCACHE, NULL);
        if (result != SQLITE_OK && error) {
            KBdbErrorCode errorCode = KBdbErrorCodeOpenError;
            NSString *sqliteErrorString = [NSString stringWithCString:sqlite3_errmsg(self.database) encoding:NSUTF8StringEncoding];
            NSString *errorString = [NSString stringWithFormat:@"open database at %@ failed with error:\n %@", self.databaseFilePath, sqliteErrorString];
            if (isFileExists == NO) {
                errorCode = KBdbErrorCodeCreateError;
                errorString = [NSString stringWithFormat:@"create database at %@ failed with error:\n %@", self.databaseFilePath, [NSString stringWithCString:sqlite3_errmsg(self.database) encoding:NSUTF8StringEncoding]];
            }
            *error = [NSError errorWithDomain:KeyKBdbErrorDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey:errorString}];
            [self closeDatabase];
            return nil;
        }
        NSLog(@"%@",self.databaseFilePath);
    }
    return self;
}

-(void)dealloc{
    [self closeDatabase];
}

#pragma mark - public methods
- (void)closeDatabase{
    sqlite3_close_v2(self.database);
    self.database = 0x00;
    self.databaseFilePath = nil;
}

@end
