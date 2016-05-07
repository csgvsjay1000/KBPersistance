//
//  TestDataCenter.h
//  KBPersistance
//
//  Created by chengshenggen on 5/7/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestInsertData.h"

@interface TestDataCenter : NSObject

-(BOOL)saveRecord:(TestRecord *)record;

@end
