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
    
    self.title = self.cell.name;
    
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
    
    self.detailString = @"Most neurons in primary visual cortex do not respond strongly to static images, but respond vigorously to flashed and moving bars and gratings. The receptive field structure of figure 2.17 reveals why this is the case, as is shown in figures 2.19 and 2.20. The image in figures 2.19A-C is a dark bar that is flashed on for a brief period of time. To describe the linear response estimate at different times we show a cartoon of a space-time receptive field similar to the one in figure 2.17A. The receptive field is positioned at three different times in figures 2.19A, B, and C. The height of the horizontal axis of the receptive field diagram indicates the time when the estimation is being made. Figure 2.19A corresponds to an estimate of L(t) at the moment when the image first appears. At this time, L(t) = 0. As time progresses, the receptive field diagram moves upward. Figure 2.19B generates an estimate at the moment of maximum response when the dark image overlaps the OFF area of the space-time receptive field, producing a positive contribution to L(t). Figure 2.19C shows a later time when the dark image overlaps an ON region, generating a negative L(t). The response for this flashed image is thus transient firing followed by suppression, as shown in Figure 2.19D.";
    
}



- (void)setDetailString:(NSString *)detailString
{
    _detailString = detailString;
    
    textView.text = detailString;
}



@end
