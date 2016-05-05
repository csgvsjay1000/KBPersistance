//
//  TestInsertData.m
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "TestInsertData.h"

@implementation TestInsertData

@end

@implementation TestTable

-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
}

- (NSString *)databaseName{
    return @"testdatabase.sqlite";
}
- (NSString *)tableName{
    return @"test";
}
- (NSDictionary *)columnInfo{
    return @{
             @"primaryKey":@"INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL",
             @"name":@"TEXT",
             @"age":@"INTEGER",
             @"tomas":@"TEXT NOT NULL"
             };
}
- (NSString *)primaryKeyName{
    return @"primaryKey";
}

@end

@implementation TestRecord



@end
