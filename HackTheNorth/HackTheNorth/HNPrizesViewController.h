//
//  HNPrizesViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNDataManager;
@interface HNPrizesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    HNDataManager*  manager;
    NSArray*     _infoArray;
}



@property (nonatomic, strong) UITableView* tableView;


@end
