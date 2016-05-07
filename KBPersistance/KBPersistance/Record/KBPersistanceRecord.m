//
//  KBPersistanceRecord.m
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBPersistanceRecord.h"
#import "objc/runtime.h"
#import "NSString+SQL.h"
#import "KBPersistanceTable.h"

@implementation KBPersistanceRecord

#pragma mark - KBPersistanceRecordProtocol

-(NSDictionary *)dictionaryRepresentationWithTable:(KBPersistanceTable<KBPersistanceTableProtocol> *)table{
    
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableDictionary *propertyDictionary = [[NSMutableDictionary alloc] init];
    while (count-->0) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[count])];
        id value = [self valueForKey:key];
        if (value == nil) {
            propertyDictionary[key] = [NSNull null];
        }else{
            propertyDictionary[key] = value;
        }
        
    }
    free(properties);
    NSMutableDictionary *dictionaryRepresentation = [[NSMutableDictionary alloc] init];
    [table.columnInfo enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull columnName, NSString * _Nonnull columnDescription, BOOL * _Nonnull stop) {
        if (propertyDictionary[columnName]) {
            dictionaryRepresentation[columnName] = propertyDictionary[columnName];
        }
    }];
    
    return dictionaryRepresentation;
}

- (BOOL)setPersistanceValue:(id)value forKey:(NSString *)key
{
    BOOL result = YES;
    NSString *setter = [NSString stringWithFormat:@"set%@%@:", [[key substringToIndex:1] capitalizedString], [key substringFromIndex:1]];
    if ([self respondsToSelector:NSSelectorFromString(setter)]) {
        if ([value isKindOfClass:[NSString class]]) {
            [self setValue:[value safeSQLDecode] forKey:key];
        } else if ([value isKindOfClass:[NSNull class]]) {
            [self setValue:nil forKey:key];
        } else {
            [self setValue:value forKey:key];
        }
    } else {
        result = NO;
    }
    
    return result;
}

@end
