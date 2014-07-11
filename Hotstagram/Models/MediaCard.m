//
//  MediaCard.m
//  Hotstagram
//
//  Created by Anderthan Hsieh on 7/10/14.
//  Copyright (c) 2014 ahsieh. All rights reserved.
//

#import "MediaCard.h"
#import <FastImageCache/FICUtilities.h>

@interface MediaCard ()

@end

@implementation MediaCard

@synthesize media_url, media_id, media_type, user_id, username;

- (NSString *) UUID {
    CFUUIDBytes UUIDBytes = FICUUIDBytesFromMD5HashOfString(self.media_id);
    return FICStringWithUUIDBytes(UUIDBytes);
}

- (NSString *)sourceImageUUID {
    CFUUIDBytes sourceImageUUIDBytes = FICUUIDBytesFromMD5HashOfString(self.media_url);
    NSString *sourceImageUUID = FICStringWithUUIDBytes(sourceImageUUIDBytes);
    
    return sourceImageUUID;
}

- (NSURL *)sourceImageURLWithFormatName:(NSString *)formatName {
    return [NSURL URLWithString:self.media_url];
}

- (FICEntityImageDrawingBlock)drawingBlockForImage:(UIImage *)image withFormatName:(NSString *)formatName {
    FICEntityImageDrawingBlock drawingBlock = ^(CGContextRef context, CGSize contextSize) {
        CGRect contextBounds = CGRectZero;
        contextBounds.size = contextSize;
        CGContextClearRect(context, contextBounds);
        
        UIGraphicsPushContext(context);
        [image drawInRect:contextBounds];
        UIGraphicsPopContext();
    };
    
    return drawingBlock;
}


#pragma mark - Deserialize/Serialize
+ (MediaCard *) buildMediaCardFromDictionary: (NSDictionary *)dictionary {
    MediaCard *media = [[MediaCard alloc] init];
    if (media) {
        //If we don't have an image, we should return nil
        if (![dictionary[@"type"] isEqualToString:@"image"])
            return nil;
        NSDictionary *userDictionary = dictionary[@"user"];
        media.username = userDictionary[@"username"];
        media.user_fullname = userDictionary[@"full_name"];
        media.user_id = userDictionary[@"id"];
        NSDictionary *imageDictionaries = dictionary[@"images"];
        NSDictionary *normalResolutionDictionary = imageDictionaries[@"standard_resolution"];
        media.media_id = dictionary[@"id"];
        media.media_type = @"image";
        media.media_url = normalResolutionDictionary[@"url"];
    }
    
    return media;
}

- (void) printOutValues {
    NSLog(@"username is %@", self.username);
    NSLog(@"user_fullname is %@", self.user_fullname);
    NSLog(@"user_id is %@", self.user_id);
    NSLog(@"media_id is %@", self.media_id);
    NSLog(@"media_url is %@", self.media_url);
}

@end
