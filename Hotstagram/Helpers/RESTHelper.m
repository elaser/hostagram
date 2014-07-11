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
#import "MediaCard.h"


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

        _sharedInstance.allMediaCards = [NSMutableArray array];
    });
    return _sharedInstance;
}

- (void) obtainRecentMediaWithTag: (NSString *) tag {
    //Form Tag String
    NSString *recentMediaTagString = [NSString stringWithFormat:@"%@/tags/%@/media/recent", kINStagramBaseURL, tag];
    //Query Parameters
    NSDictionary *queryParameters = @{@"access_token": _sharedInstance.accessTokenString, @"COUNT":@(4)};
    [_sharedInstance.manager GET:recentMediaTagString parameters:queryParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dataArray = responseObject[@"data"];
        [_sharedInstance.allMediaCards addObjectsFromArray:[_sharedInstance processRecentMedia:dataArray]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure is %@", error);
    }];
}

- (NSArray *) processRecentMedia: (NSArray *) mediaArray {
    //So we have a media array, and we want to be able to build actual objects out of these serialized NSDictionaries
    NSMutableArray *recentMediaArray = [NSMutableArray array];
    for (NSDictionary *mediaDictionary in mediaArray) {
        MediaCard *currentMedia = [MediaCard buildMediaCardFromDictionary:mediaDictionary];
        if (currentMedia)
            [recentMediaArray addObject:currentMedia];
    }
    return recentMediaArray;
}


/*
 *  Due to time constraints I'm not able to pass in a block so that I can execute code after I have definitely determined there are selfies.  I'm just going to return nil for now and it's up to the view controller to determine what to do.
 */
- (NSArray *) obtainTwoSelfies {
    if (_sharedInstance.allMediaCards.count < 2) {
        [self obtainRecentMediaWithTag:kHOTTag];
        return nil;
    }
    else {
        if (_sharedInstance.allMediaCards.count < 10) {
            [self obtainRecentMediaWithTag:kHOTTag];
        }
        NSArray *dosSelfiesArray = @[_sharedInstance.allMediaCards[0], _sharedInstance.allMediaCards[1]];
        [_sharedInstance.allMediaCards removeObjectAtIndex:0];
        [_sharedInstance.allMediaCards removeObjectAtIndex:0];
        return dosSelfiesArray;
    }
}

/*
 * I ran out of time to make this pass back blocks, but it would be a lot better so that we can sideload and execute code after the necessary objects have been grabbed.
 */
- (void) authenticateUser {
    //Form query parameters
    NSString *authenticationString = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&response_type=token", kINStagramAuthorizationURL, kINStagramClientID, kHOTredirectionURI];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authenticationString]];
    //[_sharedInstance.manager GET:kINStagramAuthorizationURL parameters:queryParameters success:success failure:failure];
}


/*
 * recordResultOfBattle - We will require two parameters : selfie1 and selfie 2.  We will send this information up to the backend so that the backend can parse the battle and record appropriately
 */
- (void) recordResultOfBattleWithWinner: (MediaCard *) winner withLoser: (MediaCard *) loser {
    //We need to create a dictionary with the winner and loser
    if (!winner || !loser)
        return;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *battleDictionary = @{@"battle": @{@"winner": [winner buildContestantDictionary], @"loser": [loser buildContestantDictionary]}};
        
        NSString *battleRecordURL = [NSString stringWithFormat:@"%@/battles", kHOTBackendURL];
        [_sharedInstance.manager POST:battleRecordURL parameters:battleDictionary success:nil failure:nil];
    });
}


- (void) getTopScoresWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSString *scoresString = [NSString stringWithFormat:@"%@/scores", kHOTBackendURL];
    [_sharedInstance.manager GET:scoresString parameters:nil success:success failure:failure];
}
@end
