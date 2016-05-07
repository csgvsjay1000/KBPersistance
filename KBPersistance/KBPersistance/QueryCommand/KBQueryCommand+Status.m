//
//  KBQueryCommand+Status.m
//  KBPersistance
//
//  Created by chengshenggen on 5/6/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBQueryCommand+Status.h"

@implementation KBQueryCommand (Status)

- (NSNumber *)lastInsertRowId
{
    return @(sqlite3_last_insert_rowid(self.database.database));
}

- (NSNumber *)rowsChanged
{
    return @(sqlite3_changes(self.database.database));
}

@end
