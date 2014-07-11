//
//  RESTHelper.h
//  Hotstagram
//
//  Created by Anderthan Hsieh on 7/10/14.
//  Copyright (c) 2014 ahsieh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

@interface RESTHelper : NSObject

+ (RESTHelper *) sharedInstance;

- (void) obtainRecentMediaWithTag: (NSString *) tag;
- (void) authenticateUserWithSuccess: (void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
