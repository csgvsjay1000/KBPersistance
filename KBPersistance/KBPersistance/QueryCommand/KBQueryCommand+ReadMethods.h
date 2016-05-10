//
//  KBQueryCommand+ReadMethods.h
//  KBPersistance
//
//  Created by chengshenggen on 5/10/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBQueryCommand.h"

@interface KBQueryCommand (ReadMethods)

-(KBQueryCommand *)select:(NSString *)columnList isDistinct:(BOOL)isDistinct;

-(KBQueryCommand *)form:(NSString *)formList;

-(KBQueryCommand *)where:(NSString *)condition params:(NSDictionary *)params;

-(KBQueryCommand *)orderBy:(NSString *)orderBy isDESC:(BOOL)isDESC;

-(KBQueryCommand *)limit:(NSInteger)limit;

-(KBQueryCommand *)offset:(NSInteger)offset;

-(KBQueryCommand *)limit:(NSInteger)limit offset:(NSInteger)offset;

@end
