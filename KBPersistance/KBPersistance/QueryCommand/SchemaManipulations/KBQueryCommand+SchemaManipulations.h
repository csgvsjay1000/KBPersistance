//
//  KBQueryCommand+SchemaManipulations.h
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBQueryCommand.h"

@interface KBQueryCommand (SchemaManipulations)

-(KBQueryCommand *)createTable:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo;

-(KBQueryCommand *)addColumn:(NSString *)columnName columnInfo:(NSString *)columnInfo tableName:(NSString *)tableName;

@end
