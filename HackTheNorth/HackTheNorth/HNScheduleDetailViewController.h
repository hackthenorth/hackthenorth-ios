//
//  HNScheduleDetailViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/4/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNScheduleTableViewCell;
@interface HNScheduleDetailViewController : UIViewController
{
    UITextView*  textView;
}


@property (nonatomic, strong) HNScheduleTableViewCell* cell;

@property (nonatomic, strong) NSString* detailString;





@end
