//
//  KBQueryCommand+SchemaManipulations.m
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBQueryCommand+SchemaManipulations.h"
#import "NSString+SQL.h"
#import "KBPersistanceMarcos.h"

@implementation KBQueryCommand (SchemaManipulations)

-(KBQueryCommand *)createTable:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo{
    
    [self resetQueryCommand];
    NSString *safeTableName = [tableName safeSQLMetaString];
    if (KBPersistance_isEmptyString(safeTableName)) {
        return self;
    }
    NSMutableArray *columnList = [[NSMutableArray alloc] init];
    [columnInfo enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull columnName, NSString * _Nonnull columnDescription, BOOL * _Nonnull stop) {
        NSString *safeColumnName = columnName;
        NSString *safeDescription = columnDescription;
        if (KBPersistance_isEmptyString(safeDescription)) {
            [columnList addObject:[NSString stringWithFormat:@"'%@'",safeColumnName]];
        }else{
            [columnList addObject:[NSString stringWithFormat:@"'%@' %@",safeColumnName,safeDescription]];
        }
    }];
    NSString *columns = [columnList componentsJoinedByString:@","];
    [self.sqlString appendFormat:@"CREATE TABLE IF NOT EXISTS '%@' (%@);",safeTableName,columns];
    
    return self;
}

-(KBQueryCommand *)addColumn:(NSString *)columnName columnInfo:(NSString *)columnInfo tableName:(NSString *)tableName{
    [self resetQueryCommand];
    NSString *safeColumnName = [columnName safeSQLMetaString];
    NSString *safeColumnInfo = [columnInfo safeSQLMetaString];
    NSString *safeTableName = [tableName safeSQLMetaString];
    
    if (KBPersistance_isEmptyString(safeTableName) || KBPersistance_isEmptyString(safeColumnInfo) || KBPersistance_isEmptyString(safeColumnName)) {
        return self;
    }
    [self.sqlString appendFormat:@"ALTER TABLE '%@' ADD COLUMN '%@' %@; ",safeTableName,safeColumnName,safeColumnInfo];
    
    return self;
}

@end
