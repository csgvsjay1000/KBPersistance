//
//  KBPersistanceMigrator.m
//  KBPersistance
//
//  Created by chengshenggen on 5/7/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBPersistanceMigrator.h"
#import "KBVersionRecord.h"
#import "KBQueryCommand+SchemaManipulations.h"
#import "KBQueryCommand+ReadMethods.h"
#import <UIKit/UIKit.h>
#import "KBQueryCommand+DataManipulations.h"

@interface KBPersistanceMigrator ()

@property(nonatomic,weak)KBDataBase *database;
@property(nonatomic,weak)id<KBPersistanceMigratorProtocol> child;

@end

@implementation KBPersistanceMigrator

-(instancetype)init{
    self = [super init];
    if (self && [self conformsToProtocol:@protocol(KBPersistanceMigratorProtocol)]) {
        self.child = (id<KBPersistanceMigratorProtocol>)self;
    }else{
        NSException *exception = [NSException exceptionWithName:@"CTPersistanceMigrator init error" reason:@"the child class must conforms to protocol: <CTPersistanceMigratorProtocol>" userInfo:nil];
        @throw exception;
    }
    return self;
}

#pragma mark - public methods
-(void)createVersionTableWithDatabase:(KBDataBase *)database{
    self.database = database;
    
    KBVersionRecord *record = [[KBVersionRecord alloc] init];
    record.databaseVersion = [[self.child migrationVersionList] lastObject];
    NSError *error = nil;
    KBQueryCommand *queryCommand = [[KBQueryCommand alloc] initWithDatabase:self.database];
    [[queryCommand createTable:[KBVersionTable tableName] columnInfo:[KBVersionTable columnInfo]] executeWithError:&error];
    if (!error) {
        NSLog(@"创建数据库(%@)版本表成功",database.databaseName);
    }else{
        NSLog(@"创建数据库(%@)版本表失败",database.databaseName);
    }
    [queryCommand resetQueryCommand];
    
    [[queryCommand insertTable:[KBVersionTable tableName] withDataList:@[@{@"databaseVersion":record.databaseVersion}]] executeWithError:&error];
    
    
    
    
}

-(BOOL)shouldMigrate:(KBDataBase *)database{
    self.database = database;
    KBQueryCommand *queryCommand = [[KBQueryCommand alloc] initWithDatabase:self.database];
    NSDictionary *latestRecord = [[[[[[queryCommand select:nil isDistinct:NO]form:[KBVersionTable tableName]]orderBy:[KBVersionTable primaryKeyName] isDESC:YES] limit:1] fetchWithError:NULL] firstObject];
    NSString *currentVersion = latestRecord[@"databaseVersion"];
    NSUInteger index = [[self.child migrationVersionList] indexOfObject:currentVersion];
    if (index == [[self.child migrationVersionList] count] - 1) {
        return NO;
    }
    return YES;
}

-(void)performMigrate:(KBDataBase *)database{
    self.database = database;
    KBQueryCommand *queryCommand = [[KBQueryCommand alloc] initWithDatabase:self.database];
    NSArray *versionList = [self.child migrationVersionList];
    NSDictionary *migrationObjectContainer = [self.child migrationStepDictionary];
    NSMutableDictionary *latestRecord = [[[[[[[queryCommand select:nil isDistinct:NO]form:[KBVersionTable tableName]]orderBy:[KBVersionTable primaryKeyName] isDESC:YES] limit:1] fetchWithError:NULL] firstObject] mutableCopy];
    
    BOOL shouldPerformMigration = NO;
    for (NSString *version in versionList) {
        if (shouldPerformMigration) {
            id<KBPersistanceMigratorStepProtocol> step = [[migrationObjectContainer[version] alloc] init];
            NSError *error = nil;
            [queryCommand resetQueryCommand];
            [step goUpWithQueryCommand:queryCommand error:&error];
            if (error) {
                [step goDownWithQueryCommand:queryCommand error:&error];
                break;
            }else{
                latestRecord[@"databaseVersion"] = version;
                error = nil;
                [queryCommand resetQueryCommand];
                NSNumber *primaryKeyValue = latestRecord[@"identifier"];
                NSDictionary *whereConditionParams = NSDictionaryOfVariableBindings(primaryKeyValue);
                [[queryCommand updateTable:[KBVersionTable tableName] withData:latestRecord condition:[NSString stringWithFormat:@"%@ = :primaryKeyValue",[KBVersionTable primaryKeyName]] conditionParams:whereConditionParams]executeWithError:&error];
                
                if (error) {
                    NSLog(@"error at CTPersistanceMigrator:%d:%@", __LINE__, error);
                }
                
            }
            
        }
        if ([version isEqualToString:latestRecord[@"databaseVersion"]]) {
            shouldPerformMigration = YES;
        }
    }
    
    
}

@end
