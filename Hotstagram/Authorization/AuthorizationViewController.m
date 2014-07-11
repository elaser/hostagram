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
#import "Constants.h"

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAuthenticationNotification:) name:@"authorization" object:nil];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString *checkAccessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kHOTDefaultsAccessTokenKey];
    if (checkAccessToken) {
        [RESTHelper sharedInstance].accessTokenString = checkAccessToken;
        [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"main_tab"] animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"authorization" object:nil];
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

#pragma mark - NSNotificationCenter
- (void) handleAuthenticationNotification: (NSNotification *)notification {
    if (!notification.object) {
        //We assume this is an error
        [[[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please allow us to access your Instagram account!  Don't you want to see your Hostagram score?" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
    }
    else {
        NSString *accessToken = notification.object;
        [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:kHOTDefaultsAccessTokenKey];
        [RESTHelper sharedInstance].accessTokenString = accessToken;
        [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"main_tab"] animated:YES completion:nil];
    }
}


#pragma mark - IBActions
/*
 * clickLoginButton - we need to authenticate the user via Instagram to obtain the Accesss Token
 */
- (IBAction)clickLoginButton:(id)sender {
    [[RESTHelper sharedInstance] authenticateUser];
}


@end
