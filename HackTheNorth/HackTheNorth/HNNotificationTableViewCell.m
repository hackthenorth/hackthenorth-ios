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
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, 195, 40)];
        nameLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:18];
        nameLabel.text = @"Anonymous";
        [self addSubview:nameLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kiPhoneWidthPortrait - 60, 10, 50, 16)];
        timeLabel.text = @"12:00";
        timeLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:14];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:timeLabel];
        
        dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(kiPhoneWidthPortrait - 60, 26, 50, 16)];
        dayLabel.text = @"July 29";
        dayLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:14];
        dayLabel.textColor = [UIColor grayColor];
        dayLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:dayLabel];
        
        messageView = [[UITextView alloc] initWithFrame:CGRectMake(10, 55, kiPhoneWidthPortrait-20, 65)];
        messageView.backgroundColor = [UIColor clearColor];
        messageView.editable = NO;
        messageView.selectable = NO;
//        messageView.text = @"Empty Message";
        messageView.text = @"Most people have a natural talent for persuasion. The problem for many is that they wield it against themselves and convince themselves either that they don’t deserve success or that it’s unattainable for reasons beyond their control. But self-persuasion doesn’t need to be destructive. It can, with some effort, be converted to a constructive tool that helps you change your narrative from one of limitation to one of possibility. The key is to train yourself to think like an entrepreneur, one who sees potential even in problems, and to talk to yourself the same way you would talk to a friend: logically and encouragingly, with plenty of concrete examples.";
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
