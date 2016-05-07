//
//  KBVersionRecord.m
//  KBPersistance
//
//  Created by chengshenggen on 5/7/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBVersionRecord.h"

@implementation KBVersionRecord

- (NSDictionary *)dictionaryRepresentationWithTable:(KBPersistanceTable <KBPersistanceTableProtocol> *)table{
    return @{
             @"identifier":self.identifier?self.identifier:[NSNull null],
             @"databaseVersion":self.databaseVersion?self.databaseVersion:[NSNull null],
             };
}

@end

@implementation KBVersionTable



@end
