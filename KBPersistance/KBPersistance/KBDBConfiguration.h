//
//  KBDBConfiguration.h
//  KBPersistance
//
//  Created by chengshenggen on 5/5/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#ifndef KBDBConfiguration_h
#define KBDBConfiguration_h

static NSString *const KeyKBdbErrorDomain = @"KeyKBdbErrorDomain";

typedef NS_ENUM(NSUInteger,KBdbErrorCode) {
    KBdbErrorCodeOpenError,
    KBdbErrorCodeCreateError,
    KBdbErrorCodeQueryStringError,
};

#endif /* KBDBConfiguration_h */
