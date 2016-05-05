//
//  KBDatabasePool.m
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBDatabasePool.h"

@interface KBDatabasePool ()

@property(nonatomic,strong)NSMutableDictionary *databaseDictionary;

@end

@implementation KBDatabasePool

#pragma mark - public methods
+(instancetype)sharedInstance{
    
    static KBDatabasePool *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[KBDatabasePool alloc] init];
    });
    return sharedInstance;
}

-(KBDataBase *)databaseWithName:(NSString *)databaseName{
    if (databaseName == nil) {
        return nil;
    }
    if (self.databaseDictionary[databaseName] == nil) {
        NSError *error = nil;
        KBDataBase *database = [[KBDataBase alloc] initWithDatabaseName:databaseName error:&error];
        if (error) {
            NSLog(@"Error at %s:[%d]:%@", __FILE__, __LINE__, error);
        }else{
            self.databaseDictionary[databaseName] = database;
        }
    }
    return self.databaseDictionary[databaseName];
}

-(void)closeAllDatabase{
    [self.databaseDictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull databaseName, KBDataBase * _Nonnull database, BOOL * _Nonnull stop) {
        if ([database isKindOfClass:[KBDataBase class]]) {
            [database closeDatabase];
        }
    }];
    [self.databaseDictionary removeAllObjects];
}

-(void)closeDatabaseWithName:(NSString *)databaseName{
    KBDataBase *db = self.databaseDictionary[databaseName];
    [db closeDatabase];
    [self.databaseDictionary removeObjectForKey:databaseName];
}

#pragma mark - setters and getters
-(NSMutableDictionary *)databaseDictionary{
    if (_databaseDictionary == nil) {
        _databaseDictionary = [[NSMutableDictionary alloc] init];
    }
    return _databaseDictionary;
}


@end
