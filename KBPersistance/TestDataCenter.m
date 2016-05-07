//
//  TestDataCenter.m
//  KBPersistance
//
//  Created by chengshenggen on 5/7/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "TestDataCenter.h"

@interface TestDataCenter ()

@property(nonatomic,strong)TestTable *testTable;

@end

@implementation TestDataCenter

#pragma mark - public methods
-(BOOL)saveRecord:(TestRecord *)record{
    NSError *error = nil;
    [self.testTable insertRecord:record error:&error];
    if (error) {
        return NO;
    }
    return YES;
}

#pragma mark - setters and getters
-(TestTable *)testTable{
    if (_testTable == nil) {
        _testTable = [[TestTable alloc] init];
    }
    return _testTable;
}

@end
