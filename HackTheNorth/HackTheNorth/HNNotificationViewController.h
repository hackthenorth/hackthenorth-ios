//
//  FirstViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNBannerView, HNDataManager;
@interface HNNotificationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    HNDataManager*  manager;
    NSArray*     _infoArray;
}



@property (nonatomic, strong) HNBannerView* banner;


@property (nonatomic, strong) UITableView* tableView;



@end

