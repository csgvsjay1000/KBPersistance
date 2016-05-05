//
//  NSString+SQL.m
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "NSString+SQL.h"

@implementation NSString (SQL)

- (NSString *)safeSQLMetaString
{
    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@"'`"];
    return [[self componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
}

- (NSString *)safeSQLEncode
{
    NSString *safeSQL = [self copy];
    safeSQL = [safeSQL stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
    safeSQL = [safeSQL stringByReplacingOccurrencesOfString:@";" withString:@""];
    return safeSQL;
}

@end
