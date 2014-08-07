//
//  HNScheduleViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 7/29/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNScheduleProgressView, HNDataManager;
@interface HNScheduleViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    HNDataManager*  manager;
    NSArray*     _infoArray;
    
    NSMutableArray* _friSatSunArray;
    
    
    NSArray*  _sectionTitles;
    
}


@property (nonatomic, strong) HNScheduleProgressView* scheduleView;

@property (nonatomic, strong) UITableView* tableView;


@end
