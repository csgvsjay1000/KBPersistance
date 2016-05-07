//
//  KBPersistanceMigrator.h
//  KBPersistance
//
//  Created by chengshenggen on 5/7/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBDataBase.h"

@interface KBPersistanceMigrator : NSObject

- (void)createVersionTableWithDatabase:(KBDataBase *)database;

@end
