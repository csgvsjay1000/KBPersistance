//
//  KBPersistanceTable.m
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBPersistanceTable.h"
#import "KBQueryCommand.h"
#import "KBQueryCommand+SchemaManipulations.h"

@interface KBPersistanceTable ()

@property(nonatomic,weak)id<KBPersistanceTableProtocol> child;

@end

@implementation KBPersistanceTable

#pragma mark - life cycle
-(instancetype)init{
    self = [super init];
    if (self && [self conformsToProtocol:@protocol(KBPersistanceTableProtocol)]) {
        self.child = (KBPersistanceTable <KBPersistanceTableProtocol>*)self;
        
        NSError *error = nil;
        KBQueryCommand *queryCommand = [[KBQueryCommand alloc] initWithDatabaseName:self.child.databaseName];
        [[queryCommand createTable:self.child.tableName columnInfo:self.child.columnInfo] executeWithError:&error];
        if (error) {
            NSLog(@"Error at [%s]:[%d]:%@", __FILE__, __LINE__, error);
        }
    }else {
        NSException *exception = [NSException exceptionWithName:@"CTPersistanceTable init error" reason:@"the child class must conforms to protocol: <CTPersistanceTableProtocol>" userInfo:nil];
        @throw exception;
    }
    return self;
}

#pragma mark - method to override
-(BOOL)isCorrectToInsertRecord:(NSObject <KBPersistanceRecordProtocol> *)record{
    return YES;
}

-(BOOL)isCorrectToUpdateRecord:(NSObject <KBPersistanceRecordProtocol> *)record{
    return YES;
}

@end
