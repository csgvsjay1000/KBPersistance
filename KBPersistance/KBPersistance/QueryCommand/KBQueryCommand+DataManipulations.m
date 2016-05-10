//
//  KBQueryCommand+DataManipulations.m
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBQueryCommand+DataManipulations.h"
#import "NSString+SQL.h"
#import "KBPersistanceMarcos.h"
#import "KBQueryCommand+ReadMethods.h"

@implementation KBQueryCommand (DataManipulations)

-(KBQueryCommand *)insertTable:(NSString *)tableName withDataList:(NSArray *)dataList{
    
    [self resetQueryCommand];
    
    NSString *safeTableName = [tableName safeSQLMetaString];
    if (KBPersistance_isEmptyString(safeTableName) || dataList == nil) {
        return self;
    }
    NSMutableArray *valueItemList = [[NSMutableArray alloc] init];
    __block NSString *columString = nil;
    
    [dataList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull description, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *columList = [[NSMutableArray alloc] init];
        NSMutableArray *valueList = [[NSMutableArray alloc] init];
        
        [description enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull colum, NSString * _Nonnull value, BOOL * _Nonnull stop) {
            [columList addObject:[NSString stringWithFormat:@"`%@`", [colum safeSQLMetaString]]];
            if ([value isKindOfClass:[NSString class]]) {
                [valueList addObject:[NSString stringWithFormat:@"'%@'", [value safeSQLEncode]]];
            } else if ([value isKindOfClass:[NSNull class]]) {
                [valueList addObject:@"NULL"];
            } else {
                [valueList addObject:[NSString stringWithFormat:@"'%@'", value]];
            }
        }];
        if (columString == nil) {
            columString = [columList componentsJoinedByString:@","];
        }
        NSString *valueString = [valueList componentsJoinedByString:@","];
        [valueItemList addObject:[NSString stringWithFormat:@"(%@)", valueString]];

    }];
    [self.sqlString appendFormat:@"INSERT INTO `%@` (%@) VALUES %@;", safeTableName, columString, [valueItemList componentsJoinedByString:@","]];
    return self;
}

-(KBQueryCommand *)updateTable:(NSString *)tableName withData:(NSDictionary *)data condition:(NSString *)condition conditionParams:(NSDictionary *)conditionParams{
    [self resetQueryCommand];
    NSString *safeTableName = [tableName safeSQLMetaString];
    NSString *trimmedCondition = [condition safeSQLMetaString];
    if (KBPersistance_isEmptyString(safeTableName) || KBPersistance_isEmptyString(trimmedCondition) || data == nil){
        return self;
    }
    NSMutableArray *valueList = [[NSMutableArray alloc] init];
    
    [data enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull colum, NSString * _Nonnull value, BOOL * _Nonnull stop) {
        if ([value isKindOfClass:[NSString class]]) {
            [valueList addObject:[NSString stringWithFormat:@"`%@`='%@'", [colum safeSQLMetaString], [value safeSQLEncode]]];
        } else if ([value isKindOfClass:[NSNull class]]) {
            [valueList addObject:[NSString stringWithFormat:@"`%@`=NULL", [colum safeSQLMetaString]]];
        } else {
            [valueList addObject:[NSString stringWithFormat:@"`%@`=%@", [colum safeSQLMetaString], value]];
        }
    }];
    NSString *valueString = [valueList componentsJoinedByString:@","];
    
    [self.sqlString appendFormat:@"UPDATE `%@` SET %@ ", safeTableName, valueString];
    
    return [self where:condition params:conditionParams];
}

- (KBQueryCommand *)deleteTable:(NSString *)tableName withCondition:(NSString *)condition conditionParams:(NSDictionary *)conditionParams
{
    [self resetQueryCommand];
    
    NSString *safeTableName = [tableName safeSQLMetaString];
    NSString *trimmedCondition = [condition safeSQLMetaString];
    
    if (KBPersistance_isEmptyString(safeTableName) || KBPersistance_isEmptyString(trimmedCondition)) {
        return self;
    }
    
    [self.sqlString appendFormat:@"DELETE FROM `%@` ", safeTableName];
    
    return [self where:trimmedCondition params:conditionParams];
}


@end
