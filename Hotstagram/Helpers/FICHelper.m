//
//  FICHelper.m
//  Hotstagram
//
//  Created by Anderthan Hsieh on 7/10/14.
//  Copyright (c) 2014 ahsieh. All rights reserved.
//

#import "FICHelper.h"
#import <FastImageCache/FICImageCache.h>
#import "Constants.h"
#import <AFNetworking/AFNetworking.h>

static FICHelper *_sharedInstance = nil;

@interface FICHelper () <FICImageCacheDelegate>

@end

@implementation FICHelper

+ (FICHelper *) sharedInstance {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        _sharedInstance = [[FICHelper alloc] init];
        
        FICImageFormat *regularPictureImageFormat = [[FICImageFormat alloc] init];
        regularPictureImageFormat.name = kFICRegularPictureName;
        regularPictureImageFormat.family = @"normal-family";
        regularPictureImageFormat.style = FICImageFormatStyle16BitBGR;
        regularPictureImageFormat.imageSize = CGSizeMake(225, 225);
        regularPictureImageFormat.maximumCount = 250;
        regularPictureImageFormat.devices = FICImageFormatDevicePhone;
        [FICImageCache sharedImageCache].delegate = _sharedInstance;
        
        NSArray *imageFormats = @[regularPictureImageFormat];
        [FICImageCache sharedImageCache].formats = imageFormats;
        
    });
    
    return _sharedInstance;
}

#pragma mark - FICImageCacheDelegate
- (void)imageCache:(FICImageCache *)imageCache wantsSourceImageForEntity:(id<FICEntity>)entity withFormatName:(NSString *)formatName completionBlock:(FICImageRequestCompletionBlock)completionBlock {
    [[AFHTTPSessionManager manager] GET:[entity sourceImageURLWithFormatName:formatName].absoluteString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject is %@", responseObject);
        completionBlock(responseObject);
    } failure:nil];
}

@end
