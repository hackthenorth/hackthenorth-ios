//
//  HNTeamViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/4/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HNTeamViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) UITableView* tableView;

@end
