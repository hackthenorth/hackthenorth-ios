//
//  FirstViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNBannerView;
@interface HNNotificationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>




@property (nonatomic, strong) HNBannerView* banner;


@property (nonatomic, strong) UITableView* tableView;



@end

