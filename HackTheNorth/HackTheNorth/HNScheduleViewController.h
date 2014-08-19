//
//  HNScheduleViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 7/29/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNSearchViewController.h"

@class HNScheduleProgressView, HNDataManager;
@interface HNScheduleViewController : HNSearchViewController <UITableViewDataSource, UITableViewDelegate>
{
    HNDataManager*  manager;
    
    UIBarButtonItem* _searchItem;
    
    
    NSMutableArray* _friSatSunArray;
    
    
    NSArray*  _sectionTitles;
    
}


@property (nonatomic, strong) HNScheduleProgressView* scheduleView;



@end
