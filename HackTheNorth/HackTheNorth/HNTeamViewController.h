//
//  HNTeamViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/4/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class HNDataManager;
@interface HNTeamViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
{
    HNDataManager*  manager;
    NSArray*     _infoArray;
    
    MFMailComposeViewController* mailController;
}

@property (nonatomic, strong) UITableView* tableView;

@end
