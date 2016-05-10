//
//  KBPersistanceMigrator.h
//  KBPersistance
//
//  Created by chengshenggen on 5/7/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBDataBase.h"
#import "KBQueryCommand.h"

@protocol KBPersistanceMigratorProtocol <NSObject>

@required
- (NSArray *)migrationVersionList;
- (NSDictionary *)migrationStepDictionary;

@end

@protocol KBPersistanceMigratorStepProtocol <NSObject>

/**
 升级版本
 */
-(void)goUpWithQueryCommand:(KBQueryCommand *)queryCommand error:(NSError **)error;

/**
    降级版本，当升级出错时。
 */
-(void)goDownWithQueryCommand:(KBQueryCommand *)queryCommand error:(NSError **)error;

@end

@interface KBPersistanceMigrator : NSObject

- (void)createVersionTableWithDatabase:(KBDataBase *)database;

-(BOOL)shouldMigrate:(KBDataBase *)database;

-(void)performMigrate:(KBDataBase *)database;

@end
