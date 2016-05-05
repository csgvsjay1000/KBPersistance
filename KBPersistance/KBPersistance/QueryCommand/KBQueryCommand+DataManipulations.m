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
    
    
    
    
    return self;
}

@end
