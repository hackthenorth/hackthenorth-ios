//
//  HNPrizesViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "HNSearchViewController.h"

@class HNDataManager;
@interface HNPrizesViewController : HNSearchViewController  <MFMailComposeViewControllerDelegate>
{
    HNDataManager*  manager;
    NSArray*     _infoArray;
    
    MFMailComposeViewController* mailController;
}







@end
