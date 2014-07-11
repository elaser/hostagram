//
//  MediaCard.h
//  Hotstagram
//
//  Created by Anderthan Hsieh on 7/10/14.
//  Copyright (c) 2014 ahsieh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FastImageCache/FICEntity.h>

@interface MediaCard : NSObject <FICEntity>

@property NSString *media_id;
@property NSString *media_url;
@property NSString *media_type;
@property NSNumber *user_id;
@property NSString *username;
@property NSString *user_fullname;


+ (MediaCard *) buildMediaCardFromDictionary: (NSDictionary *)dictionary;

@end
