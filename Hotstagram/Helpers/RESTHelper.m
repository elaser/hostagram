//
//  RESTHelper.m
//  Hotstagram
//
//  Created by Anderthan Hsieh on 7/10/14.
//  Copyright (c) 2014 ahsieh. All rights reserved.
//

#import "RESTHelper.h"

static RESTHelper *_sharedInstance;

@implementation RESTHelper


/*
 * sharedInstance - singleton class for RESTHelper which will do the necessary REST calls
 */
+ (RESTHelper *) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[RESTHelper alloc] init];
    });
    return _sharedInstance;
}

@end
