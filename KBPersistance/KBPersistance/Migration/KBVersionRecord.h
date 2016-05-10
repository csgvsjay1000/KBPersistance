//
//  KBVersionRecord.h
//  KBPersistance
//
//  Created by chengshenggen on 5/7/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBPersistanceTable.h"
#import "KBPersistanceTable+Insert.h"
#import "KBDataBase.h"

@interface KBVersionRecord : NSObject<KBPersistanceRecordProtocol>

@property (nonatomic, copy) NSNumber *identifier;

@property (nonatomic, copy) NSString *databaseVersion;

@end

@interface KBVersionTable : KBPersistanceTable<KBPersistanceTableProtocol>

- (instancetype)initWithDatabase:(KBDataBase *)database;

+(NSString *)tableName;

+ (NSString *)primaryKeyName;

+ (NSDictionary *)columnInfo;

@end
