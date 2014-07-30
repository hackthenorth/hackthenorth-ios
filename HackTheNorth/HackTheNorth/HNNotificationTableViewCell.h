//
//  HNNotificationTableViewCell.h
//  HackTheNorth
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNAvatarView;
@interface HNNotificationTableViewCell : UITableViewCell
{
    HNAvatarView* avatarView;
    
    UILabel*     nameLabel;
    UILabel*     timeLabel;
    UILabel*     dayLabel;
    
    UITextView*  messageView;
    
    
}


@property (nonatomic, strong) UIImage* avatarImage;

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSDate*   date;
@property (nonatomic, strong) NSString* message;





@end
