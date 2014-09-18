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
#import "UIColor+RGBValues.h"
#import "HNAvatarView.h"

@implementation HNScheduleDetailViewController


- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    HNAvatarView* avatarView = [[HNAvatarView alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+5, 50, 50) letter:self.cell.type];
    [self.view addSubview:avatarView];
    
    UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+ 3, kiPhoneWidthPortrait - 72, 55)];
    nameLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:23];
    nameLabel.textColor = [[JPStyle interfaceTintColor] darkerColor];
    nameLabel.numberOfLines = 2;
    nameLabel.text = self.cell.name;
    [self.view addSubview:nameLabel];
    
    ///////////////////////////////////////////
    
    UIImageView* timeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+64.5, 15, 15)];
    [timeIcon setImage:[UIImage imageNamed:@"timeIcon"]];
    [self.view addSubview:timeIcon];
    
    UILabel* timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeIcon.frame.origin.x + timeIcon.frame.size.width + 1, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+61, 70, 20)];
    timeLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:17];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.text = [[NSDate dateWithISO8601CompatibleString:self.cell.startTime] timeStringForTableCell];
    [self.view addSubview:timeLabel];
    
    UIImageView* rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(89, timeIcon.frame.origin.y - 2, 16, 16)];
    rightArrow.contentMode = UIViewContentModeScaleAspectFit;
    rightArrow.image = [UIImage imageNamed:@"rightArrow"];
    [self.view addSubview:rightArrow];
    
    UILabel* endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(rightArrow.frame.origin.x + rightArrow.frame.size.width - 2, timeLabel.frame.origin.y, timeLabel.frame.size.width, timeLabel.frame.size.height)];
    NSDate* startDate = [NSDate dateWithISO8601CompatibleString:self.cell.endTime];
    endTimeLabel.text = [startDate timeStringForTableCell];
    //    endTimeLabel.textColor = [UIColor grayColor];
    endTimeLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:17];
    [self.view addSubview:endTimeLabel];

    //////////////////////////////////////////////
    UIImageView* locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(172, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+64.5, 15, 15)];
    [locationIcon setImage:[UIImage imageNamed:@"locationIcon"]];
    [self.view addSubview:locationIcon];
    
    UILabel* locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(locationIcon.frame.origin.x + locationIcon.frame.size.width + 1, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+61, kiPhoneWidthPortrait-189, 20)];
    locationLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:17];
    //    locationLabel.textColor = [UIColor grayColor];
    locationLabel.textAlignment = NSTextAlignmentLeft;
    locationLabel.text = self.cell.location;
    [self.view addSubview:locationLabel];
    
    //////////////////////////////////////////////////////
    UIImageView* typeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+64.5 + 20, 15, 15)];
    [typeIcon setImage:[UIImage imageNamed:@"typeIcon"]];
    [self.view addSubview:typeIcon];
    
    UILabel* typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(typeIcon.frame.origin.x + typeIcon.frame.size.width + 1, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+61 + 20, 130, 20)];
    typeLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:17];
//    typeLabel.textColor = [UIColor grayColor];
    typeLabel.text = [self.cell.type capitalizedString];
    typeLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:typeLabel];
    
    UIImageView* speakerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(118, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+64.5+ 20, 15, 15)];
    [speakerIcon setImage:[UIImage imageNamed:@"speakerIcon"]];
    [self.view addSubview:speakerIcon];
    
    UILabel* speakerLabel = [[UILabel alloc] initWithFrame:CGRectMake(speakerIcon.frame.origin.x + speakerIcon.frame.size.width + 1, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+61+ 20, 180, 20)];
    speakerLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:17];
//    speakerLabel.textColor = [UIColor grayColor];
    speakerLabel.textAlignment = NSTextAlignmentLeft;
    speakerLabel.text = self.cell.speaker;
    [self.view addSubview:speakerLabel];

    //////////////////////////////////////////////////////
    UIView* blueView = [[UIView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+ 110, kiPhoneWidthPortrait, kiPhoneHeightPortrait - (kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+ 105))];
    blueView.backgroundColor = [[JPStyle interfaceTintColor] colorWithAlphaComponent:0.2];
    [self.view addSubview:blueView];
    
    UILabel* detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+ 120, 200, 25)];
    detailLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
    detailLabel.text = @"Details";
    detailLabel.textColor = [UIColor blackColor];
    [self.view addSubview:detailLabel];
    
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight+ 150, kiPhoneWidthPortrait - 20, 305)];
    if(![JPStyle iPhone4Inch])
    {
        CGRect frame = textView.frame;
        frame.size.height -= 88;
        textView.frame = frame;
    }
    textView.backgroundColor = [UIColor clearColor];
    textView.showsVerticalScrollIndicator = NO;
    textView.font = [UIFont fontWithName:[JPFont defaultThinFont] size:17];
//    textView.textColor = [UIColor grayColor];
    textView.text = @"No Description Available";
    textView.editable = NO;
    textView.selectable = NO;
    textView.textContainerInset = UIEdgeInsetsZero;
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
