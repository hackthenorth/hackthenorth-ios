//
//  NSScheduleTableViewCell.m
//  HackTheNorth
//
//  Created by Si Te Feng on 7/29/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNScheduleTableViewCell.h"
#import "UserInterfaceConstants.h"
#import "JPFont.h"
#import "JPStyle.h"
#import "HNAvatarView.h"

@implementation HNScheduleTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    // Initialization code
    self.separatorInset = UIEdgeInsetsMake(0, kiPhoneWidthPortrait, 0, 0);
    
    avatarView = [[HNAvatarView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    [self addSubview:avatarView];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, kiPhoneWidthPortrait - 70, 40)];
    nameLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:17];
    nameLabel.numberOfLines = 2;
    nameLabel.text = @"Introductory Talk for Hack the North Event";
    [self addSubview:nameLabel];
    
    locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, 100, 20)];
    locationLabel.text = @"MC 4042";
    locationLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:15];
    locationLabel.textColor = [UIColor grayColor];
    locationLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:locationLabel];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 60, 70, 20)];
    timeLabel.text = @"12:00";
    timeLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:15];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:timeLabel];
    
    
    speakerLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 60, 120, 20)];
    speakerLabel.text = @"Ariel Garten";
    speakerLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:15];
    speakerLabel.textColor = [UIColor grayColor];
    speakerLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:speakerLabel];
    
    UIImageView* locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(18, 64, 12, 12)];
    [locationIcon setImage:[UIImage imageNamed:@"locationIcon"]];
    [self addSubview:locationIcon];
    
    UIImageView* timeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(118, 64, 12, 12)];
    [timeIcon setImage:[UIImage imageNamed:@"timeIcon"]];
    [self addSubview:timeIcon];
    
    UIImageView* speakerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(188, 64, 12, 12)];
    [speakerIcon setImage:[UIImage imageNamed:@"speakerIcon"]];
    [self addSubview:speakerIcon];
    
    return self;
}




@end