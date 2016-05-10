//
//  MigrationStep1_0.m
//  KBPersistance
//
//  Created by chengshenggen on 5/10/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "MigrationStep1_0.h"
#import "TestInsertData.h"

@implementation MigrationStep1_0

-(void)goUpWithQueryCommand:(KBQueryCommand *)queryCommand error:(NSError *__autoreleasing *)error{
//    TestTable *table = [[TestTable alloc] init];
    [[queryCommand addColumn:@"migration1_0" columnInfo:@"TEXT" tableName:[TestTable tableName]] executeWithError:error];
}

-(void)goDownWithQueryCommand:(KBQueryCommand *)queryCommand error:(NSError *__autoreleasing *)error{
    
}

@end
