//
//  KBQueryCommand.h
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBDataBase.h"

@interface KBQueryCommand : NSObject

@property(nonatomic,strong,readonly)NSMutableString *sqlString;

@property(nonatomic,weak,readonly)KBDataBase *database;

-(instancetype)initWithDatabaseName:(NSString *)databaseName;

-(instancetype)initWithDatabase:(KBDataBase *)database;

-(KBQueryCommand *)resetQueryCommand;

-(BOOL)executeWithError:(NSError **)error;

-(NSArray <NSDictionary *>*)fetchWithError:(NSError **)error;

@end
