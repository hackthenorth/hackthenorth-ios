//
//  HNNotificationTableViewCell.h
//  HackTheNorth
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNAvatarView, HNAutoresizingLabel;
@interface HNUpdatesTableViewCell : UITableViewCell
{
    HNAvatarView* avatarView;
    
    HNAutoresizingLabel*  nameLabel;
    UILabel*              timeLabel;

    UITextView*  messageView;
    
    NSTimer*    _UIUpdateTimer;
}


@property (nonatomic, strong) NSURL*    avatarImgURL;

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSDate*   date;
@property (nonatomic, strong) NSString* message;


+ (CGFloat)heightRequiredForString: (NSString*)string;


@end
