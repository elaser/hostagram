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

@property NSString *accessTokenString;
@property NSMutableArray *allMediaCards;

+ (RESTHelper *) sharedInstance;

- (NSArray *) processRecentMedia: (NSArray *) mediaArray;
- (void) obtainRecentMediaWithTag: (NSString *) tag;
- (void) authenticateUser;
- (NSArray *) obtainTwoSelfies;

@end
