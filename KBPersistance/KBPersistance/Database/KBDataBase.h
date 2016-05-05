//
//  KBDataBase.h
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface KBDataBase : NSObject

@property(nonatomic,assign,readonly)sqlite3 *database;

@property(nonatomic,copy,readonly)NSString *databaseName;

@property(nonatomic,copy,readonly)NSString *databaseFilePath;

- (instancetype)initWithDatabaseName:(NSString *)databaseName error:(NSError **)error;

- (void)closeDatabase;

@end
