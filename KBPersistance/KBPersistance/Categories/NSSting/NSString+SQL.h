//
//  NSString+SQL.h
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SQL)

/**
 *  make string safe for SQL using which will remove (`) and (')
 *
 *  @return return the string which has removed (`) and (')
 */
- (NSString *)safeSQLMetaString;

/**
 *  make string safe as a SQL string which will turn (') to (\') and (\) to (\\) and remove every (;).
 *
 *  @return return the encoded string.
 *
 *  @see safeSQLDecode
 */
- (NSString *)safeSQLEncode;

/**
 *  decode the string which is encoded for SQL.
 *
 *  @return return the decoded string.
 *
 *  @see safeSQLDecode
 *  @see safeSQLMetaString
 */
- (NSString *)safeSQLDecode;

/**
 *  put params in string. The key in string should start with colon, and the key in Params don't. this method will add colon before matching.
 *
 *  Example:
 *
 *  NSString *foo = @"hello :bar"; // the key in string must start wich colon
 *  NSDictionary *params = @{
 *      @"bar":@"world" // don't put colon in key
 *  };
 *
 *  will generate @"hello world"
 *
 *  @param params params in string to replace
 *
 *  @return return a string.
 */
- (NSString *)stringWithSQLParams:(NSDictionary *)params;

@end
