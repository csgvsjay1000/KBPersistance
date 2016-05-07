//
//  KBPersistanceMigrator.m
//  KBPersistance
//
//  Created by chengshenggen on 5/7/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBPersistanceMigrator.h"

@interface KBPersistanceMigrator ()

@property(nonatomic,weak)KBDataBase *database;

@end

@implementation KBPersistanceMigrator

-(void)createVersionTableWithDatabase:(KBDataBase *)database{
    self.database = database;
    
}

@end
