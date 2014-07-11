//
//  MainViewController.m
//  Hotstagram
//
//  Created by Anderthan Hsieh on 7/10/14.
//  Copyright (c) 2014 ahsieh. All rights reserved.
//

#import "MainViewController.h"
#import "RESTHelper.h"
#import "MediaCard.h"
#import <FastImageCache/FICImageCache.h>
#import "Constants.h"

@interface MainViewController ()

@property MediaCard *m1;
@property MediaCard *m2;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self populateImages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) populateImages {
    //Populate our selfie images!
    NSArray *dosSelfiesArray = [[RESTHelper sharedInstance] obtainTwoSelfies];
    _m1 = [dosSelfiesArray firstObject];
    _m2 = [dosSelfiesArray lastObject];
    
    [[FICImageCache sharedImageCache] retrieveImageForEntity:_m1 withFormatName:kFICRegularPictureName completionBlock:^(id<FICEntity> entity, NSString *formatName, UIImage *image) {
        _selfieA.image = image;
    }];
    
    [[FICImageCache sharedImageCache] retrieveImageForEntity:_m2 withFormatName:kFICRegularPictureName completionBlock:^(id<FICEntity> entity, NSString *formatName, UIImage *image) {
        _selfieB.image = image;
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)m1ClickedOn:(id)sender {
    [[RESTHelper sharedInstance] recordResultOfBattleWithWinner:_m1 withLoser:_m2];
    [self populateImages];
}

- (IBAction)m2ClickedOn:(id)sender {
    [[RESTHelper sharedInstance] recordResultOfBattleWithWinner:_m2 withLoser:_m1];
    [self populateImages];
}

@end
