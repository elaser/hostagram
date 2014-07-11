//
//  StatsTableViewController.h
//  Hotstagram
//
//  Created by Anderthan Hsieh on 7/10/14.
//  Copyright (c) 2014 ahsieh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatsTableViewController : UITableViewController

@end

@interface ScoreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userScoreLabel;

@end