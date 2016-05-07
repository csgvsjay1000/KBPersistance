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

@end
