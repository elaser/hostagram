//
//  AuthorizationViewController.m
//  Hotstagram
//
//  Created by Anderthan Hsieh on 7/10/14.
//  Copyright (c) 2014 ahsieh. All rights reserved.
//

#import "AuthorizationViewController.h"
#import "RESTHelper.h"
#import <AFNetworking/AFNetworking.h>

@interface AuthorizationViewController ()

@end

@implementation AuthorizationViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - IBActions
/*
 * clickLoginButton - we need to authenticate the user via Instagram to obtain the Accesss Token
 */
- (IBAction)clickLoginButton:(id)sender {
    [[RESTHelper sharedInstance] authenticateUserWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject is %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error is %@", error);
    }
     ];
}


@end
