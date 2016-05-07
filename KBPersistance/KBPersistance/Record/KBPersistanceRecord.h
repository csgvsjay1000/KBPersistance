//
//  KBPersistanceRecord.h
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KBPersistanceTable;
@protocol KBPersistanceTableProtocol;

@protocol KBPersistanceRecordProtocol <NSObject>

@required
- (NSDictionary *)dictionaryRepresentationWithTable:(KBPersistanceTable <KBPersistanceTableProtocol> *)table;

@end

@interface KBPersistanceRecord : NSObject<KBPersistanceRecordProtocol>

@end
