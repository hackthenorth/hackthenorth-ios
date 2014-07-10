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

NSString* dateTextColor = @"0D7EA0";

@implementation HNNotificationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
        avatarView.image = [UIImage imageNamed:@"avatarIcon"];
        avatarView.layer.cornerRadius = avatarView.frame.size.width/2;
        avatarView.clipsToBounds = YES;
        [self addSubview:avatarView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 20, 200, 40)];
        nameLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:17];
        nameLabel.text = @"Anonymous";
        [self addSubview:nameLabel];
        
        
        messageView = [[UITextView alloc] initWithFrame:CGRectMake(10, 65, kiPhoneWidthPortrait-20, 60)];
        messageView.backgroundColor = [UIColor clearColor];
        messageView.editable = NO;
        messageView.selectable = NO;
        messageView.text = @"Empty Message";
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

- (void)setTime:(NSString *)time
{
    _time = time;
    timeLabel.text = time;
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
