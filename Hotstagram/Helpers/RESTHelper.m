//
//  RESTHelper.m
//  Hotstagram
//
//  Created by Anderthan Hsieh on 7/10/14.
//  Copyright (c) 2014 ahsieh. All rights reserved.
//

#import "RESTHelper.h"
#import "Constants.h"
#import <AFNetworking/AFNetworking.h>


static RESTHelper *_sharedInstance;

@interface RESTHelper ()

@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;

@end

@implementation RESTHelper


/*
 * sharedInstance - singleton class for RESTHelper which will do the necessary REST calls
 */
+ (RESTHelper *) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[RESTHelper alloc] init];
        _sharedInstance.manager = [AFHTTPRequestOperationManager manager];
    });
    return _sharedInstance;
}

- (void) obtainRecentMediaWithTag: (NSString *) tag {
    //Form Tag String
    NSString *recentMediaTagString = [NSString stringWithFormat:@"%@/tags/%@/media/recent", kINStagramBaseURL, tag];
    
    //Query Parameters
    /*
    NSDictionary *queryParameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                     kinst, nil]
     */
}

- (void) authenticateUserWithSuccess: (void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    //Form query parameters
    NSString *authenticationString = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&response_type=code", kINStagramAuthorizationURL, kINStagramClientID, kHOTredirectionURI];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authenticationString]];
    //[_sharedInstance.manager GET:kINStagramAuthorizationURL parameters:queryParameters success:success failure:failure];
}

@end
