//
//  KBQueryCommand+ReadMethods.m
//  KBPersistance
//
//  Created by chengshenggen on 5/10/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBQueryCommand+ReadMethods.h"
#import "NSString+SQL.h"

@implementation KBQueryCommand (ReadMethods)

-(KBQueryCommand *)select:(NSString *)columnList isDistinct:(BOOL)isDistinct{
    [self resetQueryCommand];
    if (columnList == nil) {
        if (isDistinct) {
            [self.sqlString appendString:@"SELECT DISTINCT * "];
        }else{
            [self.sqlString appendString:@"SELECT * "];
        }
    }else{
        if (isDistinct) {
            [self.sqlString appendFormat:@"SELECT DISTINCT '%@' ",[columnList safeSQLEncode]];
        }else{
            [self.sqlString appendFormat:@"SELECT '%@' ",[columnList safeSQLEncode]];
        }
    }
    
    return self;
}

-(KBQueryCommand *)form:(NSString *)formList{
    if (formList == nil) {
        return self;
    }
    [self.sqlString appendFormat:@"FROM '%@' ",formList];
    return self;
}

-(KBQueryCommand *)where:(NSString *)condition params:(NSDictionary *)params{
    if (condition == nil) {
        return self;
    }
    NSString *whereString = [condition stringWithSQLParams:params];
    [self.sqlString appendFormat:@"WHERE %@ ",whereString];
    
    return self;
}

-(KBQueryCommand *)orderBy:(NSString *)orderBy isDESC:(BOOL)isDESC{
    if (orderBy == nil) {
        return self;
    }
    [self.sqlString appendFormat:@"ORDER BY %@ ",[orderBy safeSQLMetaString]];
    if (isDESC) {
        [self.sqlString appendString:@"DESC "];
    }else{
        [self.sqlString appendString:@"ASC "];
    }
    return self;
}

-(KBQueryCommand *)limit:(NSInteger)limit{
    
    if (limit < 0) {
        return self;
    }
    [self.sqlString appendFormat:@"LIMIT %lu ",limit];
    return self;
}

-(KBQueryCommand *)offset:(NSInteger)offset{
    if (offset < 0) {
        return self;
    }
    [self.sqlString appendFormat:@"OFFSET %lu ",offset];
    
    return self;
}

-(KBQueryCommand *)limit:(NSInteger)limit offset:(NSInteger)offset{
    
    return [[self limit:limit] offset:offset];
}

@end
