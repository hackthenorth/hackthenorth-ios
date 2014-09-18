//
//  HNMentorsViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/4/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNSearchViewController.h"

@class HNDataManager;
@interface HNMentorsViewController : HNSearchViewController <UITableViewDelegate, UITableViewDataSource>
{
    HNDataManager*  manager;
    NSArray*     _infoArray;

}








@end
