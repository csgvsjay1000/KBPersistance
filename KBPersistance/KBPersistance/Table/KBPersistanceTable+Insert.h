//
//  KBPersistanceTable+Insert.h
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBPersistanceTable.h"

@interface KBPersistanceTable (Insert)

-(BOOL)insertRecord:(NSObject <KBPersistanceRecordProtocol> *)record error:(NSError **)error;

@end
