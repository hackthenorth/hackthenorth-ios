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
#import "NSDate+HNConvenience.h"


@implementation HNScheduleDetailViewController


- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.cell.frame = CGRectMake(0, 0, kiPhoneWidthPortrait, 90);
    self.cell.accessoryType = UITableViewCellAccessoryNone;
    [self.view addSubview:self.cell];
    
    UIImageView* rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(85, kiPhoneNavigationBarHeight+kiPhoneStatusBarHeight + 84, 16, 16)];
    rightArrow.contentMode = UIViewContentModeScaleAspectFit;
    rightArrow.image = [UIImage imageNamed:@"rightArrow"];
    [self.view addSubview:rightArrow];
    
    UILabel* endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(rightArrow.frame.origin.x + rightArrow.frame.size.width - 1, rightArrow.frame.origin.y - 3, 100, 20)];
    NSDate* startDate = [NSDate dateWithISO8601CompatibleString:self.cell.endTime];
    endTimeLabel.text = [startDate timeStringForTableCell];
    
    endTimeLabel.textColor = [UIColor grayColor];
    endTimeLabel.font = [JPFont fontWithName:[JPFont defaultFont] size:15];
    [self.view addSubview:endTimeLabel];
    
    UILabel* detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+ 100, 200, 20)];
    detailLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:17];
    detailLabel.text = @"Details";
    detailLabel.textColor = [UIColor blackColor];
    [self.view addSubview:detailLabel];
    
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+ 120, kiPhoneWidthPortrait - 20, 340)];
    textView.backgroundColor = [UIColor clearColor];
    textView.showsVerticalScrollIndicator = NO;
    textView.font = [UIFont fontWithName:[JPFont defaultFont] size:15];
    textView.textColor = [UIColor grayColor];
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
