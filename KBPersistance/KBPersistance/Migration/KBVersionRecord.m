//
//  KBVersionRecord.m
//  KBPersistance
//
//  Created by chengshenggen on 5/7/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBVersionRecord.h"



@implementation KBVersionRecord

- (NSDictionary *)dictionaryRepresentationWithTable:(KBPersistanceTable <KBPersistanceTableProtocol> *)table{
    return @{
             @"identifier":self.identifier?self.identifier:[NSNull null],
             @"databaseVersion":self.databaseVersion?self.databaseVersion:[NSNull null],
             };
}

@end

@interface KBVersionTable ()

@property(nonatomic,strong)NSString *databaseName;
@property(nonatomic,strong)KBDataBase *database;

@end

@implementation KBVersionTable

-(instancetype)initWithDatabase:(KBDataBase *)database{
    self = [super init];
    if (self) {
        self.database = database;
        self.databaseName = database.databaseName;
    }
    return self;
}

- (NSString *)tableName{
    return [KBVersionTable tableName];
}

+(NSString *)tableName{
    return @"kCTPersistanceVersionTableName";
}

- (NSDictionary *)columnInfo{
    return [KBVersionTable columnInfo];
}

+ (NSDictionary *)columnInfo{
    return @{
             @"identifier":@"INTEGER PRIMARY KEY AUTOINCREMENT",
             @"databaseVersion":@"TEXT"
             };
}

+ (NSString *)primaryKeyName{
    return @"identifier";
}

- (NSString *)primaryKeyName{
    return [KBVersionTable primaryKeyName];
}

@end
