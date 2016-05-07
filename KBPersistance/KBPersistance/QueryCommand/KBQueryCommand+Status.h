//
//  KBQueryCommand+Status.h
//  KBPersistance
//
//  Created by chengshenggen on 5/6/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBQueryCommand.h"

@interface KBQueryCommand (Status)

/**
 *  return last insert row id
 *
 *  @return return last insert row id
 */
- (NSNumber *)lastInsertRowId;
- (NSNumber *)rowsChanged;

@end
