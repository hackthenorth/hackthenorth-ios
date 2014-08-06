//
//  HNScheduleDetailViewController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/4/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNScheduleDetailViewController.h"
#import "UserInterfaceConstants.h"
#import "JPStyle.h"
#import "JPFont.h"
#import "HNScheduleTableViewCell.h"


@implementation HNScheduleDetailViewController


- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.cell.frame = CGRectMake(0, 0, kiPhoneWidthPortrait, 90);
    self.cell.accessoryType = UITableViewCellAccessoryNone;
    [self.view addSubview:self.cell];
    
    UILabel* detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+ 100, 200, 20)];
    detailLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:17];
    detailLabel.text = @"Details";
    detailLabel.textColor = [UIColor grayColor];
    [self.view addSubview:detailLabel];
    
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+ 120, kiPhoneWidthPortrait - 20, 340)];
    textView.backgroundColor = [UIColor clearColor];
    textView.showsVerticalScrollIndicator = NO;
    textView.font = [UIFont fontWithName:[JPFont defaultFont] size:15];
    
    textView.text = @"No Description Available";
    textView.editable = NO;
    textView.selectable = NO;
    [self.view addSubview:textView];
    
    
    //Set Detail String
    
    self.detailString = self.cell.descriptor;
    
}






- (void)setDetailString:(NSString *)detailString
{
    _detailString = detailString;
    textView.text = detailString;
}



@end
