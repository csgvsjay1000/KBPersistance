//
//  KBDatabasePool.h
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBDataBase.h"

@interface KBDatabasePool : NSObject

+(instancetype)sharedInstance;

-(KBDataBase *)databaseWithName:(NSString *)databaseName;

-(void)closeAllDatabase;

-(void)closeDatabaseWithName:(NSString *)databaseName;

@end
