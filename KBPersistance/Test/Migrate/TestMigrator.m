//
//  TestMigrator.m
//  KBPersistance
//
//  Created by chengshenggen on 5/10/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "TestMigrator.h"
#import "TestInsertData.h"
#import "MigrationStep1_0.h"

@implementation TestMigrator

- (NSArray *)migrationVersionList{
    return @[@"1.0",@"2.0"];
//    return @[@"1.0"];
}

- (NSDictionary *)migrationStepDictionary{
    return @{
             @"2.0":[MigrationStep1_0 class]
             };
//    return nil;
}

@end
