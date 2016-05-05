//
//  KBQueryCommand+DataManipulations.h
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBQueryCommand.h"

@interface KBQueryCommand (DataManipulations)

-(KBQueryCommand *)insertTable:(NSString *)tableName withDataList:(NSArray *)dataList;

-(KBQueryCommand *)updateTable:(NSString *)tableName withData:(NSDictionary *)data condition:(NSString *)condition conditionParams:(NSDictionary *)conditionParams;

-(KBQueryCommand *)deleteTable:(NSString *)tableName withCondition:(NSString *)condition conditionParams:(NSDictionary *)conditionParams;

@end
