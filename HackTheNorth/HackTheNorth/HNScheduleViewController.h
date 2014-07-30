//
//  HNScheduleViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 7/29/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNScheduleProgressView;
@interface HNScheduleViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray*  _sectionTitles;
    
}


@property (nonatomic, strong) HNScheduleProgressView* scheduleView;

@property (nonatomic, strong) UITableView* tableView;


@end
