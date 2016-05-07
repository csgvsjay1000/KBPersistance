//
//  KBPersistanceTable+Insert.m
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBPersistanceTable+Insert.h"
#import "KBQueryCommand.h"
#import "KBQueryCommand+DataManipulations.h"
#import "KBQueryCommand+Status.h"
#import "KBDBConfiguration.h"

@implementation KBPersistanceTable (Insert)

-(BOOL)insertRecord:(NSObject<KBPersistanceRecordProtocol> *)record error:(NSError *__autoreleasing *)error{
    BOOL isSuccessed = YES;
    if (record) {
        if ([self.child isCorrectToInsertRecord:record]) {
            KBQueryCommand *queryCommand = [[KBQueryCommand alloc] initWithDatabaseName:self.child.databaseName];
            if ([[queryCommand insertTable:self.child.tableName withDataList:@[[record dictionaryRepresentationWithTable:self.child]]] executeWithError:error]) {
                if ([[queryCommand rowsChanged] integerValue]>0) {
                    return isSuccessed;
                }else{
                    isSuccessed = NO;
                    if (error) {
                        *error = [self errorWithRecord:record];
                    }
                }
            }else {
                isSuccessed = NO;
            }
        }else {
            isSuccessed = NO;
            if (error) {
                *error = [self errorWithRecord:record];
            }
        }
    }
    
    
    return isSuccessed;
}

- (NSError *)errorWithRecord:(NSObject <KBPersistanceRecordProtocol> *)record
{
    return [NSError errorWithDomain:KeyKBdbErrorDomain
                               code:KBdbErrorCodeRecordNotAvailableToInsert
                           userInfo:@{
                                      NSLocalizedDescriptionKey:[NSString stringWithFormat:@"\n\n%@\n is failed to pass validation, and can not insert", [record dictionaryRepresentationWithTable:self.child]],
                                      KBdbErrorUserinfoKeyErrorRecord:record
                                      }];
}

@end
