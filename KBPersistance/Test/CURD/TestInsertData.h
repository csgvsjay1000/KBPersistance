//
//  TestInsertData.h
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBPersistance.h"

@interface TestInsertData : NSObject

@end

@interface TestTable : KBPersistanceTable<KBPersistanceTableProtocol>

+ (NSString *)tableName;

@end

@interface TestRecord : NSObject<KBPersistanceRecordProtocol>

@property (nonatomic, strong) NSNumber *primaryKey;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *tomas;

@property(nonatomic,copy)NSString *migration1_0;  //版本2.0新增字段

@end
