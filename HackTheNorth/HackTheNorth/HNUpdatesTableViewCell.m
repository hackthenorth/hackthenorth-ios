//
//  HNNotificationTableViewCell.m
//  HackTheNorth
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNUpdatesTableViewCell.h"
#import "UserInterfaceConstants.h"
#import "JPFont.h"
#import "HNAvatarView.h"
#import "JPGlobal.h"
#import "NSDate+HNConvenience.h"

static const NSTimeInterval kInterfaceRefreshInterval = 10; //for time


@implementation HNUpdatesTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.separatorInset = UIEdgeInsetsZero;
//        UIEdgeInsetsMake(0, kiPhoneWidthPortrait, 0, 0);
        
        avatarView = [[HNAvatarView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
        [self addSubview:avatarView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, kiPhoneWidthPortrait-70, 22)];
        nameLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:18];
        nameLabel.numberOfLines = 2;
        [self addSubview:nameLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 32, kiPhoneWidthPortrait-70, 18)];
        timeLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:13];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:timeLabel];
        
        messageView = [[UITextView alloc] initWithFrame:CGRectMake(10, 60, kiPhoneWidthPortrait-20, 60)];
        messageView.backgroundColor = [UIColor clearColor];
        messageView.editable = NO;
        messageView.selectable = NO;
        messageView.font = [UIFont fontWithName:[JPFont defaultFont] size:13];
        messageView.textContainerInset = UIEdgeInsetsZero;
        [self addSubview:messageView];
        
        _UIUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:kInterfaceRefreshInterval target:self selector:@selector(reloadTimeLabel) userInfo:nil repeats:YES];
    }
    return self;
}


- (void)reloadTimeLabel
{
    self.date = _date;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

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
    
    NSDate* now = [NSDate date];
    
    NSTimeInterval timePassed = [now timeIntervalSinceDate:date];
    
    if([NSDate hoursTotalWithTimeInterval:timePassed] < 9.0f && timePassed >= 0) //recent
    {
        timeLabel.text = [NSDate timeAgoStringWithTimeInterval:timePassed];
    }
    else
    {
        timeLabel.text = [date timeStringForTableCell];
        NSString* dayString = [NSString stringWithFormat:@", %@", [date dateStringForTableCell]];
        timeLabel.text = [timeLabel.text stringByAppendingString:dayString];
        [_UIUpdateTimer invalidate];
    }
    
}


- (void)setMessage:(NSString *)message
{
    _message = message;
    messageView.text = message;
}


- (void)setAvatarImgURL:(NSURL *)avatarImgURL
{
    _avatarImgURL = avatarImgURL;
    avatarView.imageUrl = avatarImgURL;
}


@end
