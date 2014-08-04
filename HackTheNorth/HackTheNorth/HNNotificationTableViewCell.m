//
//  HNNotificationTableViewCell.m
//  HackTheNorth
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNNotificationTableViewCell.h"
#import "UserInterfaceConstants.h"
#import "JPFont.h"
#import "HNAvatarView.h"
#import "JPGlobal.h"


NSString* dateTextColor = @"0D7EA0";

@implementation HNNotificationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.separatorInset = UIEdgeInsetsMake(0, kiPhoneWidthPortrait, 0, 0);
        
        avatarView = [[HNAvatarView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
        [self addSubview:avatarView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, 190, 40)];
        nameLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:18];
        nameLabel.numberOfLines = 2;
        [self addSubview:nameLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kiPhoneWidthPortrait - 65, 10, 60, 16)];
        timeLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:13];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:timeLabel];
        
        dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(kiPhoneWidthPortrait - 65, 26, 60, 16)];
        dayLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:13];
        dayLabel.textColor = [UIColor grayColor];
        dayLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:dayLabel];
        
        messageView = [[UITextView alloc] initWithFrame:CGRectMake(10, 55, kiPhoneWidthPortrait-20, 65)];
        messageView.backgroundColor = [UIColor clearColor];
        messageView.editable = NO;
        messageView.selectable = NO;
        messageView.font = [UIFont fontWithName:[JPFont defaultFont] size:13];
        [self addSubview:messageView];
        
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}










#pragma mark - Setters and Getters
- (void)setName:(NSString *)name
{
    _name = name;
    nameLabel.text = name;
}

- (void)setDate:(NSDate *)date
{
    _date = date;
    
    NSDateFormatter* timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"hh:mm a"];
    
    timeLabel.text = [timeFormatter stringFromDate:date];
    
    
    NSDateComponents* dateComp = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    dayLabel.text = [NSString stringWithFormat:@"%@ %d", [JPGlobal monthStringWithInt:[dateComp month]], [dateComp day]];
    
}

- (void)setAvatarImage:(UIImage *)avatarImage
{
    _avatarImage = avatarImage;
    avatarView.image = avatarImage;
}

- (void)setMessage:(NSString *)message
{
    _message = message;
    messageView.text = message;
}

@end
