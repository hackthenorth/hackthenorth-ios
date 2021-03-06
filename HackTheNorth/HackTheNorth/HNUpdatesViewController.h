//
//  FirstViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNDataManager;
@interface HNUpdatesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    HNDataManager*  manager;
    NSDictionary*  _infoDict;
    NSMutableArray* _infoArray;
    
    NSTimer   * _reUpdateLocallyTimer;
}



@property (nonatomic, strong) UITableView* tableView;



@end

