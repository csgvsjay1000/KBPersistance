//
//  KBPersistanceTable.h
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBPersistanceRecord.h"

@protocol KBPersistanceTableProtocol <NSObject>

@required
- (NSString *)databaseName;
- (NSString *)tableName;
- (NSDictionary *)columnInfo;
- (NSString *)primaryKeyName;

@optional
-(BOOL)isCorrectToInsertRecord:(NSObject <KBPersistanceRecordProtocol> *)record;

-(BOOL)isCorrectToUpdateRecord:(NSObject <KBPersistanceRecordProtocol> *)record;

@end

@interface KBPersistanceTable : NSObject

@property(nonatomic,weak,readonly)KBPersistanceTable<KBPersistanceTableProtocol> *child;

-(BOOL)executeSQL:(NSString *)sqlString error:(NSError **)error;

-(NSArray *)fetchWithSQL:(NSString *)sqlString error:(NSError **)error;

@end
