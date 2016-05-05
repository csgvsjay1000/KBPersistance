//
//  KBPersistanceTable+Insert.m
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBPersistanceTable+Insert.h"
#import "KBQueryCommand.h"

@implementation KBPersistanceTable (Insert)

-(BOOL)insertRecord:(NSObject<KBPersistanceRecordProtocol> *)record error:(NSError *__autoreleasing *)error{
    BOOL isSuccessed = YES;
    if (record) {
        if ([self.child isCorrectToInsertRecord:record]) {
            KBQueryCommand *queryCommand = [[KBQueryCommand alloc] initWithDatabaseName:self.child.databaseName];
//            if ([queryCommand in]) {
//                <#statements#>
//            }
        }
    }
    
    
    return isSuccessed;
}

@end
